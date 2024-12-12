package com.iks.flutter_uniapp_demo;

import android.Manifest;
import android.content.Intent;
import android.content.pm.PackageInfo;
import android.content.pm.PackageManager;
import android.os.Build;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;
import androidx.core.app.ActivityCompat;
import androidx.core.content.ContextCompat;

import com.iks.flutter_uniapp_demo.plugs.QuickLoginFlutterPlugin;
import com.iks.flutter_uniapp_demo.uni.UniApp;
import com.iks.flutter_uniapp_demo.uni.func.FlutterForwardFuncEvent;
import com.iks.flutter_uniapp_demo.uni.func.FuncEvent;
import com.iks.flutter_uniapp_demo.uni.func.TestFuncEvent;
import com.iks.flutter_uniapp_demo.util.DownloadUtil;
import com.iks.flutter_uniapp_demo.util.UniAppUtil;

import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.stream.Collectors;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IDCUniMPOnCapsuleCloseButtontCallBack;
import io.dcloud.feature.sdk.Interface.IDCUniMPPreInitCallback;
import io.dcloud.feature.sdk.Interface.IUniMP;
import io.dcloud.feature.sdk.Interface.IUniMPOnCloseCallBack;
import io.dcloud.feature.sdk.MenuActionSheetItem;
import io.dcloud.feature.unimp.config.IUniMPReleaseCallBack;
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration;
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration;
import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.embedding.engine.plugins.PluginRegistry;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {
    private static final String TAG = "MainActivity";

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        Log.d(TAG, "onCreate FlutterActivity");
        super.onCreate(savedInstanceState);
        if (getFlutterEngine() != null) {
            getFlutterEngine().getPlugins().add(new QuickLoginFlutterPlugin());
        }
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        UniApp.instance(flutterEngine, this);
        registerEvents(flutterEngine, DCUniMPSDK.getInstance());
    }

    private void registerEvents(FlutterEngine flutterEngine, DCUniMPSDK uniInstance) {
        List<FuncEvent> funcEvents = new ArrayList<>(Arrays.asList(
                new TestFuncEvent(),
                new FlutterForwardFuncEvent(flutterEngine.getDartExecutor())
        ));
        Map<String, FuncEvent> eventMap = new HashMap<>();
        for (FuncEvent funcEvent : funcEvents) {
            FuncEvent res = eventMap.put(funcEvent.getEventName(), funcEvent);
            Log.i(TAG, "register event handler, eventName=" + funcEvent.getEventName());
            if (res != null) {
                Log.w(TAG, "repeat event name " + funcEvent.getEventName());
            }
        }
        uniInstance.setOnUniMPEventCallBack((appId, event, data, callback) -> {
            FuncEvent funcEvent = eventMap.get(event);
            if (funcEvent == null) {
                Log.i(TAG, "not match event handler, eventName=" + event);
                callback.invoke(404);
            } else {
                Log.i(TAG, "receive event handler by" + funcEvent.getClass());
                funcEvent.onUniMPEventReceive(appId, data, callback);
            }
        });
    }

}
