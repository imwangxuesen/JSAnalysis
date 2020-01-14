//
//  JSAnalysis+ClientInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  设备信息

#import "JSAnalysis.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (ClientInfo)

/**
 设备名称

 @return eg:xxx的iPhone8
 */
+ (NSString *)getDeviceName;

/**
 获取Model ID (设备型号id)
 https://www.blakespot.com/ios_device_specifications_grid.html
 对照表可以查询到某一类设备的详细硬件信息
 @return iPhone4,1
 */
+ (NSString *)getDeviceModelID;

/**
 获取设备品牌

 @return Apple
 */
+ (NSString *)getDeviceBrand;

/**
 获取系统名称

 @return iOS
 */
+ (NSString *)getOSName;

/**
 获取系统版本号

 @return 12.1
 */
+ (NSString *)getOSVersion;

/**
 获取设备制造商

 @return Apple
 */
+ (NSString *)getManufacturer;

/**
 获取系统当前语言
 
 @return eg:en
 */
+ (NSString *)getOSLanguage;

/**
 获取IDFV
 */
+ (NSString *)getIDFV;

/**
 获取广告标识符

 @return 9C287922-EE26-4422-661D-DDE6F83D3475
 */
+ (NSString *)getIDFA;

/**
 获取UUID

 @return 9C287922-EE26-4422-661D-DDE6F83D3475
 */
+ (NSString *)getUUID;

/**
 是否是模拟器

 @return YES/NO
 */
+ (BOOL)isSimulator;

/**
 是否越狱
 如果越狱返回判断原因
 如果没有返回nil
 */
+ (NSString *)isJailbroken;

/**
 获取时区信息

 @return eg:Asia/Shanghai (GMT+8) offset 28800
 */
+ (NSString *)getTimeZone;

/**
 获取剩余电量
 
 @return 0-1.0的小数 eg:0.33
 */
+ (float)getBatteryLevel;

/**
 获取电池状态
 Unknown: 未知状态
 Unplugged: 未插电
 Charging: 充电中
 Full: 充电中/并且已经充满
 */
+ (NSString *)getBatteryState;

@end

NS_ASSUME_NONNULL_END
