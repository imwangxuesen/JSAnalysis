//
//  JSAnalysis+AppInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  应用信息

#import "JSAnalysis.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (AppInfo)

/**
 获取应用名字

 @return eg:xxx
 */
+ (NSString *)getAppName;

/**
 获取应用唯一标识

 @return eg:com.wxs.analysis
 */
+ (NSString *)getAppBundleID;

/**
 获取应用版本

 @return eg:2.0.1
 */
+ (NSString *)getAppVersion;

/**
 获取SDK版本

 @return eg:1.0.3
 */
+ (NSString *)getAnalysisSDKVersion;

/**
 获取应用加载时间
 
 @return seconds eg 0.3462s
 */
+ (float)getAppLoadTime;


@end

NS_ASSUME_NONNULL_END
