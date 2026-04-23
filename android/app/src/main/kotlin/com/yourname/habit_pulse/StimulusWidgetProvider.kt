package com.yourname.habit_pulse

import android.app.PendingIntent
import android.appwidget.AppWidgetManager
import android.appwidget.AppWidgetProvider
import android.content.ComponentName
import android.content.Context
import android.content.Intent
import android.database.sqlite.SQLiteDatabase
import android.os.Handler
import android.os.Looper
import android.widget.RemoteViews
import android.widget.Toast
import org.json.JSONObject
import java.net.HttpURLConnection
import java.net.URL
import java.util.concurrent.Executors

class StimulusWidgetProvider : AppWidgetProvider() {

    companion object {
        const val ACTION_VIBE = "com.yourname.habit_pulse.ACTION_VIBE"
        const val ACTION_ZAP = "com.yourname.habit_pulse.ACTION_ZAP"
        const val ACTION_BEEP = "com.yourname.habit_pulse.ACTION_BEEP"
        const val PREFS_NAME = "FlutterSharedPreferences"
        const val PREFS_KEY_TOKEN = "pavlok_api_token"
        const val DB_NAME = "habit_pulse.db"
        const val PAVLOK_API_URL = "https://api.pavlok.com/api/v5/stimulus/send"
        const val DEFAULT_INTENSITY = 50

        private val executor = Executors.newSingleThreadExecutor()
        private val mainHandler = Handler(Looper.getMainLooper())
    }

    override fun onUpdate(context: Context, appWidgetManager: AppWidgetManager, appWidgetIds: IntArray) {
        for (appWidgetId in appWidgetIds) {
            updateAppWidget(context, appWidgetManager, appWidgetId)
        }
    }

    override fun onReceive(context: Context, intent: Intent) {
        super.onReceive(context, intent)
        when (intent.action) {
            ACTION_VIBE -> sendStimulus(context, "vibe")
            ACTION_ZAP -> sendStimulus(context, "zap")
            ACTION_BEEP -> sendStimulus(context, "beep")
        }
    }

    private fun updateAppWidget(context: Context, appWidgetManager: AppWidgetManager, appWidgetId: Int) {
        val views = RemoteViews(context.packageName, R.layout.stimulus_widget)

        views.setOnClickPendingIntent(R.id.btn_vibe, getPendingIntent(context, ACTION_VIBE))
        views.setOnClickPendingIntent(R.id.btn_zap, getPendingIntent(context, ACTION_ZAP))
        views.setOnClickPendingIntent(R.id.btn_beep, getPendingIntent(context, ACTION_BEEP))

        appWidgetManager.updateAppWidget(appWidgetId, views)
    }

    private fun getPendingIntent(context: Context, action: String): PendingIntent {
        val intent = Intent(context, StimulusWidgetProvider::class.java).apply {
            this.action = action
        }
        return PendingIntent.getBroadcast(
            context,
            action.hashCode(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )
    }

    private fun getToken(context: Context): String? {
        // Try 1: SharedPreferences (fast path, written by Flutter shared_preferences package)
        try {
            val prefs = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)
            val token = prefs.getString(PREFS_KEY_TOKEN, null)
            if (!token.isNullOrBlank()) return token
        } catch (_: Exception) { }

        // Try 2: Read directly from the app's SQLite database
        // This works even if the Flutter app has never synced to SharedPreferences
        try {
            val dbPath = context.getDatabasePath(DB_NAME).absolutePath
            val db = SQLiteDatabase.openDatabase(dbPath, null, SQLiteDatabase.OPEN_READONLY)
            db.use {
                val cursor = it.rawQuery(
                    "SELECT api_token FROM pavlok_settings WHERE id = 1 LIMIT 1",
                    null
                )
                cursor.use { c ->
                    if (c.moveToFirst()) {
                        val token = c.getString(0)
                        if (!token.isNullOrBlank()) return token
                    }
                }
            }
        } catch (_: Exception) { }

        return null
    }

    private fun sendStimulus(context: Context, type: String) {
        val token = getToken(context)

        if (token.isNullOrBlank()) {
            showToast(context, "No API token. Open HabitPulse and save your Pavlok token.")
            return
        }

        showToast(context, "Sending ${type.uppercase()}...")

        executor.execute {
            try {
                val url = URL(PAVLOK_API_URL)
                val conn = url.openConnection() as HttpURLConnection
                conn.requestMethod = "POST"
                conn.setRequestProperty("Content-Type", "application/json")
                conn.setRequestProperty("Accept", "application/json")
                conn.setRequestProperty("Authorization", "Bearer $token")
                conn.connectTimeout = 15000
                conn.readTimeout = 15000
                conn.doOutput = true

                val payload = JSONObject().apply {
                    put("stimulus", JSONObject().apply {
                        put("stimulusType", type)
                        put("stimulusValue", DEFAULT_INTENSITY)
                    })
                }

                conn.outputStream.use { os ->
                    os.write(payload.toString().toByteArray(Charsets.UTF_8))
                }

                val responseCode = conn.responseCode
                val success = responseCode in 200..299

                mainHandler.post {
                    if (success) {
                        showToast(context, "${type.uppercase()} sent!")
                    } else {
                        val errorMsg = try {
                            conn.errorStream?.bufferedReader()?.use { it.readText() } ?: "HTTP $responseCode"
                        } catch (_: Exception) {
                            "HTTP $responseCode"
                        }
                        showToast(context, "Failed: $errorMsg")
                    }
                }
                conn.disconnect()
            } catch (e: Exception) {
                mainHandler.post {
                    showToast(context, "Error: ${e.message}")
                }
            }
        }
    }

    private fun showToast(context: Context, message: String) {
        Toast.makeText(context, message, Toast.LENGTH_SHORT).show()
    }
}
