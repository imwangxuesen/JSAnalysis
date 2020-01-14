//
//  JSAnalysis+AppInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  

#import "JSAnalysis+AppInfo.h"
#import <mach/mach.h>
#import <mach/mach_host.h>
#import <UIKit/UIKit.h>


// 开始加载的时间
static uint64_t startLoadTime;
// 应用可以响应的时间
static uint64_t applicationRespondedTime = -1;
// 加载花费的时间
static float loadTime;
static mach_timebase_info_data_t timebaseInfo;

static inline NSTimeInterval MachTimeToSeconds(uint64_t machTime) {
    return ((machTime / 1e9) * timebaseInfo.numer)/(timebaseInfo.denom * 1.0);
}
@implementation JSAnalysis (AppInfo)

+ (void)load {
    startLoadTime = mach_absolute_time();
    mach_timebase_info(&timebaseInfo);
    
    @autoreleasepool {
        __block id<NSObject> obs;
        obs = [[NSNotificationCenter defaultCenter] addObserverForName:UIApplicationDidFinishLaunchingNotification object:nil queue:nil usingBlock:^(NSNotification *note) {
            dispatch_async(dispatch_get_main_queue(), ^{
                applicationRespondedTime = mach_absolute_time();
                loadTime = MachTimeToSeconds(applicationRespondedTime - startLoadTime);
            });
            [[NSNotificationCenter defaultCenter] removeObserver:obs];
        }];
    }
}

+ (float)getAppLoadTime {
    return loadTime;
}

+ (NSString *)getAppVersion {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    return [infoDictionary objectForKey:@"CFBundleShortVersionString"] ?: @"NONE";
}

+ (NSString *)getAnalysisSDKVersion {
    return @"0.1.3";
}

+ (NSString *)getAppBundleID {
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleIdentifier"] ?: @"NONE";
}

+ (NSString *)getAppName {
    
    NSString *bundleName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleName"]?:@"NONE";
    
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] ?: bundleName;
}

@end
