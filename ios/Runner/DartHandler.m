//
//  DartHandler.m
//  Runner
//
//  Created by kylin on 2024/11/20.
//

#import "DartHandler.h"
#import "DCUniMP.h"
#import <SSZipArchive.h>
#import <CommonCrypto/CommonDigest.h>
#import <Foundation/Foundation.h>


NSString * md5sum(NSString *filePath) {
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if (![fileManager fileExistsAtPath:filePath]) {
        NSLog(@"❌ MD5: 文件不存在: %@", filePath);
        return nil; // 文件不存在
    }
    
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    if (!fileData) {
        NSLog(@"❌ MD5: 文件不可访问: %@", filePath);
        return nil; // 无法读取文件数据
    }
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    CC_MD5(fileData.bytes, (CC_LONG)fileData.length, digest);
    
    NSMutableString *md5String = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        [md5String appendFormat:@"%02x", digest[i]];
    }
    NSLog(@"🟢 MD5: %@", md5String);
    
    return md5String;
}

NSString * downloadFileSync(NSString *fileUrl, NSString* appID, NSError **error) {
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *wgtDest = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wgt", appID]];
    NSURL *destinationURL = [NSURL fileURLWithPath:wgtDest];
        
    NSFileManager *fileManager = [NSFileManager defaultManager];
    [fileManager removeItemAtURL:destinationURL error:nil];

    // 创建 NSURL 对象
    NSURL *url = [NSURL URLWithString:fileUrl];
    
    // 创建 NSURLRequest 对象
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    // 创建 dispatch_semaphore_t 用于同步
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);

    __block NSString *filePath = nil;
    __block NSError *blockError = nil;
    
    // 创建 NSURLSessionDataTask
    NSURLSessionDataTask *task = [[NSURLSession sharedSession] dataTaskWithRequest:request
                                                                 completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable taskError) {
        // 错误处理
        if (taskError) {
            blockError = taskError;
        } else {
            // 如果下载成功，将文件写入到指定路径
            if ([data writeToFile:wgtDest atomically:YES]) {
                filePath = wgtDest;
            } else {
                // 如果写入文件失败，创建一个错误信息
                blockError = [NSError errorWithDomain:@"FileDownloadError"
                                                 code:1
                                             userInfo:@{NSLocalizedDescriptionKey: @"Could not write the file to the disk"}];
            }
        }
        
        // 释放 semaphore
        dispatch_semaphore_signal(semaphore);
    }];
    
    // 开始任务
    [task resume];
    
    // 等待任务完成
    dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
    
    // 如果外部错误处存在，给它赋值
    if (error && blockError) {
        *error = blockError;
    }
    
    return filePath;
}

@implementation DartHandler

+ (void)handleMethodCall:(FlutterMethodCall *)call result:(FlutterResult)result launchOptions:(NSDictionary *)launchOptions {
    NSString *method = call.method;
    NSDictionary *arguments = call.arguments;

    if ([method isEqualToString:@"open"]) {
        BOOL isRemote = arguments[@"remote"] ? [arguments[@"remote"] boolValue] : NO;
        NSString *appID = arguments[@"AppID"] ?: @"";
        NSLog(@"AppId: %@, isRemote: %@", appID, isRemote ? @"true" : @"false");
        if (isRemote) {
            NSString *baseURL = @"http://58.87.88.132:5000/package";
            NSString *AppUrl = [NSString stringWithFormat:@"%@/%@.wgt", baseURL, appID];
            NSError *downloadErr;
            NSString* wgtDest = downloadFileSync(AppUrl, appID, &downloadErr);
            if(downloadErr) {
                NSLog(@"❌ 下载%@ 失败, %@", AppUrl, downloadErr);
                return;
            }
            md5sum(wgtDest);
            NSError *installErr;
            if (![DCUniMPSDKEngine installUniMPResourceWithAppid:appID resourceFilePath:wgtDest password:nil error: &installErr]) {
                NSLog(@"❌ %@ 安装失败, %@", appID, installErr);
                return;
            }
            NSDictionary* info = [DCUniMPSDKEngine getUniMPVersionInfoWithAppid: appID];
            NSString *name = info[@"name"];
            NSNumber *code = info[@"code"];
            NSLog(@"✅ %@ 安装成功 版本信息: name: %@, code: %@", appID, name, code);
        }
        [self checkUniMPResoutceWithAppid:appID];
        [self openUniMPWithAppid:appID];
    } else {
        NSLog(@"method %@ not implemented", method);
    }
}

+ (void)downloadWgtFromURL:(NSString *)urlString forAppID:(NSString *)appID completion:(void (^)(BOOL success))completion {
    
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDownloadTask *downloadTask = [session downloadTaskWithURL:url completionHandler:^(NSURL *location, NSURLResponse *response, NSError *error) {
        if (error) {
            NSLog(@"❌ 下载 wgt 文件失败: %@", error.localizedDescription);
            completion(NO);
            return;
        }
        
        NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
        NSString *wgtDest = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.wgt", appID]];
        NSURL *destinationURL = [NSURL fileURLWithPath:wgtDest];
        
        NSFileManager *fileManager = [NSFileManager defaultManager];
        [fileManager removeItemAtURL:destinationURL error:nil];
        
        NSError *fileError;
        [fileManager copyItemAtURL:location toURL:destinationURL error:&fileError];
        
        if (fileError) {
            NSLog(@"❌ 移动 wgt 文件失败: %@", fileError.localizedDescription);
            completion(NO);
            return;
        } else {
            NSLog(@"✅ 下载 wgt 文件成功: %@", wgtDest);
            NSError *unzipErr;
            NSString *docPath = [documentsPath stringByStandardizingPath];
            NSArray *files = [fileManager contentsOfDirectoryAtPath: docPath error:&unzipErr];
            NSLog(@" %@ Err:%@", docPath,unzipErr);
            for (NSString *file in files) {
                NSLog(@"%@", file);
            }
            md5sum(wgtDest);
            
            NSError *installErr;
            BOOL ok = [DCUniMPSDKEngine installUniMPResourceWithAppid:appID resourceFilePath:wgtDest password:nil error: &installErr];
            if (!ok) {
                NSLog(@"❌ %@ 安装失败, %@", appID, installErr);

                 completion(NO);
                 return;
             }
            NSDictionary* info = [DCUniMPSDKEngine getUniMPVersionInfoWithAppid: appID];
            NSString *name = info[@"name"];
            NSNumber *code = info[@"code"];
            NSLog(@"✅ %@ 安装成功 版本信息: name: %@, code: %@", appID, name, code);
            
            completion(YES);
            return;
        }
    }];
    
    [downloadTask resume];
}


+ (void)checkUniMPResoutceWithAppid:(NSString *)appid {
        if ([DCUniMPSDKEngine isExistsUniMP:appid]) {
            NSDictionary *version = [DCUniMPSDKEngine getUniMPVersionInfoWithAppid:appid];
            NSString *name = version[@"code"];
            NSString *code = version[@"code"];
            NSLog(@"小程序：%@ 资源已存在，版本信息：name:%@ code:%@", appid, name, code);
        } else {
            @try {
                NSString *wgtPath = [[NSBundle mainBundle] pathForResource:appid ofType:@"wgt"] ?: @"";
                NSLog(@"wgtPath: %@", wgtPath);
                md5sum(wgtPath);
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

+ (void)openUniMPWithAppid:(NSString *)appid {
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
@end
