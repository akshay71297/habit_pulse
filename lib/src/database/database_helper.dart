import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:habit_pulse/src/core/constants/app_constants.dart';
import 'package:habit_pulse/src/core/services/logger_service.dart';

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database? _database;
  static bool _ffiInitialized = false;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // Use FFI on Linux/Windows/Desktop
    if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
      if (!_ffiInitialized) {
        sqfliteFfiInit();
        databaseFactory = databaseFactoryFfi;
        _ffiInitialized = true;
        LoggerService.info('DatabaseHelper: initialized FFI for desktop');
      }
    }

    final dbPath = await getDatabasesPath();
    final path = join(dbPath, AppConstants.dbName);

    LoggerService.info('Initializing database at $path');

    return openDatabase(
      path,
      version: AppConstants.dbVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: (db) async {
        await db.execute('PRAGMA foreign_keys = ON');
      },
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    LoggerService.info('Creating database tables v$version');

    await db.execute('''
      CREATE TABLE habits (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        description TEXT NOT NULL,
        type TEXT NOT NULL,
        is_active INTEGER NOT NULL DEFAULT 1,
        pavlok_stimulus_type TEXT,
        stimulus_value INTEGER NOT NULL DEFAULT 50,
        current_streak INTEGER NOT NULL DEFAULT 0,
        best_streak INTEGER NOT NULL DEFAULT 0,
        total_completions INTEGER NOT NULL DEFAULT 0,
        last_completed_at TEXT,
        created_at TEXT,
        updated_at TEXT
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_habits_type ON habits(type)
    ''');

    await db.execute('''
      CREATE TABLE scheduled_stimuli (
        id TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        stimulus_type TEXT NOT NULL,
        stimulus_value INTEGER NOT NULL,
        scheduled_time TEXT NOT NULL,
        is_recurring INTEGER NOT NULL DEFAULT 0,
        repeat_unit TEXT,
        repeat_interval INTEGER NOT NULL DEFAULT 1,
        end_date TEXT,
        is_active INTEGER NOT NULL DEFAULT 1,
        associated_habit_id TEXT,
        executed INTEGER NOT NULL DEFAULT 0,
        last_executed_at TEXT,
        created_at TEXT,
        FOREIGN KEY (associated_habit_id) REFERENCES habits(id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_scheduled_stimuli_time ON scheduled_stimuli(scheduled_time)
    ''');
    await db.execute('''
      CREATE INDEX idx_scheduled_stimuli_active ON scheduled_stimuli(is_active)
    ''');

    await db.execute('''
      CREATE TABLE stimulus_logs (
        id TEXT PRIMARY KEY,
        stimulus_type TEXT NOT NULL,
        stimulus_value INTEGER NOT NULL,
        executed_at TEXT NOT NULL,
        success INTEGER NOT NULL DEFAULT 1,
        error_message TEXT,
        habit_id TEXT,
        schedule_id TEXT,
        from_offline_queue INTEGER NOT NULL DEFAULT 0
      )
    ''');

    await db.execute('''
      CREATE INDEX idx_logs_executed_at ON stimulus_logs(executed_at)
    ''');

    await db.execute('''
      CREATE TABLE pavlok_settings (
        id INTEGER PRIMARY KEY CHECK(id = 1),
        api_token TEXT,
        is_enabled INTEGER NOT NULL DEFAULT 1,
        user_email TEXT,
        last_tested_at TEXT,
        last_test_success INTEGER NOT NULL DEFAULT 0,
        last_error_message TEXT
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    LoggerService.info('Upgrading database from v$oldVersion to v$newVersion');
    // Migrations will be added here in future versions.
  }

  Future<void> close() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
      LoggerService.info('Database closed');
    }
  }
}
