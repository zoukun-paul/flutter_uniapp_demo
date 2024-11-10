package com.iks.flutter_uniapp_demo;

import android.os.Bundle;
import android.os.Handler;
import android.util.Log;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

import com.iks.flutter_uniapp_demo.util.DownloadUtil;

import java.io.File;
import java.util.Collections;
import java.util.HashMap;
import java.util.Objects;

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
import io.flutter.plugin.common.BinaryMessenger;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugins.GeneratedPluginRegistrant;

public class MainActivity extends FlutterActivity {

    private static final String TAG = "MainActivity";

    HashMap<String, IUniMP> mUniMPCaches = new HashMap<>();

    protected void onStart() {
        super.onStart();
        Log.d(TAG, "=================>onStart: ");
    }

    protected void onResume() {
        super.onResume();
        Log.d(TAG, "=================>onResume\n: ");
    }

    protected void onPause() {
        super.onPause();
        Log.d(TAG, "=================>onPause\n: ");
    }
    protected void onStop() {
        super.onStop();
        Log.d(TAG, "=================>onStop\n: ");
    }
    protected void onDestroy() {
        super.onDestroy();
        Log.d(TAG, "=================>onDestroy\n: ");
    }


    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        DCSDKInitConfig.Builder builder = new DCSDKInitConfig.Builder();
        DCSDKInitConfig config = builder.setCapsule(true)
                .setMenuDefFontSize("16px")
                .setMenuDefFontColor("#2D2D2D")
                .setMenuDefFontWeight("normal")
                .setEnableBackground(false)
                .setMenuActionSheetItems(Collections.singletonList(new MenuActionSheetItem("关于", "about")))
                .build();
        DCUniMPSDK instance = DCUniMPSDK.getInstance();
        instance.initialize(this, config, new IDCUniMPPreInitCallback() {
            @Override
            public void onInitFinished(boolean isSuccess) {
                Log.e("unimp", "onInitFinished-----------"+isSuccess);
            }
        });
        // close uniAPP
        instance.setCapsuleCloseButtonClickCallBack(new IDCUniMPOnCapsuleCloseButtontCallBack() {
            @Override
            public void closeButtonClicked(String appId) {
                IUniMP iUniMP = mUniMPCaches.get(appId);
                if (iUniMP != null && iUniMP.isRuning()) {
                    Log.d("TAG", "closeButtonClicked: " + appId);
                    iUniMP.closeUniMP();
                    mUniMPCaches.remove(appId);
                }
            }
        });
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();

        MethodChannel nativeRecvMsg = new MethodChannel(messenger, "native_msg");
        nativeRecvMsg.setMethodCallHandler((call, res) -> {
            String method = call.method;
            System.out.println("---->" + method);
            if (Objects.equals(method, "open")) {
                openUniApp(call, res);
                    break;
                case "close":
                    String appId = call.argument("AppID");
                    IUniMP iUniMP = mUniMPCaches.get(appId);
                    if (iUniMP != null && iUniMP.isRuning()) {
                        iUniMP.closeUniMP();
                        mUniMPCaches.remove(appId);
                    }
                    break;
                case "send_to_uniapp":


            }
        });
        

        MethodChannel uniAppRecvMsg = new MethodChannel(messenger, "uniapp_msg");
        uniAppRecvMsg.setMethodCallHandler((call, res) -> {
            String method = call.method;
            String appId = call.argument("AppID");
            IUniMP iUniMP = mUniMPCaches.get(appId);
            if (iUniMP == null) {
                System.out.println("----> iUniMP is null, Appid: " + appId);
                return;
            }
            String event = call.argument("event");
            System.out.println("---->" + method + "Appid: " + appId + "event: " + event);
            iUniMP.sendUniMPEvent(event, call.arguments);
        });
    }

    private void openUniApp(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String appId = call.argument("AppID");
        Boolean isRemote = call.argument("remote");
        if (Objects.equals(isRemote, true)) {
            updateWgt(appId);
            return;
        }
        System.out.println("open uniApp: " + appId);
        try {
            // 启动内置的 uniAPP

            IUniMP iUniMP = DCUniMPSDK.getInstance().openUniMP(this, appId);
            mUniMPCaches.put(appId, iUniMP);
        } catch (Exception e) {
            // TODO ERROR Handle
            Log.e("error", e.getMessage());
            e.printStackTrace();
        }

    }

    private void updateWgt(String appId) {
        final String wgtName = appId + ".wgt";
        final String wgtUrl = "https://native-res.dcloud.net.cn/unimp-sdk/" + wgtName;
        String downFilePath = getExternalCacheDir().getPath();
        Handler uiHandler = new Handler();

        DownloadUtil.get().download(MainActivity.this, wgtUrl, downFilePath, wgtName, new DownloadUtil.OnDownloadListener() {

            @Override
            public void onDownloadSuccess(File file) {


                UniMPReleaseConfiguration uniMPReleaseConfiguration = new UniMPReleaseConfiguration();
                uniMPReleaseConfiguration.wgtPath = file.getPath();
                uniMPReleaseConfiguration.password = "789456123";

                uiHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        DCUniMPSDK.getInstance().releaseWgtToRunPath("__UNI__7AEA00D", uniMPReleaseConfiguration, new IUniMPReleaseCallBack() {
                            @Override
                            public void onCallBack(int code, Object pArgs) {
                                if(code ==1) {
                                    //释放wgt完成
                                    try {
                                        UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
                                        uniMPOpenConfiguration.extraData.put("darkmode", "auto");
                                        DCUniMPSDK.getInstance().openUniMP(MainActivity.this, "__UNI__7AEA00D",uniMPOpenConfiguration);
                                    } catch (Exception e) {
                                        e.printStackTrace();
                                    }
                                } else{
                                    //释放wgt失败
                                }
                            }
                        });
                    }
                });


            }

            @Override
            public void onDownloading(int progress) {

            }

            @Override
            public void onDownloadFailed() {
                Log.e("unimp", "downFilePath  ===  onDownloadFailed");
            }
        });
    }

}
