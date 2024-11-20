package com.iks.flutter_uniapp_demo.plugs

import android.annotation.SuppressLint
import android.app.Activity
import android.content.Context
import android.graphics.Color
import android.graphics.Typeface
import android.graphics.drawable.Drawable
import androidx.core.content.ContextCompat
import android.text.TextUtils
import android.util.DisplayMetrics
import android.util.Log
import android.view.Gravity
import android.view.View
import android.view.WindowManager
import android.widget.Button
import android.widget.ImageView
import android.widget.RelativeLayout
import android.widget.TextView
import com.netease.nis.basesdk.Logger
import com.netease.nis.quicklogin.QuickLogin.TAG
import com.netease.nis.quicklogin.helper.UnifyUiConfig
import com.netease.nis.quicklogin.listener.ActivityLifecycleCallbacks
import com.netease.nis.quicklogin.listener.LoginListener
import io.flutter.plugin.common.EventChannel

/**
 * Created by hzhuqi on 2020/11/2
 */
object UiConfigParser {
    private var statusBarColor: String? = null
    private var isStatusBarDarkColor = false
    private var navBackIcon: String? = null
    private var navBackIconWidth = 25
    private var navBackIconHeight = 25
    private var navBackIconGravity = 0
    private var navBackIconMargin = 0 // 导航栏返回图标上下左右边距
    private var isHideBackIcon = false
    private var navHeight = 50
    private var navBackgroundColor: String? = null
    private var navTitle: String? = null
    private var navTitleSize = 18
    private var navTitleDpSize = 0 // 导航栏标题大小，单位 dp
    private var isNavTitleBold = false
    private var navTitleColor: String? = null
    private var isHideNav = false
    private var logoIconName: String? = null
    private var logoWidth = 50
    private var logoHeight = 50
    private var logoTopYOffset = 0
    private var logoBottomYOffset = 0
    private var logoXOffset = 0
    private var isHideLogo = false
    private var maskNumberColor: String? = null
    private var maskNumberSize = 18
    private var maskNumberDpSize = 0
    private var maskNumberTopYOffset = 0
    private var maskNumberBottomYOffset = 0
    private var maskNumberXOffset = 0
    private var maskNumberTf: String? = null
    private var maskNumberWidth = 0
    private var maskNumberHeight = 0
    private var maskNumberBackgroundRes: String? = null
    private var sloganSize = 14
    private var sloganDpSize = 0
    private var sloganColor: String? = null
    private var sloganTopYOffset = 0
    private var sloganBottomYOffset = 0
    private var sloganXOffset = 0
    private var loginBtnText: String? = "本机号码一键登录"
    private var loginBtnTextSize = 15
    private var loginBtnTextDpSize = 0
    private var loginBtnTextColor: String? = null
    private var loginBtnWidth = 0
    private var loginBtnHeight = 0
    private var loginBtnMarginLeft = 0 // 登录按钮左边距
    private var loginBtnMarginRight = 0 // 登录按钮右边距
    private var loginBtnBackgroundRes: String? = null
    private var loginBtnTopYOffset = 0
    private var loginBtnBottomYOffset = 0
    private var loginBtnXOffset = 0
    private var privacyTextColor: String? = null
    private var privacyDialogTextColor: String? = null // 协议未勾选弹窗隐私栏文本颜色，不包括协议
    private var privacyProtocolColor: String? = null
    private var privacyDialogProtocolColor: String? = null // 协议未勾选弹窗隐私栏协议颜色
    private var privacySize = 13
    private var privacyDpSize = 0
    private var privacyTopYOffset = 0
    private var privacyBottomYOffset = 0
    private var privacyWidth = 0 // 隐私协议区域宽度
    private var privacyMarginLeft = 0
    private var privacyTextMarginLeft = 0
    private var privacyMarginRight = 0
    private var privacyState = true
    private var isHidePrivacySmh = false
    private var isHidePrivacyCheckBox = false
    private var isPrivacyTextGravityCenter = false
    private var checkBoxGravity = 0
    private var checkBoxWith = 0
    private var checkBoxHeight = 0
    private var checkedImageName: String? = null
    private var unCheckedImageName: String? = null
    private var privacyTextStart: String? = "登录即同意"
    private var privacyTextStartSize = 0 // 隐私协议开始文本字体大小
    private var privacyLineSpacingAdd = 0 // 隐私文本行间距
    private var privacyLineSpacingMul = 0 // 隐私文本行间距倍数
    private var protocolConnect: String = "和" // 运营商协议和自定义协议的连接符
    private var userProtocolConnect: String? = "、" // 自定义协议之间的连接符
    private var operatorPrivacyAtLast = false // 运营商协议是否在末尾
    private var protocolText: String? = null
    private var protocolLink: String? = null
    private var protocol2Text: String? = null
    private var protocol2Link: String? = null
    private var protocol3Text: String? = null
    private var protocol3Link: String? = null
    private var privacyTextEnd: String? = "且授权使用本机号码登录"
    private var protocolNavTitle: String? = null
    private var protocolNavTitleColor: String? = null // 协议Web页面导航栏标题颜色
    private var protocolNavBackIcon: String? = null
    private var protocolNavHeight = 0
    private var protocolNavTitleSize = 0
    private var protocolNavTitleDpSize = 0
    private var protocolNavBackIconWidth = 25
    private var protocolNavBackIconHeight = 25
    private var protocolNavColor: String? = null
    private var protocolNavBackIconMargin = 0 // 协议 Web 页面导航栏返回按钮距离左边距离
    private var backgroundImage: String? = null
    private var backgroundGif: String? = null
    private var backgroundVideo: String? = null
    private var backgroundVideoImage: String? = null
    private var isLandscape = false
    private var isDialogMode = false
    private var dialogWidth = 0
    private var dialogHeight = 0
    private var dialogX = 0
    private var dialogY = 0
    private var isBottomDialog = false
    private var isProtocolDialogMode = false
    private var isPrivacyDialogAuto = false
    private var isShowPrivacyDialog = true
    private var privacyDialogText = ""
    private var privacyDialogSize = 15.0

    @SuppressLint("StaticFieldLeak")
    private var context: Context? = null
    private var widgets: List<HashMap<String, Any>>? = null
    private var enterAnimation: String? = null
    private var exitAnimation: String? = null
    private var isShowLoading = true
    private var isBackPressedAvailable = true
    private var isVirtualButtonHidden = false // 是否隐藏虚拟键

    private fun parser(uiConfig: Map<String, Any>) {
        Logger.d("ui config--->:$uiConfig")
        statusBarColor = (uiConfig["statusBarColor"] ?: "") as String
        isStatusBarDarkColor = (uiConfig["isStatusBarDarkColor"] ?: false) as Boolean

        navBackIcon = (uiConfig["navBackIcon"] ?: "") as String
        navBackIconWidth = (uiConfig["navBackIconWidth"] ?: 25) as Int
        navBackIconHeight = (uiConfig["navBackIconHeight"] ?: 25) as Int
        navBackIconGravity = (uiConfig["navBackIconGravity"] ?: Gravity.LEFT) as Int
        navBackIconMargin = (uiConfig["navBackIconMargin"] ?: 0) as Int
        isHideBackIcon = (uiConfig["isHideBackIcon"] ?: false) as Boolean
        navHeight = (uiConfig["navHeight"] ?: 50) as Int
        navBackgroundColor = (uiConfig["navBackgroundColor"] ?: "#FFFFFF") as String
        navTitle = (uiConfig["navTitle"] ?: "免密登录") as String
        navTitleSize = (uiConfig["navTitleSize"] ?: 18) as Int
        navTitleDpSize = (uiConfig["navTitleDpSize"] ?: 0) as Int
        isNavTitleBold = (uiConfig["isNavTitleBold"] ?: false) as Boolean
        navTitleColor = (uiConfig["navTitleColor"] ?: "#000000") as String
        isHideNav = (uiConfig["isHideNav"] ?: false) as Boolean

        logoIconName = (uiConfig["logoIconName"] ?: "") as String
        logoWidth = (uiConfig["logoWidth"] ?: 50) as Int
        logoHeight = (uiConfig["logoHeight"] ?: 50) as Int
        logoTopYOffset = (uiConfig["logoTopYOffset"] ?: 90) as Int
        logoBottomYOffset = (uiConfig["logoBottomYOffset"] ?: 0) as Int
        logoXOffset = (uiConfig["logoXOffset"] ?: 0) as Int
        isHideLogo = (uiConfig["isHideLogo"] ?: false) as Boolean

        maskNumberColor = (uiConfig["maskNumberColor"] ?: "#000000") as String
        maskNumberSize = (uiConfig["maskNumberSize"] ?: 18) as Int
        maskNumberDpSize = (uiConfig["maskNumberDpSize"] ?: 0) as Int
        maskNumberTopYOffset = (uiConfig["maskNumberTopYOffset"] ?: 0) as Int
        maskNumberBottomYOffset = (uiConfig["maskNumberBottomYOffset"] ?: 0) as Int
        maskNumberXOffset = (uiConfig["maskNumberXOffset"] ?: 0) as Int
        maskNumberTf = (uiConfig["maskNumberTf"] ?: "") as String
        maskNumberWidth = (uiConfig["maskNumberWidth"] ?: 0) as Int
        maskNumberHeight = (uiConfig["maskNumberHeight"] ?: 0) as Int
        maskNumberBackgroundRes = (uiConfig["maskNumberBackgroundRes"] ?: "") as String

        sloganSize = (uiConfig["sloganSize"] ?: 14) as Int
        sloganDpSize = (uiConfig["sloganDpSize"] ?: 0) as Int
        sloganColor = (uiConfig["sloganColor"] ?: "#9A9A9A") as String
        sloganTopYOffset = (uiConfig["sloganTopYOffset"] ?: 0) as Int
        sloganBottomYOffset = (uiConfig["sloganBottomYOffset"] ?: 0) as Int
        sloganXOffset = (uiConfig["sloganXOffset"] ?: 0) as Int

        loginBtnText = (uiConfig["loginBtnText"] ?: "一键登录") as String
        loginBtnTextSize = (uiConfig["loginBtnTextSize"] ?: 15) as Int
        loginBtnTextDpSize = (uiConfig["loginBtnTextDpSize"] ?: 0) as Int
        loginBtnTextColor = (uiConfig["loginBtnTextColor"] ?: "#FFFFFF") as String
        loginBtnWidth = (uiConfig["loginBtnWidth"] ?: 0) as Int
        loginBtnHeight = (uiConfig["loginBtnHeight"] ?: 0) as Int
        loginBtnMarginLeft = (uiConfig["loginBtnMarginLeft"] ?: 0) as Int
        loginBtnMarginRight = (uiConfig["loginBtnMarginRight"] ?: 0) as Int
        loginBtnBackgroundRes = (uiConfig["loginBtnBackgroundRes"] ?: "") as String
        loginBtnTopYOffset = (uiConfig["loginBtnTopYOffset"] ?: 0) as Int
        loginBtnBottomYOffset = (uiConfig["loginBtnBottomYOffset"] ?: 0) as Int
        loginBtnXOffset = (uiConfig["loginBtnXOffset"] ?: 0) as Int

        privacyTextColor = (uiConfig["privacyTextColor"] ?: "#292929") as String
        privacyDialogTextColor = (uiConfig["privacyDialogTextColor"] ?: "#292929") as String
        privacyProtocolColor = (uiConfig["privacyProtocolColor"] ?: "#888888") as String
        privacyDialogProtocolColor = (uiConfig["privacyDialogProtocolColor"] ?: "#888888") as String
        privacySize = (uiConfig["privacySize"] ?: 13) as Int
        privacyDpSize = (uiConfig["privacyDpSize"] ?: 0) as Int
        privacyTopYOffset = (uiConfig["privacyTopYOffset"] ?: 0) as Int
        privacyBottomYOffset = (uiConfig["privacyBottomYOffset"] ?: 0) as Int
        privacyWidth = (uiConfig["privacyWidth"] ?: 0) as Int
        privacyTextMarginLeft = (uiConfig["privacyTextMarginLeft"] ?: 0) as Int
        privacyMarginLeft = (uiConfig["privacyMarginLeft"] ?: 0) as Int
        privacyMarginRight = (uiConfig["privacyMarginRight"] ?: 0) as Int
        privacyState = (uiConfig["privacyState"] ?: true) as Boolean
        isHidePrivacySmh = (uiConfig["isHidePrivacySmh"] ?: false) as Boolean
        isHidePrivacyCheckBox = (uiConfig["isHidePrivacyCheckBox"] ?: false) as Boolean
        isPrivacyTextGravityCenter = (uiConfig["isPrivacyTextGravityCenter"] ?: false) as Boolean
        checkBoxGravity = (uiConfig["checkBoxGravity"] ?: Gravity.CENTER) as Int
        checkedImageName = (uiConfig["checkedImageName"] ?: "") as String
        unCheckedImageName = (uiConfig["unCheckedImageName"] ?: "") as String
        checkBoxWith = (uiConfig["checkBoxWith"] ?: 15) as Int
        checkBoxHeight = (uiConfig["checkBoxHeight"] ?: 15) as Int
        privacyTextStart = (uiConfig["privacyTextStart"] ?: "登录即同意") as String
        privacyTextStartSize = (uiConfig["privacyTextStartSize"] ?: 0) as Int
        privacyLineSpacingAdd = (uiConfig["privacyLineSpacingAdd"] ?: 0) as Int
        privacyLineSpacingMul = (uiConfig["privacyLineSpacingMul"] ?: 0) as Int
        protocolConnect = (uiConfig["protocolConnect"] ?: "和") as String
        userProtocolConnect = (uiConfig["userProtocolConnect"] ?: "、") as String
        operatorPrivacyAtLast = (uiConfig["operatorPrivacyAtLast"] ?: false) as Boolean
        protocolText = (uiConfig["protocolText"] ?: "") as String
        protocolLink = (uiConfig["protocolLink"] ?: "") as String
        protocol2Text = (uiConfig["protocol2Text"] ?: "") as String
        protocol2Link = (uiConfig["protocol2Link"] ?: "") as String
        protocol3Text = (uiConfig["protocol3Text"] ?: "") as String
        protocol3Link = (uiConfig["protocol3Link"] ?: "") as String
        privacyTextEnd = (uiConfig["privacyTextEnd"] ?: "") as String

        protocolNavTitle = (uiConfig["protocolNavTitle"] ?: "协议详情") as String
        protocolNavTitleColor = (uiConfig["protocolNavTitleColor"] ?: "#080808") as String
        protocolNavBackIcon = (uiConfig["protocolNavBackIcon"] ?: "") as String
        protocolNavHeight = (uiConfig["protocolNavHeight"] ?: 50) as Int
        protocolNavTitleSize = (uiConfig["protocolNavTitleSize"] ?: 18) as Int
        protocolNavTitleDpSize = (uiConfig["protocolNavTitleDpSize"] ?: 0) as Int
        protocolNavBackIconWidth = (uiConfig["protocolNavBackIconWidth"] ?: 25) as Int
        protocolNavBackIconHeight = (uiConfig["protocolNavBackIconHeight"] ?: 25) as Int
        protocolNavColor = (uiConfig["protocolNavColor"] ?: "#FFFFFF") as String
        protocolNavBackIconMargin = (uiConfig["protocolNavBackIconMargin"] ?: 0) as Int

        backgroundImage = (uiConfig["backgroundImage"] ?: "") as String
        backgroundGif = (uiConfig["backgroundGif"] ?: "") as String
        backgroundVideo = (uiConfig["backgroundVideo"] ?: "") as String
        backgroundVideoImage = (uiConfig["backgroundVideoImage"] ?: "") as String
        isLandscape = (uiConfig["isLandscape"] ?: false) as Boolean
        isDialogMode = (uiConfig["isDialogMode"] ?: false) as Boolean
        dialogWidth = (uiConfig["dialogWidth"] ?: getScreenWidth()) as Int
        dialogHeight = (uiConfig["dialogHeight"] ?: 0) as Int
        dialogX = (uiConfig["dialogX"] ?: 0) as Int
        dialogY = (uiConfig["dialogY"] ?: 0) as Int
        isBottomDialog = (uiConfig["isBottomDialog"] ?: false) as Boolean
        isProtocolDialogMode = (uiConfig["isProtocolDialogMode"] ?: false) as Boolean
        isPrivacyDialogAuto = (uiConfig["isPrivacyDialogAuto"] ?: false) as Boolean
        isShowPrivacyDialog = (uiConfig["isShowPrivacyDialog"] ?: true) as Boolean
        privacyDialogText = (uiConfig["privacyDialogText"] ?: "") as String
        privacyDialogSize = (uiConfig["privacyDialogSize"] ?: 15.0) as Double
        widgets = uiConfig["widgets"]?.let {
            it as List<HashMap<String, Any>>
        }
        enterAnimation = (uiConfig["enterAnimation"] ?: "") as String
        exitAnimation = (uiConfig["exitAnimation"] ?: "") as String
        isShowLoading = (uiConfig["isShowLoading"] ?: true) as Boolean
        isBackPressedAvailable = (uiConfig["isBackPressedAvailable"] ?: true) as Boolean
        isVirtualButtonHidden = (uiConfig["isVirtualButtonHidden"] ?: false) as Boolean
        Log.d(TAG, "ui config parser finished")
    }

    fun getUiConfig(
        context: Context, map: Map<String, Any>, events: EventChannel.EventSink?
    ): UnifyUiConfig {
        this.context = context
        parser(map)
        return buildUiConfig(context, events)
    }

    private fun buildUiConfig(context: Context, events: EventChannel.EventSink?): UnifyUiConfig {
        val resultMap = HashMap<String, Any>()
        resultMap["type"] = "uiCallback"
        val builder: UnifyUiConfig.Builder =
            UnifyUiConfig.Builder().setStatusBarDarkColor(isStatusBarDarkColor)
                .setNavigationIconGravity(navBackIconGravity)
                .setNavigationBackIconWidth(navBackIconWidth)
                .setNavigationBackIconHeight(navBackIconHeight)
                .setNavigationIconMargin(navBackIconMargin)
                .setHideNavigationBackIcon(isHideBackIcon).setNavigationHeight(navHeight)
                .setNavigationBackgroundColor(Color.parseColor(navBackgroundColor))
                .setNavigationTitle(navTitle).setNavTitleSize(navTitleSize)
                .setNavTitleDpSize(navTitleDpSize).setNavTitleBold(isNavTitleBold)
                .setNavigationTitleColor(Color.parseColor(navTitleColor))
                .setHideNavigation(isHideNav).setLogoWidth(logoWidth).setLogoHeight(logoHeight)
                .setLogoXOffset(logoXOffset).setHideLogo(isHideLogo)
                .setMaskNumberSize(maskNumberSize).setMaskNumberDpSize(maskNumberDpSize)
                .setMaskNumberColor(Color.parseColor(maskNumberColor))
                .setMaskNumberXOffset(maskNumberXOffset).setSloganSize(sloganSize)
                .setSloganDpSize(sloganDpSize).setSloganColor(Color.parseColor(sloganColor))
                .setSloganXOffset(sloganXOffset).setLoginBtnText(loginBtnText)
                .setLoginBtnTextColor(Color.parseColor(loginBtnTextColor))
                .setLoginBtnTextSize(loginBtnTextSize).setLoginBtnTextDpSize(loginBtnTextDpSize)
                .setLoginBtnXOffset(loginBtnXOffset)
                .setPrivacyTextColor(Color.parseColor(privacyTextColor))
                .setPrivacyDialogTextColor(Color.parseColor(privacyDialogTextColor))
                .setPrivacyProtocolColor(Color.parseColor(privacyProtocolColor))
                .setPrivacyDialogProtocolColor(Color.parseColor(privacyDialogProtocolColor))
                .setPrivacySize(privacySize).setPrivacyDpSize(privacyDpSize)
                .setPrivacyBottomYOffset(privacyBottomYOffset)
                .setPrivacyTextMarginLeft(privacyTextMarginLeft)
                .setPrivacyMarginLeft(privacyMarginLeft).setPrivacyMarginRight(privacyMarginRight)
                .setPrivacyState(privacyState).setHidePrivacySmh(isHidePrivacySmh)
                .setHidePrivacyCheckBox(isHidePrivacyCheckBox)
                .setPrivacyTextGravityCenter(isPrivacyTextGravityCenter)
                .setCheckBoxGravity(checkBoxGravity).setPrivacyCheckBoxWidth(checkBoxWith)
                .setPrivacyCheckBoxHeight(checkBoxHeight).setPrivacyTextStart(privacyTextStart)
                .setProtocolConnect(protocolConnect).setUserProtocolConnect(userProtocolConnect)
                .setOperatorPrivacyAtLast(operatorPrivacyAtLast).setProtocolText(protocolText)
                .setProtocolLink(protocolLink).setProtocol2Text(protocol2Text)
                .setProtocol2Link(protocol2Link).setProtocol3Text(protocol3Text)
                .setProtocol3Link(protocol3Link).setPrivacyTextEnd(privacyTextEnd)
                .setProtocolPageNavTitle(protocolNavTitle, protocolNavTitle, protocolNavTitle)
                .setProtocolPageNavTitleColor(Color.parseColor(protocolNavTitleColor))
                .setProtocolPageNavColor(Color.parseColor(protocolNavColor))
                .setProtocolPageNavBackIconMargin(protocolNavBackIconMargin)
                .setProtocolPageNavHeight(protocolNavHeight)
                .setProtocolPageNavTitleSize(protocolNavTitleSize)
                .setProtocolPageNavTitleDpSize(protocolNavTitleDpSize)
                .setProtocolPageNavBackIconWidth(protocolNavBackIconWidth)
                .setProtocolPageNavBackIconHeight(protocolNavBackIconHeight)
                .setLandscape(isLandscape).setDialogMode(
                    isDialogMode, dialogWidth, dialogHeight, dialogX, dialogY, isBottomDialog
                ).setProtocolDialogMode(isProtocolDialogMode)
                .setPrivacyDialogAuto(isPrivacyDialogAuto)
                .setPrivacyDialogTextSize(privacyDialogSize.toFloat())
                .setLoadingVisible(isShowLoading).setBackPressedAvailable(isBackPressedAvailable)
                .setVirtualButtonHidden(isVirtualButtonHidden)
                .setLoginListener(object : LoginListener {
                    override fun onDisagreePrivacy(
                        privacyTv: TextView?,
                        btnLogin: Button?
                    ): Boolean {
                        return !isShowPrivacyDialog
                    }
                }).setMaskNumberListener { textView, _ ->
                    if (!TextUtils.isEmpty(maskNumberBackgroundRes)) {
                        textView.setBackgroundDrawable(
                            getDrawable(
                                maskNumberBackgroundRes,
                                context
                            )
                        )
                    }
                    if (maskNumberWidth != 0) {
                        textView.width = dip2px(context, maskNumberWidth.toFloat())
                    }
                    if (maskNumberHeight != 0) {
                        textView.height = dip2px(context, maskNumberWidth.toFloat())
                    }
                }.setClickEventListener { viewType, code ->
                    if (viewType == UnifyUiConfig.CLICK_PRIVACY) {
                        Log.d(TAG, "点击了隐私协议")
                        resultMap["action"] = "appDPrivacy"
                        events?.success(resultMap)
                    } else if (viewType == UnifyUiConfig.CLICK_CHECKBOX) {
                        if (code == 0) {
                            Log.d(TAG, "点击了复选框,且复选框未勾选")
                            resultMap["action"] = "checkedAction"
                            resultMap["isCheckboxChecked"] = false
                            events?.success(resultMap)
                        } else if (code == 1) {
                            Log.d(TAG, "点击了复选框,且复选框已勾选")
                            resultMap["action"] = "checkedAction"
                            resultMap["isCheckboxChecked"] = true
                            events?.success(resultMap)
                        }
                    } else if (viewType == UnifyUiConfig.CLICK_LOGIN_BUTTON) {
                        if (code == 0) {
                            Log.d(TAG, "点击了登录按钮,且复选框未勾选")
                            resultMap["action"] = "loginAction"
                            resultMap["isCheckboxChecked"] = false
                            events?.success(resultMap)
                        } else if (code == 1) {
                            Log.d(TAG, "点击了登录按钮,且复选框已勾选")
                            resultMap["action"] = "loginAction"
                            resultMap["isCheckboxChecked"] = true
                            events?.success(resultMap)
                        }
                    } else if (viewType == UnifyUiConfig.CLICK_TOP_LEFT_BACK_BUTTON) {
                        Log.d(TAG, "点击了左上角返回")
                        resultMap["action"] = "backAction"
                        events?.success(resultMap)
                    }
                }.setActivityLifecycleCallbacks(object : ActivityLifecycleCallbacks {
                    override fun onCreate(activity: Activity) {
                        Log.d(TAG, "lifecycle onCreate回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewDidLoad"
                        events?.success(resultMap)
                    }

                    override fun onResume(activity: Activity) {
                        Log.d(TAG, "lifecycle onResume回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewDidAppear"
                        events?.success(resultMap)
                    }

                    override fun onStart(activity: Activity) {
                        Log.d(TAG, "lifecycle onStart回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewWillAppear"
                        events?.success(resultMap)
                    }

                    override fun onPause(activity: Activity) {
                        Log.d(TAG, "lifecycle onPause回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewWillDisappear"
                        events?.success(resultMap)
                    }

                    override fun onStop(activity: Activity) {
                        Log.d(TAG, "lifecycle onStop回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewDidDisappear"
                        events?.success(resultMap)
                    }

                    override fun onDestroy(activity: Activity) {
                        Log.d(TAG, "lifecycle onDestroy回调------>" + activity.localClassName)
                        resultMap["action"] = "authViewDealloc"
                        events?.success(resultMap)
                    }
                })

        if (!TextUtils.isEmpty(statusBarColor)) {
            builder.setStatusBarColor(Color.parseColor(statusBarColor))
        }
        if (!TextUtils.isEmpty(navBackIcon)) {
            builder.setNavigationIconDrawable(getDrawable(navBackIcon, context))
        }
        if (logoTopYOffset != 0) {
            builder.setLogoTopYOffset(logoTopYOffset)
        }
        if (logoBottomYOffset != 0) {
            builder.setLogoBottomYOffset(logoBottomYOffset)
        }
        if (!TextUtils.isEmpty(logoIconName)) {
            builder.setLogoIconDrawable(getDrawable(logoIconName, context))
        }
        if (maskNumberTopYOffset != 0) {
            builder.setMaskNumberTopYOffset(maskNumberTopYOffset)
        }
        if (maskNumberBottomYOffset != 0) {
            builder.setMaskNumberBottomYOffset(maskNumberBottomYOffset)
        }
        if (!TextUtils.isEmpty(maskNumberTf)) {
            builder.setMaskNumberTypeface(Typeface.createFromAsset(context.assets, maskNumberTf))
        }
        if (sloganTopYOffset != 0) {
            builder.setSloganTopYOffset(sloganTopYOffset)
        }
        if (sloganBottomYOffset != 0) {
            builder.setSloganBottomYOffset(sloganBottomYOffset)
        }
        if (loginBtnTopYOffset != 0) {
            builder.setLoginBtnTopYOffset(loginBtnTopYOffset)
        }
        if (loginBtnBottomYOffset != 0) {
            builder.setLoginBtnBottomYOffset(loginBtnBottomYOffset)
        }
        if (loginBtnWidth != 0) {
            builder.setLoginBtnWidth(loginBtnWidth)
        }
        if (loginBtnHeight != 0) {
            builder.setLoginBtnHeight(loginBtnHeight)
        }
        if (loginBtnMarginLeft != 0) {
            builder.setLoginBtnMarginLeft(loginBtnMarginLeft)
        }
        if (loginBtnMarginRight != 0) {
            builder.setLoginBtnMarginRight(loginBtnMarginRight)
        }
        if (!TextUtils.isEmpty(loginBtnBackgroundRes)) {
            builder.setLoginBtnBackgroundDrawable(getDrawable(loginBtnBackgroundRes, context))
        }
        if (privacyTopYOffset != 0) {
            builder.setPrivacyTopYOffset(privacyTopYOffset)
        }
        if (privacyBottomYOffset != 0) {
            builder.setPrivacyBottomYOffset(privacyBottomYOffset)
        }
        if (privacyWidth != 0) {
            builder.setPrivacyWidth(privacyWidth)
        }
        if (privacyTextStartSize != 0) {
            builder.setPrivacyTextStartSize(privacyTextStartSize.toFloat())
        }
        if (privacyLineSpacingAdd != 0 && privacyLineSpacingMul != 0) {
            builder.setPrivacyLineSpacing(
                privacyLineSpacingAdd.toFloat(), privacyLineSpacingMul.toFloat()
            )
        }
        if (!TextUtils.isEmpty(checkedImageName)) {
            builder.setCheckedImageDrawable(getDrawable(checkedImageName, context))
        }
        if (!TextUtils.isEmpty(unCheckedImageName)) {
            builder.setUnCheckedImageDrawable(getDrawable(unCheckedImageName, context))
        }
        if (!TextUtils.isEmpty(backgroundImage)) {
            builder.setBackgroundImageDrawable(getDrawable(backgroundImage, context))
        }
        if (!TextUtils.isEmpty(backgroundVideo)) {
            builder.setBackgroundVideo(getVideoRaw(backgroundVideo, context), backgroundVideoImage)
        }
        if (!TextUtils.isEmpty(privacyDialogText)) {
            builder.setPrivacyDialogText(privacyDialogText)
        }
        if (!TextUtils.isEmpty(backgroundGif)) {
            builder.setBackgroundGifDrawable(
                getDrawable(
                    backgroundGif, context
                )
            )
        }
        if (!TextUtils.isEmpty(protocolNavBackIcon)) {
            builder.setProtocolPageNavBackIconDrawable(getDrawable(protocolNavBackIcon, context))
        }
        if (!TextUtils.isEmpty(enterAnimation) && !TextUtils.isEmpty(exitAnimation)) {
            builder.setActivityTranslateAnimation(enterAnimation, exitAnimation)
        }
        setCustomView(context, builder, widgets, events)
        Log.d(TAG, "---------------UI配置设置完成---------------")
        return builder.build(context)
    }

    private fun setCustomView(
        context: Context,
        builder: UnifyUiConfig.Builder,
        list: List<Map<String, Any>>?,
        events: EventChannel.EventSink?
    ) {
        if (list == null) {
            Log.d(TAG, "UI配置widgets为空")
            return
        }
        for (element in list) {
            val itemMap: Map<String, Any> = element
            val viewParams = ViewParams()
            viewParams.viewId = (itemMap["viewId"] ?: "") as String
            viewParams.type = (itemMap["type"] ?: "") as String
            when {
                "Button".equals(viewParams.type, ignoreCase = true) -> {
                    viewParams.view = Button(context)
                }

                "TextView".equals(viewParams.type, ignoreCase = true) -> {
                    viewParams.view = TextView(context)
                }

                "ImageView".equals(viewParams.type, ignoreCase = true) -> {
                    viewParams.view = ImageView(context)
                }
            }
            viewParams.text = (itemMap["text"] ?: "") as String
            viewParams.left = (itemMap["left"] ?: 0) as Int
            viewParams.top = (itemMap["top"] ?: 0) as Int
            viewParams.right = (itemMap["right"] ?: 0) as Int
            viewParams.bottom = (itemMap["bottom"] ?: 0) as Int
            viewParams.width = (itemMap["width"] ?: 0) as Int
            viewParams.height = (itemMap["height"] ?: 0) as Int
            viewParams.font = (itemMap["font"] ?: 0) as Int
            viewParams.textColor = (itemMap["textColor"] ?: "") as String
            viewParams.clickable = (itemMap["clickable"] ?: true) as Boolean
            viewParams.backgroundColor = (itemMap["backgroundColor"] ?: "") as String
            viewParams.positionType = (itemMap["positionType"] ?: 0) as Int
            viewParams.backgroundImgPath = (itemMap["backgroundImgPath"] ?: "") as String
            viewParams.isBold = (itemMap["isBold"] ?: false) as Boolean
            viewParams.isGravityCenter = (itemMap["isGravityCenter"] ?: false) as Boolean
            val layoutParams = RelativeLayout.LayoutParams(
                if (viewParams.width == 0) RelativeLayout.LayoutParams.WRAP_CONTENT else dip2px(
                    context, viewParams.width.toFloat()
                ), if (viewParams.height == 0) RelativeLayout.LayoutParams.WRAP_CONTENT else dip2px(
                    context, viewParams.height.toFloat()
                )
            )
            if (viewParams.left != 0) {
                layoutParams.addRule(
                    RelativeLayout.ALIGN_PARENT_LEFT, RelativeLayout.CENTER_VERTICAL
                )
                layoutParams.leftMargin = dip2px(context, viewParams.left.toFloat())
            }
            if (viewParams.top != 0) {
                layoutParams.topMargin = dip2px(context, viewParams.top.toFloat())
            }
            if (viewParams.right != 0) {
                layoutParams.addRule(
                    RelativeLayout.ALIGN_PARENT_RIGHT, RelativeLayout.CENTER_VERTICAL
                )
                layoutParams.rightMargin = dip2px(context, viewParams.right.toFloat())
            }
            if (viewParams.bottom != 0) {
                layoutParams.addRule(
                    RelativeLayout.ALIGN_PARENT_BOTTOM
                )
                layoutParams.bottomMargin = dip2px(context, viewParams.bottom.toFloat())
            }
            if (viewParams.left == 0 && viewParams.right == 0) {
                layoutParams.addRule(RelativeLayout.CENTER_HORIZONTAL)
            }
            viewParams.view!!.layoutParams = layoutParams
            viewParams.view!!.tag = viewParams.viewId
            if (viewParams.view is TextView || viewParams.view is Button) {
                (viewParams.view as TextView?)!!.text = viewParams.text
                if (viewParams.isGravityCenter) {
                    (viewParams.view as TextView?)!!.gravity = Gravity.CENTER
                }
                if (viewParams.font != 0) {
                    (viewParams.view as TextView?)!!.textSize = viewParams.font.toFloat()
                }
                if (!TextUtils.isEmpty(viewParams.textColor)) {
                    (viewParams.view as TextView?)!!.setTextColor(Color.parseColor(viewParams.textColor))
                }
                if (viewParams.isBold) {
                    (viewParams.view as TextView?)!!.typeface =
                        Typeface.defaultFromStyle(Typeface.BOLD)
                }
            }
            if (!viewParams.clickable) {
                viewParams.view?.isClickable = false
            }
            if (!TextUtils.isEmpty(viewParams.backgroundColor)) {
                viewParams.view?.setBackgroundColor(Color.parseColor(viewParams.backgroundColor))
            }
            if (!TextUtils.isEmpty(viewParams.backgroundImgPath)) {
                viewParams.view?.background = getDrawable(viewParams.backgroundImgPath, context)
            }
            builder.addCustomView(
                viewParams.view,
                viewParams.viewId,
                if (viewParams.positionType == 0) UnifyUiConfig.POSITION_IN_BODY else UnifyUiConfig.POSITION_IN_TITLE_BAR
            ) { _, _, view ->
                Log.d(TAG, "CustomViewListener onClick:" + view.tag)
                val map = HashMap<String, String>()
                map["action"] = (itemMap["action"] ?: "") as String
                events?.success(map)
            }
        }
        Log.d(TAG, "-----------set custom view finished-----------")
    }

    class ViewParams {
        var view: View? = null
        var viewId: String? = null
        var type: String? = null
        var text: String? = null
        var left = 0
        var top = 0
        var right = 0
        var bottom = 0
        var width = 0
        var height = 0
        var font = 0
        var textColor: String? = null
        var clickable = true
        var backgroundColor: String? = null
        var backgroundImgPath: String? = null
        var positionType = 0
        var isBold = false
        var isGravityCenter = false
    }

    /**
     * 根据手机的分辨率从 dp 的单位 转成为 px(像素)
     */
    private fun dip2px(context: Context, dpValue: Float): Int {
        val scale = context.resources.displayMetrics.density
        return (dpValue * scale + 0.5f).toInt()
    }

    private fun px2dip(context: Context, pxValue: Int): Float {
        val scale = context.resources.displayMetrics.density
        return pxValue / scale + 0.5f
    }

    // 获取Drawable
    private fun getDrawable(resPath: String?, context: Context): Drawable? {
        var drawable: Drawable? = null
        val rid: Int
        try {
            Log.d(TAG, "drawable path: $resPath")
            if (!TextUtils.isEmpty(resPath)) {
                rid = context.resources.getIdentifier(resPath, "drawable", context.packageName)
                drawable = ContextCompat.getDrawable(context, rid)
            }
        } catch (e: Exception) {
            Logger.e(e.message)
        }
        return drawable
    }

    private fun getVideoRaw(resPath: String?, context: Context): String {
        var videoRaw = ""
        try {
            Log.d(TAG, "raw path: $resPath")
            if (!TextUtils.isEmpty(resPath)) {
                val rid = context.resources.getIdentifier(resPath, "raw", context.packageName)
                videoRaw = "android.resource://" + context.packageName + "/" + rid
            }
        } catch (e: Exception) {
            Logger.e(e.message)
        }
        return videoRaw
    }

    private fun getScreenWidth(): Int {
        context?.let {
            val wm = it.getSystemService(Context.WINDOW_SERVICE) as WindowManager
            val outMetrics = DisplayMetrics()
            wm.defaultDisplay.getMetrics(outMetrics)
            return (px2dip(it, outMetrics.widthPixels)).toInt()
        }
        return 0
    }
}