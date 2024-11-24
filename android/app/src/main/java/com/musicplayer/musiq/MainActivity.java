package com.musicplayer.musiq;

//import io.flutter.embedding.android.FlutterActivity;
//
//public class MainActivity extends FlutterActivity {
//
//}


import androidx.annotation.NonNull;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

import android.database.Cursor;
import android.provider.MediaStore;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "audio";  // Channel name used in Flutter

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(
                        (call, result) -> {
                            if (call.method.equals("getAudios")) {
                                List<HashMap<String, String>> audioList = fetchAudioFiles();
                                result.success(audioList);
                            } else {
                                result.notImplemented();
                            }
                        }
                );
    }

    // Function to fetch audio files from device storage
    private List<HashMap<String, String>> fetchAudioFiles() {
        List<HashMap<String, String>> audioList = new ArrayList<>();
        Cursor cursor = getContentResolver().query(
                MediaStore.Audio.Media.EXTERNAL_CONTENT_URI,
                null,
                null,
                null,
                null
        );

        if (cursor != null) {
            while (cursor.moveToNext()) {
                String title = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.TITLE));
                String data = cursor.getString(cursor.getColumnIndex(MediaStore.Audio.Media.DATA));

                HashMap<String, String> audioData = new HashMap<>();
                audioData.put("title", title);
                audioData.put("path", data);

                audioList.add(audioData);
            }
            cursor.close();  // Close the cursor to free resources
        }

        return audioList;  // Return the list of audio files
    }
}
