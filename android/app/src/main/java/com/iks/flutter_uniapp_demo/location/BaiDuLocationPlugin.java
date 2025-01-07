package com.iks.flutter_uniapp_demo.location;

import android.content.Context;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;

public class BaiDuLocationPlugin implements FlutterPlugin, MethodChannel.MethodCallHandler {

    private final String METHOD_CHANNEL = "quicklogin_flutter_plugin";
    private final String EVENT_CHANNEL = "yd_quicklogin_flutter_event_channel";

    private Context context;

    private MethodChannel channel;
    private EventChannel eventChannel;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding binding) {
        context = binding.getApplicationContext();
        channel = new MethodChannel(binding.getBinaryMessenger(), METHOD_CHANNEL);
        channel.setMethodCallHandler(this);
        eventChannel = new EventChannel(binding.getBinaryMessenger(), EVENT_CHANNEL);
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {

    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {

    }
}
