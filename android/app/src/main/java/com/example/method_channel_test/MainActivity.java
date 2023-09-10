package com.example.method_channel_test;

import android.graphics.Color;
import android.view.Gravity;
import android.widget.Button;
import android.widget.FrameLayout;
import android.os.Bundle;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.flutter_method_channel/method";
    private FrameLayout nativeLayout;  // <--- ADD THIS LINE

    @Override
    public void configureFlutterEngine(FlutterEngine flutterEngine) {
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
                .setMethodCallHandler(new MethodCallHandler() {
                    @Override
                    public void onMethodCall(MethodCall call, Result result) {
                        if (call.method.equals("test")) {
                            showNativeView();
                            result.success(null);
                        } else {
                            result.notImplemented();
                        }
                    }
                });
    }

    private void showNativeView() {
        final Button nativeButton = new Button(this);
        nativeButton.setText("Back to Flutter");
        nativeButton.setOnClickListener(view -> {
            FrameLayout rootView = findViewById(android.R.id.content);
            rootView.removeView(nativeLayout);  // <--- UPDATE THIS LINE
        });

        // Create layout parameters for the Button
        FrameLayout.LayoutParams buttonLayoutParams = new FrameLayout.LayoutParams(  // <--- UPDATE THIS LINE
                FrameLayout.LayoutParams.WRAP_CONTENT,  // <--- UPDATE THIS LINE
                FrameLayout.LayoutParams.WRAP_CONTENT,  // <--- UPDATE THIS LINE
                Gravity.CENTER
        );

        // Create layout parameters for the FrameLayout
        FrameLayout.LayoutParams layoutParams = new FrameLayout.LayoutParams(  // <--- UPDATE THIS LINE
                FrameLayout.LayoutParams.MATCH_PARENT,  // <--- UPDATE THIS LINE
                FrameLayout.LayoutParams.MATCH_PARENT  // <--- UPDATE THIS LINE
        );

        // Create a new FrameLayout
        nativeLayout = new FrameLayout(this);
        nativeLayout.setLayoutParams(layoutParams);
        nativeLayout.setBackgroundColor(Color.WHITE);
        nativeLayout.addView(nativeButton, buttonLayoutParams);

        // Add the FrameLayout to the existing layout
        FrameLayout rootView = findViewById(android.R.id.content);
        rootView.addView(nativeLayout);
    }
}
