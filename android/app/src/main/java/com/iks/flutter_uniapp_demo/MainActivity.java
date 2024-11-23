package com.iks.flutter_uniapp_demo;

import android.Manifest;
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
import com.iks.flutter_uniapp_demo.util.DownloadUtil;
import com.iks.flutter_uniapp_demo.util.UniAppUtil;

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

    @Override
    protected void onCreate(@Nullable Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        if (getFlutterEngine() != null) {
            getFlutterEngine().getPlugins().add(new QuickLoginFlutterPlugin());
        }
        DCSDKInitConfig.Builder builder = new DCSDKInitConfig.Builder();
        DCSDKInitConfig config = builder.setCapsule(true)
                .setMenuDefFontSize("16px")
                .setMenuDefFontColor("#2D2D2D")
                .setMenuDefFontWeight("normal")
                .setEnableBackground(false)
                .setMenuActionSheetItems(Collections.singletonList(new MenuActionSheetItem("关于", "about")))
                .build();
        DCUniMPSDK instance = DCUniMPSDK.getInstance();
        instance.initialize(this, config, isSuccess -> Log.e("unimp", "onInitFinished--"+isSuccess));
        // close uniAPP
        instance.setCapsuleCloseButtonClickCallBack(appId -> {
            IUniMP iUniMP = mUniMPCaches.get(appId);
            if (iUniMP != null && iUniMP.isRuning()) {
                Log.d("TAG", "closeButtonClicked: " + appId);
                iUniMP.closeUniMP();
                mUniMPCaches.remove(appId);
            }
        });
        checkPermission();
    }

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine);
        BinaryMessenger messenger = flutterEngine.getDartExecutor().getBinaryMessenger();
        MethodChannel uniMPMiniApps = new MethodChannel(messenger, "UniMP_mini_apps");
        uniMPMiniApps.setMethodCallHandler((call, res) -> {
            String method = call.method;
            System.out.println("---->" + method);
            if (Objects.equals(method, "open")) {
                openUniApp(call, res);
            } else {
                res.error("error_code", "error_message", null);
            }
        });
    }

    private void openUniApp(@NonNull MethodCall call, @NonNull MethodChannel.Result result) {
        String appId = call.argument("AppID");
        Boolean isRemote = call.argument("remote");
        if (Objects.equals(isRemote, true)) {
            String downloadBaseUri = call.argument("downloadBaseUri");
            String password = call.argument("password");
            Log.d(TAG, "openUniApp: " + password + "@" + downloadBaseUri);
            ActivityCompat.requestPermissions(MainActivity.this, new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE}, 1002);
            updateWgt(appId, password, downloadBaseUri);
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

    private void updateWgt(String appId, String password, String downloadPath) {
        final String wgtName = appId + ".wgt";
        Log.d(TAG, "updateWgt: " + downloadPath);
        File externalCacheDir = UniAppUtil.uniAppSavePath(MainActivity.this);
        Handler uiHandler = new Handler();
        DownloadUtil.get().download(MainActivity.this, downloadPath, externalCacheDir.getPath(), wgtName, new DownloadUtil.OnDownloadListener() {
            @Override
            public void onDownloadSuccess(File file) {
                Log.d(TAG, "onDownloadSuccess: " + file.getAbsoluteFile());
                UniMPReleaseConfiguration uniMPReleaseConfiguration = new UniMPReleaseConfiguration();
                uniMPReleaseConfiguration.wgtPath = file.getPath();
                uniMPReleaseConfiguration.password = password;
                uiHandler.post(new Runnable() {
                    @Override
                    public void run() {
                        Log.d(TAG, "updateWgt success: " + downloadPath);
                        DCUniMPSDK.getInstance().releaseWgtToRunPath(appId, uniMPReleaseConfiguration, new IUniMPReleaseCallBack() {
                            @Override
                            public void onCallBack(int code, Object pArgs) {
                                Log.d(TAG, "onCallBack success: " + code);
                                if(code ==1) {
                                    //释放wgt完成
                                    try {
                                        UniMPOpenConfiguration uniMPOpenConfiguration = new UniMPOpenConfiguration();
                                        uniMPOpenConfiguration.extraData.put("darkmode", "auto");
                                        DCUniMPSDK.getInstance().openUniMP(MainActivity.this, appId,uniMPOpenConfiguration);
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

    /**
     * 检查并申请权限
     */
    public void checkPermission() {
        int targetSdkVersion = 0;
        String[] PermissionString={Manifest.permission.WRITE_EXTERNAL_STORAGE};
        try {
            final PackageInfo info = this.getPackageManager().getPackageInfo(this.getPackageName(), 0);
            targetSdkVersion = info.applicationInfo.targetSdkVersion;//获取应用的Target版本
        } catch (PackageManager.NameNotFoundException e) {
            e.printStackTrace();
        }

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            //Build.VERSION.SDK_INT是获取当前手机版本 Build.VERSION_CODES.M为6.0系统
            //如果系统>=6.0
            if (targetSdkVersion >= Build.VERSION_CODES.M) {
                //第 1 步: 检查是否有相应的权限
                boolean isAllGranted = checkPermissionAllGranted(PermissionString);
                if (isAllGranted) {
                    Log.e("err","所有权限已经授权！");
                    return;
                }
                // 一次请求多个权限, 如果其他有权限是已经授予的将会自动忽略掉
                ActivityCompat.requestPermissions(this, PermissionString, 1);
            }
        }
    }

    /**
     * 检查是否拥有指定的所有权限
     */
    private boolean checkPermissionAllGranted(String[] permissions) {
        for (String permission : permissions) {
            if (ContextCompat.checkSelfPermission(this, permission) != PackageManager.PERMISSION_GRANTED) {
                // 只要有一个权限没有被授予, 则直接返回 false
                Log.e(TAG,"权限"+permission+"没有授权");
                return false;
            }
        }
        return true;
    }

}
