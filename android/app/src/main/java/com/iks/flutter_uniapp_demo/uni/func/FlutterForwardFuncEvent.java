package com.iks.flutter_uniapp_demo.uni.func;

import com.alibaba.fastjson.JSON;

import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

import cn.hutool.core.util.RandomUtil;
import io.dcloud.feature.unimp.DCUniMPJSCallback;
import io.flutter.embedding.engine.dart.DartExecutor;
import io.flutter.plugin.common.BasicMessageChannel;
import io.flutter.plugin.common.JSONMessageCodec;

public class FlutterForwardFuncEvent implements FuncEvent {

    private final DartExecutor dartExecutor;

    public FlutterForwardFuncEvent(DartExecutor dartExecutor) {
        this.dartExecutor = dartExecutor;
    }

    private final Map<String, DCUniMPJSCallback> eventCallBackEvent = new ConcurrentHashMap<>();

    @Override
    public String getEventName() {
        return "flutter";
    }

    @Override
    public void onUniMPEventReceive(String appId, Object data, DCUniMPJSCallback callback) {
        String eventId = RandomUtil.randomString(10);
        eventCallBackEvent.put(eventId, callback);
        UniAppEventData uniAppEventData = new UniAppEventData(appId, data, eventId);
        BasicMessageChannel<Object> uniMPMiniApps = new BasicMessageChannel<>(dartExecutor, "uni_app_event", JSONMessageCodec.INSTANCE);
        uniMPMiniApps.send(JSON.toJSONString(uniAppEventData), callback::invoke);
    }

    static class UniAppEventData {

        private final String appId;
        private final Object data;
        private final String eventId;

        public UniAppEventData(String appId, Object data, String eventId) {
            this.appId = appId;
            this.data = data;
            this.eventId = eventId;
        }

        public String getAppId() {
            return appId;
        }

        public Object getData() {
            return data;
        }

        public String getEventId() {
            return eventId;
        }
    }
}
