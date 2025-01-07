package com.iks.flutter_uniapp_demo.uni;

import android.content.Context;
import android.os.Handler;
import android.util.Log;

import com.alibaba.fastjson.JSON;

import org.json.JSONException;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

import io.dcloud.feature.sdk.DCSDKInitConfig;
import io.dcloud.feature.sdk.DCUniMPSDK;
import io.dcloud.feature.sdk.Interface.IUniMP;
import io.dcloud.feature.sdk.MenuActionSheetItem;
import io.dcloud.feature.unimp.config.UniMPOpenConfiguration;
import io.dcloud.feature.unimp.config.UniMPReleaseConfiguration;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodChannel;

public class UniApp {

    private static final String TAG = UniApp.class.getName();

    private static volatile UniApp _instance;

    private final Map<String, IUniMP> mUniMPCaches = new HashMap<>();

    public void openUniApp(Context context, String appId) {
        openUniApp(context, appId, null);
    }

    private void openUniApp(Context context, String appId, UniMPReleaseConfiguration configuration, UniMPOpenConfiguration openConfiguration) {
        Handler uiHandler = new Handler();
        uiHandler.post(() -> DCUniMPSDK.getInstance().releaseWgtToRunPath(appId, configuration, (code, pArgs) -> {
            if (code == 1) {
                //释放wgt完成
                try {
                    openUniApp(context, appId, openConfiguration);
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            } else {
                //释放wgt失败
            }
        }));
    }

    public void openUniApp(Context context, String appId, File appResource, String password)  {
        UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
        try {
            uniMPOpenConfiguration.extraData.put("darkmode", "auto");
        } catch (JSONException e) {
            Log.e(TAG, "openUniApp: ", e);
        }
        openUniApp(context, appId, appResource, password, uniMPOpenConfiguration);
    }

    public void openUniApp(Context context, String appId, File appResource, String password,UniMPOpenConfiguration uniMPOpenConfiguration)  {
        UniMPReleaseConfiguration configuration = new UniMPReleaseConfiguration();
        configuration.wgtPath = appResource.getPath();
        configuration.password = password;
        openUniApp(context, appId, configuration, uniMPOpenConfiguration);
    }

    void openUniApp(Context context, String appId, UniMPOpenConfiguration configuration){
        IUniMP iUniMP = null;
        try {
            iUniMP = DCUniMPSDK.getInstance().openUniMP(context, appId, configuration);
            mUniMPCaches.put(appId, iUniMP);
        } catch (Exception e) {
            Log.e(TAG, "openUniApp " + appId + " error ", e);
        }
    }

    public static UniApp instance(FlutterEngine flutterEngine, Context context) {
        if (_instance == null) {
            synchronized (UniApp.class) {
                if (_instance == null){
                    _instance = new UniApp(flutterEngine, context);
                }
            }
        }
        return _instance;
    }
    private UniApp(FlutterEngine flutterEngine, Context context) {
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel uniMPMiniApps = new MethodChannel(messenger, "UniMP_mini_apps");
        uniMPMiniApps.setMethodCallHandler((call, res) -> {
            String method = call.method;
            if (Objects.equals(method, "open")) {
                String appId = call.argument("AppID");
                String pagePath = call.argument("pagePath");
                UniMPOpenConfiguration configuration = new UniMPOpenConfiguration();
                configuration.path = pagePath;
                configuration.redirectPath = pagePath;
                Log.i(TAG, "open uniApp " + appId + pagePath);
                try {
                    String wgtFile = call.argument("wgtFile");
                    if (wgtFile != null) {
                        String password = call.argument("password");
                        openUniApp(context, appId, new File(wgtFile), password, configuration);
                    } else {
                        openUniApp(context, appId, configuration);
                    }
                } catch (Exception e) {
                    throw new RuntimeException(e);
                }
            }  else if ("push".equalsIgnoreCase(method)) {
                // 主动给 uniApp 推送数据
                String appId = call.argument("AppID");
                IUniMP iUniMP = mUniMPCaches.get(appId);
                if (iUniMP == null) {
                    Log.w(TAG, "UniApp " + appId + " is not running ");
                }else {
                    String eventId = call.argument("eventId");
                    String data = call.argument("data");
                    iUniMP.sendUniMPEvent(eventId, data);
                }
            } else {
                res.error("error_code", "error_message", null);
            }
        });
        _initConfig(context, flutterEngine);
    }

    public void closeUniApp(String appId){
        IUniMP iUniMP = mUniMPCaches.get(appId);
        if (iUniMP == null) {
            Log.d(TAG, "closeUniApp: appId is not start");
        }else {
            iUniMP.closeUniMP();
            mUniMPCaches.remove(appId);
        }
    }

    private void _initConfig(Context context,FlutterEngine flutterEngine){
        DCSDKInitConfig.Builder builder = new DCSDKInitConfig.Builder();
        DCSDKInitConfig config = builder.setCapsule(true)
                .setMenuDefFontSize("16px")
                .setMenuDefFontColor("#2D2D2D")
                .setMenuDefFontWeight("normal")
                .setEnableBackground(false)
                .setMenuActionSheetItems(Collections.singletonList(new MenuActionSheetItem("关于", "about")))
                .build();
        DCUniMPSDK instance = DCUniMPSDK.getInstance();
        instance.initialize(context, config, isSuccess -> Log.e("unimp", "onInitFinished--"+isSuccess));
        instance.setCapsuleCloseButtonClickCallBack(this::closeUniApp);
    }



}