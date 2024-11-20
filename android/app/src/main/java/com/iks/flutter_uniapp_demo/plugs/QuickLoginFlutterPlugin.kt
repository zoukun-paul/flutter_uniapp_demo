package com.iks.flutter_uniapp_demo.plugs

import android.content.Context
import androidx.annotation.NonNull
import com.netease.nis.basesdk.Logger
import com.netease.nis.quicklogin.QuickLogin.TAG
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

/** QuickloginFlutterPlugin */
class QuickLoginFlutterPlugin : FlutterPlugin, MethodCallHandler {
    val METHOD_CHANNEL = "quicklogin_flutter_plugin"
    val EVENT_CHANNEL = "yd_quicklogin_flutter_event_channel"

    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private var loginHelper: QuickLoginHelper? = null
    private lateinit var context: Context


    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        context = flutterPluginBinding.applicationContext
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, METHOD_CHANNEL)
        channel.setMethodCallHandler(this)
        loginHelper = QuickLoginHelper()
        EventChannel(flutterPluginBinding.binaryMessenger, EVENT_CHANNEL).setStreamHandler(object :
            EventChannel.StreamHandler {
            override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                loginHelper?.events = events
            }

            override fun onCancel(arguments: Any?) {

            }
        })
    }

    override fun onMethodCall(@NonNull call: MethodCall, @NonNull result: Result) {
        Logger.i(TAG, "onMethodCall:" + call.method)
        when (call.method) {
            "init" -> {
                val businessId = call.argument<String>("businessId")
                val isDebug = call.argument<Boolean>("isDebug")
                val timeOut = call.argument<Int>("timeout")
                loginHelper?.init(context, businessId, isDebug, timeOut, result)
            }

            "setUiConfig" -> {
                loginHelper?.setUiConfig(call)
            }

            "preFetchNumber" -> {
                loginHelper?.preFetchNumber(result)
            }

            "onePassLogin" -> {
                loginHelper?.onePassLogin(result)
            }

            "closeLoginAuthView" -> {
                loginHelper?.quitActivity()
            }

            "getPlatformVersion" -> {
                result.success("Android ${android.os.Build.VERSION.RELEASE}")
            }

            "checkVerifyEnable" -> {
                loginHelper?.checkVerifyEnable(result)
            }

            "verifyPhoneNumber" -> {
                val phoneNumber = call.argument<String>("phoneNumber")
                loginHelper?.verifyPhoneNumber(phoneNumber, result)
            }

            "checkedSelected" -> {
                if (call.arguments is String) {
                    val isCheckedSelected = call.arguments as String
                    if (isCheckedSelected == "true") {
                        loginHelper?.setPrivacyState(true)
                    } else {
                        loginHelper?.setPrivacyState(false)
                    }
                }
            }

            else -> {
                result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }
}
