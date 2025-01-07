package com.iks.flutter_uniapp_demo.location;

import android.app.Service;
import android.content.Context;
import android.content.Intent;
import android.os.Binder;
import android.os.IBinder;
import android.os.PowerManager;
import android.util.Log;

import com.baidu.location.BDLocation;
import com.baidu.location.LocationClientOption;

import androidx.annotation.Nullable;

import java.util.concurrent.LinkedBlockingQueue;

public class LocationService extends Service {
    private final String TAG = LocationService.class.getSimpleName();
    private final LocalBinder localBinder = new LocalBinder();
    private BDLocation location;
    private SeriesLocationClient seriesLocationClient;
    private PowerManager.WakeLock wakeLock;
    private final LinkedBlockingQueue<LocationEntity> locationBlockingQueue = new LinkedBlockingQueue<>();

    synchronized private void acquireWakeLock(Context context){
        if(wakeLock==null){
            PowerManager mgr=(PowerManager)context.getSystemService(Context.POWER_SERVICE);
            wakeLock = mgr.newWakeLock(PowerManager.PARTIAL_WAKE_LOCK | PowerManager.ON_AFTER_RELEASE, LocationService.class.getName());
            wakeLock.setReferenceCounted(true);
            wakeLock.acquire(3 * 60 * 1000);
        }
        Log.d(TAG,"get lock");
    }

    @Override
    public void onCreate() {
        super.onCreate();
        Log.d(TAG, "onCreate");
        LocationClientOption option = SeriesLocationClient.defaultLocationOption();
        option.setOnceLocation(false);
        seriesLocationClient = new SeriesLocationClient(getApplicationContext(), location -> {
            Log.d(TAG, "curr location " + location.getAddrStr());
            locationBlockingQueue.offer(new LocationEntity(location));
            this.location = location;
        });
    }

    @Nullable
    @Override
    public IBinder onBind(Intent intent) {
        return localBinder;
    }

    @Override
    public void onDestroy() {
        Log.d(TAG, "stop service");
        seriesLocationClient.stop();
        releaseWakeLock();
    }

    public class LocalBinder extends Binder {
        /**
         * 返回当前服务的this对象
         */
        public LocationService getService() {
            return LocationService.this;
        }
        public BDLocation getLocation() {
            return location;
        }
    }

    private void releaseWakeLock() {
        if(wakeLock!=null) {
            wakeLock.release();
            wakeLock = null;
        }
    }
}
