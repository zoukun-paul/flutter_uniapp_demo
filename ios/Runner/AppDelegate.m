    #import <UIKit/UIKit.h>
    #import <Flutter/Flutter.h>
    #import "DCUniMPSDKEngine.h"
    #import "GeneratedPluginRegistrant.h"
    #import "DCUniMP.h"

    @interface AppDelegate : FlutterAppDelegate <DCUniMPSDKEngineDelegate>
    @end

    @implementation AppDelegate

    - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
        FlutterViewController *controller = (FlutterViewController *)self.window.rootViewController;
        FlutterMethodChannel *uniMPMiniApps = [FlutterMethodChannel methodChannelWithName:@"native_msg"
                                                                        binaryMessenger:controller.binaryMessenger];
        [uniMPMiniApps setMethodCallHandler:^(FlutterMethodCall *call, FlutterResult result) {
            if ([@"open" isEqualToString:call.method]) {
                NSDictionary *arguments = call.arguments;
                NSString *AppID = arguments[@"AppID"] ?: @"";
                NSMutableDictionary *options = [NSMutableDictionary dictionaryWithDictionary:launchOptions ?: @{}];
                options[@"debug"] = @YES;
                [DCUniMPSDKEngine initSDKEnvironmentWithLaunchOptions:options];
                [self checkUniMPResoutceWithAppid:AppID];
                [self openUniMPWithAppid:AppID];
            } else {
                NSLog(@"method %@ not implemented", call.method);
            }
        }];
        [GeneratedPluginRegistrant registerWithRegistry:self];
        return [super application:application didFinishLaunchingWithOptions:launchOptions];
    }

- (void)checkUniMPResoutceWithAppid:(NSString *)appid {
        NSString *wgtPath = [[NSBundle mainBundle] pathForResource:appid ofType:@"wgt"] ?: @"";
        if ([DCUniMPSDKEngine isExistsUniMP:appid]) {
            NSDictionary *version = [DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid];
            NSString *name = version[@"code"];
            NSString *code = version[@"code"];
            NSLog(@"小程序：%@ 资源已存在，版本信息：name:%@ code:%@", appid, name, code);
        } else {
            @try {
                [DCUniMPSDKEngine installUniMPResourceWithAppid:appid resourceFilePath:wgtPath password:nil error:nil];
                NSDictionary *version = [DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid];
                NSString *name = version[@"code"];
                NSString *code = version[@"code"];
                NSLog(@"✅ 小程序：%@ 资源释放成功，版本信息：name:%@ code:%@", appid, name, code);
            } @catch (NSError *err) {
                NSLog(@"❌ 小程序：%@ 资源释放失败:%@", appid, err);
            }
        }
    }

    - (void)openUniMPWithAppid:(NSString *)appid {
        DCUniMPConfiguration *configuration = [[DCUniMPConfiguration alloc] init];
        configuration.enableBackground = YES;
        
        [DCUniMPSDKEngine openUniMP:appid configuration:configuration completed:^(DCUniMPInstance * _Nullable uniMPInstance, NSError * _Nullable error) {
            if (uniMPInstance) {
                NSLog(@"小程序打开成功");
            } else {
                NSLog(@"%@", error);
            }
        }];
    }

    - (void)uniMPOnCloseWithAppid:(NSString *)appid {
        NSLog(@"小程序：%@ closed", appid);
    }

    - (void)defaultMenuItemClickedWithAppid:(NSString *)appid identifier:(NSString *)identifier {
        NSLog(@"defaultMenuItemClicked：%@ %@", appid, identifier);
    }

    - (UIView *)splashViewForApp:(NSString *)appid {
        UIView *splashView = [[NSBundle mainBundle] loadNibNamed:@"SplashView" owner:self options:nil].lastObject;
        return splashView;
    }

    #pragma mark - App 生命周期方法
    - (void)applicationDidBecomeActive:(UIApplication *)application {
        [DCUniMPSDKEngine applicationDidBecomeActive:application];
    }

    - (void)applicationWillResignActive:(UIApplication *)application {
        [DCUniMPSDKEngine applicationWillResignActive:application];
    }

    - (void)applicationDidEnterBackground:(UIApplication *)application {
        [DCUniMPSDKEngine applicationDidEnterBackground:application];
    }

    - (void)applicationWillEnterForeground:(UIApplication *)application {
        [DCUniMPSDKEngine applicationWillEnterForeground:application];
    }

    - (void)applicationWillTerminate:(UIApplication *)application {
        [DCUniMPSDKEngine destory];
    }
    @end
