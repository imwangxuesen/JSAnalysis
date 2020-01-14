//
//  JSAnalysis+SystemSourceInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  系统资源信息

#import "JSAnalysis.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (SystemSourceInfo)

/**
 获取APP CPU占用率

 @return eg:0.34442..
 */
+ (float)getAppCpuUsage;

/**
 获取全局（手机设备）的CPU占用率

 @return eg:0.44222..
 */
+ (float)getCpuUsage;

/**
 获取物理内存大小
 
 @return bytes,
 */
+ (unsigned long long)getPhysicalMemory API_AVAILABLE(macos(10.5), ios(2.0), watchos(2.0), tvos(9.0));

/**
 获取当前App占用内存的大小

 @return bytes
 */
+ (unsigned long long)getAppUsedMemory;

/**
 获取设备已经占用的内存

 @return bytes
 */
+ (int64_t)getUsedMemory;

/**
 获取内核版本

 @return eg:Darwin Kernel Version 18.2.0: Mon Nov 12 20:32:02 PST 2018; root:xnu-4333.232.2~1/RELEASE_ARM64_T8020
 */
+ (NSString *)getKernelVersion;

/**
 获取总存储空间

 @return bytes
 */
+ (unsigned long long)getTotalSpace;

/**
 空闲的存储空间

 @return bytes
 */
+ (unsigned long long)getFreeSpace;
@end

NS_ASSUME_NONNULL_END
