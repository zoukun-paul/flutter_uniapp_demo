package com.iks.flutter_uniapp_demo.location;

import static android.Manifest.permission.ACCESS_COARSE_LOCATION;

import android.app.Notification;
import android.content.Context;
import android.content.pm.PackageManager;
import android.util.Log;

import com.baidu.location.BDAbstractLocationListener;
import com.baidu.location.BDLocation;
import com.baidu.location.LocationClient;
import com.baidu.location.LocationClientOption;

import java.util.Arrays;
import java.util.List;
import java.util.function.Consumer;
import java.util.stream.Collectors;

/**
 * 连续定位工具（需要定位权限）
 * 该工具是多例的, 所以用完记得销毁
 */
public class SeriesLocationClient {

    private final String TAG = SeriesLocationClient.class.getSimpleName();

    public static LocationClientOption defaultLocationOption() {
        // 默认值
        LocationClientOption option = new LocationClientOption();
        // 设置高精度定位
        option.setLocationMode(LocationClientOption.LocationMode.Hight_Accuracy);
        // 可选，默认gcj02，设置返回的定位结果坐标系
        option.setCoorType("gcj02");
        // 可选，默认0，即仅定位一次，设置发起定位请求的间隔需要大于等于1000ms才是有效的
        option.setScanSpan(6000);
        // 首次定位 精度优先
        option.setFirstLocType(LocationClientOption.FirstLocType.ACCURACY_IN_FIRST_LOC);
        // 可选，设置是否需要地址信息，默认不需要
        option.setIsNeedAddress(true);
        // 可选，是否使用卫星定位（默认false-不使用）， 高精度/仅设备模式下必须设置为true
        option.setOpenGnss(true);
        // 可选，默认false(杀死)，定位SDK内部是一个SERVICE，并放到了独立进程，设置是否在stop的时候杀死这个进程
        option.setIgnoreKillProcess(true);
        // 可选，默认false，设置是否收集CRASH信息，默认收集
        option.SetIgnoreCacheException(false);
        // 可选，获取设备朝向
        option.setNeedDeviceDirect(true);
        return option;
    }

    private  LocationClient locationClient = null;

    private final Context context;

    private final String[] permissions = {
            ACCESS_COARSE_LOCATION
    };

    public LocationClient getLocationClient() {
        return this.locationClient;
    }

    public SeriesLocationClient(Context context,Consumer<BDLocation> callback ,LocationClientOption option) {
        this(option, context);
        this.setReceiveLocationCallback(callback);
    }

    public SeriesLocationClient(LocationClientOption option, Context context) {
        LocationClient.setAgreePrivacy(true);
        this.context = context;
        if (option == null) {
            option = defaultLocationOption();
        }
        try {
            this.locationClient = new LocationClient(context, option);
        } catch (Exception e) {
            Log.e("location", e.getLocalizedMessage());
        }
    }

    public SeriesLocationClient(Context context) {
        this(null, context);
    }

    public SeriesLocationClient(Context context ,Consumer<BDLocation> callback) {
        this(null, context);
        this.setReceiveLocationCallback(callback);
    }

    public void enableLocInForeground(int i, Notification notification) {
        this.locationClient.enableLocInForeground(i, notification);
    }

    /**
     * 设置定位完成的回调函数
     */
    public void setReceiveLocationCallback(Consumer<BDLocation> callback) {
        this.locationClient.registerLocationListener(new BDAbstractLocationListener() {
            @Override
            public void onReceiveLocation(BDLocation bdLocation) {
                callback.accept(bdLocation);
                if (locationClient.getLocOption().isOnceLocation) {
                    Log.d(TAG, "onReceiveLocation: 单次定位结束");
                    locationClient.stop();
                    return;
                }

                int indoorLocationSource = bdLocation.getIndoorLocationSource();
                // 1 - USER_INDDOR_TRUE
                int userIndoorState = bdLocation.getUserIndoorState();
                // wifi / GPS
                String networkLocationType = bdLocation.getNetworkLocationType();
                if (bdLocation.getIndoorLocationSurpport() == BDLocation.INDOOR_LOCATION_SURPPORT_TRUE) {
                    // 该区域已经支持室内定位，使用高精度室内定位功能。
                    locationClient.startIndoorMode();
                    Log.d(TAG, "onReceiveLocation: [开启]室定位模式");
                } else {
                    locationClient.stopIndoorMode();
                    Log.d(TAG, "onReceiveLocation: [关闭]室定位模式");
                }
            }
        });
    }

    /**
     * 开始定位
     */
    public SeriesLocationClient start() {
        locationClient.start();
        return this;
    }

    /**
     * 单次定位不需要关闭定位（连续定位才需要关闭定位）
     */
    public SeriesLocationClient stop(){
        if (locationClient != null) {
            locationClient.stop();
        }
        return this;
    }

    public void destroy() {
        this.stop();
        this.locationClient = null;
    }

    public SeriesLocationClient checkPermission(Consumer<List<String>> consumer) {
        List<String> notPermissionList = Arrays.stream(permissions)
                .filter(perm -> PackageManager.PERMISSION_GRANTED != context.checkSelfPermission(perm))
                .collect(Collectors.toList());
        consumer.accept(notPermissionList);
        return this;
    }

}
