//
//  DartHandler.h
//  Runner
//
//  Created by kylin on 2024/11/20.
//

#import <Flutter/Flutter.h>
#import <UIKit/UIKit.h>

@interface DartHandler : NSObject

+ (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result launchOptions:(NSDictionary *)launchOptions;


@end