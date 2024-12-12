package com.iks.flutter_uniapp_demo.uni.func;


import android.util.Log;

import com.alibaba.fastjson.JSON;

import java.util.HashMap;
import java.util.Map;

import cn.hutool.core.util.StrUtil;
import io.dcloud.feature.unimp.DCUniMPJSCallback;

public class TestFuncEvent implements FuncEvent {
    private static final String TAG = FuncEvent.class.getName();

    @Override
    public String getEventName() {
        return "test";
    }

    @Override
    public void onUniMPEventReceive(String appId, Object data, DCUniMPJSCallback callback) {
        Log.i(TAG, StrUtil.format("receive uni event appId={},data={}", appId, data));
        Map<String, Object> map = new HashMap<>();
        map.put("input:", data);
        map.put("resp", "success");
        map.put("status", 200);
        callback.invoke(JSON.toJSONString(map));
    }

}
