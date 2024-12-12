package com.iks.flutter_uniapp_demo.uni.func;

import io.dcloud.feature.sdk.Interface.IOnUniMPEventCallBack;
import io.dcloud.feature.unimp.DCUniMPJSCallback;

public interface FuncEvent extends IOnUniMPEventCallBack {

    String getEventName();

    @Override
    default void onUniMPEventReceive(String appId, String event, Object data, DCUniMPJSCallback callback) {
        onUniMPEventReceive(appId, data, callback);
    }

    void onUniMPEventReceive(String appId, Object data, DCUniMPJSCallback callback);

}
