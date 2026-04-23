import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:retry/retry.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';
import 'package:habit_pulse/src/models/pavlok_settings.dart';

/// Result wrapper for Pavlok API calls to enforce explicit handling.
sealed class PavlokResult<T> {
  const PavlokResult();
}

class PavlokSuccess<T> extends PavlokResult<T> {
  final T data;
  const PavlokSuccess(this.data);
}

class PavlokError<T> extends PavlokResult<T> {
  final String message;
  final bool isRetryable;
  const PavlokError(this.message, {this.isRetryable = false});
}

/// Service for interacting with the Pavlok API.
/// Designed for maximum stability: retries, timeouts, offline detection,
/// and detailed logging.
class PavlokApiService {
  late Dio _dio;
  PavlokSettings? _settings;
  final _offlineQueue = <_QueuedStimulus>[];
  bool _isOnline = true;

  PavlokApiService() {
    _dio = Dio(BaseOptions(
      baseUrl: AppConstants.pavlokBaseUrl,
      connectTimeout: const Duration(milliseconds: AppConstants.pavlokConnectTimeoutMs),
      receiveTimeout: const Duration(milliseconds: AppConstants.pavlokReceiveTimeoutMs),
      headers: {'Accept': 'application/json', 'Content-Type': 'application/json'},
    ));

    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        if (_settings?.apiToken != null && _settings!.apiToken.isNotEmpty) {
          options.headers['Authorization'] = 'Bearer ${_settings!.apiToken}';
        }
        LoggerService.info('Pavlok API request: ${options.method} ${options.path}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        LoggerService.info('Pavlok API response: ${response.statusCode} ${response.requestOptions.path}');
        handler.next(response);
      },
      onError: (error, handler) {
        LoggerService.error('Pavlok API error: ${error.message}', error, error.stackTrace);
        handler.next(error);
      },
    ));

    Connectivity().onConnectivityChanged.listen((results) {
      final hasConnection = results.any((r) => r != ConnectivityResult.none);
      if (hasConnection && !_isOnline) {
        _isOnline = true;
        LoggerService.info('Connectivity restored; flushing offline queue (${_offlineQueue.length} items)');
        _flushOfflineQueue();
      } else if (!hasConnection) {
        _isOnline = false;
        LoggerService.warning('Connectivity lost; stimuli will be queued');
      }
    });
  }

  void updateSettings(PavlokSettings settings) {
    _settings = settings;
    LoggerService.info('PavlokApiService: settings updated');
  }

  Future<PavlokResult<void>> testConnection() async {
    if (_settings?.apiToken.isEmpty ?? true) {
      return const PavlokError('No API token configured');
    }
    try {
      final response = await retry(
        () => _dio.get('/user/'),
        retryIf: (e) => e is DioException && _isRetryable(e),
        maxAttempts: AppConstants.pavlokMaxRetries,
        delayFactor: const Duration(seconds: 1),
      );
      if (response.statusCode == 200) {
        return const PavlokSuccess(null);
      }
      return PavlokError('Unexpected status: ${response.statusCode}');
    } on DioException catch (e) {
      return PavlokError(_formatDioError(e), isRetryable: _isRetryable(e));
    } catch (e, st) {
      LoggerService.error('Test connection failed', e, st);
      return PavlokError('Connection failed: $e');
    }
  }

  Future<PavlokResult<void>> sendStimulus({
    required StimulusType type,
    required int value,
    String? habitId,
    String? scheduleId,
  }) async {
    if (_settings?.apiToken.isEmpty ?? true) {
      return const PavlokError('No API token configured');
    }

    final payload = {
      'stimulus': {
        'stimulusType': type.name,
        'stimulusValue': value.clamp(AppConstants.minStimulusValue, AppConstants.maxStimulusValue),
      }
    };

    if (!_isOnline) {
      _offlineQueue.add(_QueuedStimulus(
        type: type,
        value: value,
        habitId: habitId,
        scheduleId: scheduleId,
        payload: payload,
      ));
      LoggerService.info('Stimulus queued offline: ${type.name}');
      return const PavlokError('Device offline; stimulus queued for later', isRetryable: true);
    }

    return _executeStimulus(
      payload: payload,
      type: type,
      value: value,
      habitId: habitId,
      scheduleId: scheduleId,
    );
  }

  Future<PavlokResult<void>> _executeStimulus({
    required Map<String, dynamic> payload,
    required StimulusType type,
    required int value,
    String? habitId,
    String? scheduleId,
    bool fromQueue = false,
  }) async {
    try {
      await retry(
        () => _dio.post('/stimulus/send', data: payload),
        retryIf: (e) => e is DioException && _isRetryable(e),
        maxAttempts: AppConstants.pavlokMaxRetries,
        delayFactor: const Duration(seconds: 1),
      );
      LoggerService.info('Stimulus sent: ${type.name} ($value)');
      return const PavlokSuccess(null);
    } on DioException catch (e) {
      final err = PavlokError(_formatDioError(e), isRetryable: _isRetryable(e));
      if (err.isRetryable) {
        _offlineQueue.add(_QueuedStimulus(
          type: type, value: value, habitId: habitId, scheduleId: scheduleId, payload: payload,
        ));
      }
      return err;
    } catch (e, st) {
      LoggerService.error('Stimulus failed', e, st);
      return PavlokError('Failed to send stimulus: $e');
    }
  }

  Future<void> _flushOfflineQueue() async {
    while (_offlineQueue.isNotEmpty) {
      final item = _offlineQueue.removeAt(0);
      await _executeStimulus(
        payload: item.payload,
        type: item.type,
        value: item.value,
        habitId: item.habitId,
        scheduleId: item.scheduleId,
        fromQueue: true,
      );
      await Future.delayed(const Duration(milliseconds: 500));
    }
  }

  bool _isRetryable(DioException e) {
    return e.type == DioExceptionType.connectionTimeout ||
        e.type == DioExceptionType.receiveTimeout ||
        e.type == DioExceptionType.sendTimeout ||
        e.response?.statusCode == 429 ||
        (e.response?.statusCode ?? 0) >= 500;
  }

  String _formatDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        return 'Request timed out. Check your connection.';
      case DioExceptionType.badResponse:
        final status = e.response?.statusCode;
        final data = e.response?.data;
        if (status == 401) return 'Unauthorized. Check your API token.';
        if (status == 429) return 'Rate limited. Please wait.';
        if (data is Map && data['message'] != null) return data['message'].toString();
        return 'Server error ($status)';
      case DioExceptionType.connectionError:
        return 'No internet connection.';
      default:
        return e.message ?? 'Unknown network error';
    }
  }
}

class _QueuedStimulus {
  final StimulusType type;
  final int value;
  final String? habitId;
  final String? scheduleId;
  final Map<String, dynamic> payload;

  _QueuedStimulus({
    required this.type,
    required this.value,
    this.habitId,
    this.scheduleId,
    required this.payload,
  });
}
