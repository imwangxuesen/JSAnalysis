//
//  JSAnalysis+SensorInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis.h"
#import "JSAnalysisGPSLocationTool.h"

// 现在的时间
FOUNDATION_EXTERN NSString *const JSAnalysis_SensorInfoKey_NowTime;
// 系统启动时间
FOUNDATION_EXTERN NSString *const JSAnalysis_SensorInfoKey_BootTime;
// 系统运行时间
FOUNDATION_EXTERN NSString *const JSAnalysis_SensorInfoKey_Uptime;

// GPS开关
FOUNDATION_EXTERN NSString *const JSAnalysis_SensorInfoKey_GPSSwitch;
// GPS认证状态
FOUNDATION_EXTERN NSString *const JSAnalysis_SensorInfoKey_GPSAuthorizationStatus;


NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (SensorInfo)

/**
 获取系统时间信息
 系统启动时间、运行时长、现在时间
 
 单位:秒
 
 @return return @{  JSAnalysis_SensorInfoKey_NowTime:@(nowTime),
                    JSAnalysis_SensorInfoKey_BootTime:@(bootTime),
                    JSAnalysis_SensorInfoKey_Uptime:@(uptime)}
 */
+ (NSDictionary *)getSystemTimeInfo;

/**
 获取GPS状态信息
 GPS开关状态、授权认证状态
 
 @return return @{
                JSAnalysis_SensorInfoKey_GPSSwitch:@(locationServicesEnabled),
                JSAnalysis_SensorInfoKey_GPSAuthorizationStatus:statusStr
 };
 */
+ (NSDictionary *)getGPSStatusInfo;

+ (void)getGPSLocation:(JSAnalysisGPSResponseBlock)block;

@end

NS_ASSUME_NONNULL_END
