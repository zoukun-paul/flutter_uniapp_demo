package com.iks.flutter_uniapp_demo.plugs

import android.content.Context
import android.text.TextUtils
import com.netease.nis.basesdk.Logger
import com.netease.nis.quicklogin.QuickLogin
import com.netease.nis.quicklogin.listener.QuickLoginPreMobileListener
import com.netease.nis.quicklogin.listener.QuickLoginTokenListener
import io.flutter.plugin.common.EventChannel
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel.Result
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.MainScope
import kotlinx.coroutines.launch
import java.lang.Exception

/**
 * Created by hzhuqi on 2020/11/2
 */
class QuickLoginHelper : CoroutineScope by MainScope() {
    private var quickLogin: QuickLogin? = null
    private var context: Context? = null
    var events: EventChannel.EventSink? = null

    fun init(
        context: Context,
        businessId: String?,
        isDebug: Boolean?,
        timeout: Int?,
        result: Result
    ) {
        if (TextUtils.isEmpty(businessId)) {
            Logger.e("业务id不允许为空")
            return
        }

        this.context = context
        quickLogin = QuickLogin.getInstance()
        quickLogin?.init(context, businessId)
        isDebug?.let {
            quickLogin?.setDebugMode(it)
        }
        timeout?.let {
            if (it != 0)
                quickLogin?.setPrefetchNumberTimeout(it)
        }
        val map = HashMap<String, Any?>()
        map["success"] = true
        result.success(map)
    }

    fun setUiConfig(call: MethodCall) {
        val uiConfig = call.argument<Map<String, Any>>("uiConfig")
        context?.let {
            if (uiConfig != null) {
                quickLogin?.setUnifyUiConfig(UiConfigParser.getUiConfig(it, uiConfig, events))
            } else {
                Logger.i("自定义授权页面ui没有设置")
            }
        }
    }

    /**
     * 预取号接口
     */
    fun preFetchNumber(result: Result) {
        val map = HashMap<String, Any?>()
        quickLogin?.prefetchMobileNumber(object : QuickLoginPreMobileListener {
            override fun onGetMobileNumberSuccess(ydToken: String?, mobileNumber: String?) {
                map["success"] = true
                map["token"] = ydToken
                try {
                    result.success(map)
                } catch (e: Exception) {
                    Logger.e("Reply already submitted")
                }
            }

            override fun onGetMobileNumberError(ydToken: String?, msg: String?) {
                map["success"] = false
                map["token"] = ydToken
                map["errorMsg"] = msg
                try {
                    result.success(map)
                } catch (e: Exception) {
                    Logger.e("Reply already submitted")
                }
            }

        })
    }

    /**
     * 一键登录接口
     */
    fun onePassLogin(result: Result) {
        val map = HashMap<String, Any?>()
        quickLogin?.onePass(object : QuickLoginTokenListener {
            override fun onGetTokenSuccess(ydToken: String?, accessCode: String?) {
                Logger.i(String.format("yd token is:%s accessCode is:%s", ydToken, accessCode))
                map["success"] = true
                map["ydToken"] = ydToken
                map["accessToken"] = accessCode
                try {
                    result.success(map)
                } catch (e: Exception) {
                    Logger.e(QuickLogin.TAG, "Reply already submitted")
                }
            }

            override fun onGetTokenError(ydToken: String?, code: Int, msg: String?) {
                Logger.i("获取运营商token失败:$msg")
                map["success"] = false
                map["ydToken"] = ydToken
                map["msg"] = msg
                try {
                    result.success(map)
                } catch (e: Exception) {
                    Logger.e("Reply already submitted")
                }

            }

            override fun onCancelGetToken() {
                Logger.i("用户取消登录")
                map["type"] = "login"
                map["success"] = false
                map["cancel"] = true
                launch(Dispatchers.Main) {
                    events?.success(map)
                }
            }
        })
    }

    fun quitActivity() {
        quickLogin?.quitActivity()
    }

    fun setPrivacyState(isChecked: Boolean) {
        quickLogin?.privacyState = isChecked
    }

    fun checkVerifyEnable(result: Result) {
        val type = quickLogin?.checkNetWork(context)
        //5是未知类型
        if (type != 5 && type != 4) {
            val map = HashMap<String, Any?>()
            map["success"] = true
            try {
                result.success(map)
            } catch (e: Exception) {
                Logger.e(QuickLogin.TAG, "Reply already submitted")
            }
        } else {
            val map = HashMap<String, Any?>()
            map["success"] = false
            try {
                result.success(map)
            } catch (e: Exception) {
                Logger.e(QuickLogin.TAG, "Reply already submitted")
            }
        }
    }

    fun verifyPhoneNumber(phoneNumber: String?, result: Result) {
        if (TextUtils.isEmpty(phoneNumber)) {
            Logger.e("手机号码不允许为空")
            return
        }

        phoneNumber?.let {
            val map = HashMap<String, Any?>()
            quickLogin?.getToken(phoneNumber, object : QuickLoginTokenListener {
                override fun onGetTokenSuccess(ydToken: String?, accessCode: String?) {
                    Logger.i("本机校验成功")
                    map["success"] = true
                    map["ydToken"] = ydToken
                    map["accessToken"] = accessCode
                    try {
                        result.success(map)
                    } catch (e: Exception) {
                        Logger.e("Reply already submitted")
                    }
                }

                override fun onGetTokenError(ydToken: String?, code: Int, msg: String?) {
                    Logger.i("本机校验失败")
                    map["success"] = false
                    map["ydToken"] = ydToken
                    map["msg"] = msg
                    try {
                        result.success(map)
                    } catch (e: Exception) {
                        Logger.e("Reply already submitted")
                    }
                }

            })
        }
    }
}