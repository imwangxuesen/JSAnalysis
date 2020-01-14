//
//  JSAnalysis+SensorInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis+SensorInfo.h"
#include <sys/sysctl.h>
#import <CoreLocation/CoreLocation.h>

NSString *const JSAnalysis_SensorInfoKey_NowTime = @"JSAnalysis_SensorInfoKey_NowTime";
NSString *const JSAnalysis_SensorInfoKey_BootTime = @"JSAnalysis_SensorInfoKey_BootTime";
NSString *const JSAnalysis_SensorInfoKey_Uptime = @"JSAnalysis_SensorInfoKey_Uptime";

NSString *const JSAnalysis_SensorInfoKey_GPSSwitch = @"JSAnalysis_SensorInfoKey_GPSSwitch";
NSString *const JSAnalysis_SensorInfoKey_GPSAuthorizationStatus = @"JSAnalysis_SensorInfoKey_GPSAuthorizationStatus";



@implementation JSAnalysis (SensorInfo)

+ (NSDictionary *)getSystemTimeInfo {
    struct timeval boottime;
    int mib[2] = {CTL_KERN, KERN_BOOTTIME};
    size_t size = sizeof(boottime);
    struct timeval now;
    struct timezone tz;
    gettimeofday(&now, &tz);
    long long int uptime = 0;
    if (sysctl(mib, 2, &boottime, &size, NULL, 0) != -1 && boottime.tv_sec != 0) {
        long long int nowTime = now.tv_sec;
        long long int bootTime = boottime.tv_sec;
        uptime = nowTime - bootTime;
        
        NSString *nowTimeStr = [NSString stringWithFormat:@"%lld",nowTime]?:@"NONE";
        NSString *bootTimeStr = [NSString stringWithFormat:@"%lld",bootTime]?:@"NONE";
        NSString *upTimeStr = [NSString stringWithFormat:@"%lld",uptime]?:@"NONE";
        
        return @{JSAnalysis_SensorInfoKey_NowTime:nowTimeStr,
                 JSAnalysis_SensorInfoKey_BootTime:bootTimeStr,
                 JSAnalysis_SensorInfoKey_Uptime:upTimeStr};
    }
    return @{};
}

+ (NSDictionary *)getGPSStatusInfo {
    
    BOOL locationServicesEnabled = [CLLocationManager locationServicesEnabled];
    CLAuthorizationStatus status =[CLLocationManager authorizationStatus];
    NSString *statusStr = nil;
    switch (status) {
        case kCLAuthorizationStatusNotDetermined:
            statusStr = @"NotDetermined";
            break;
        case kCLAuthorizationStatusRestricted:
            statusStr = @"Restricted";
            break;
        case kCLAuthorizationStatusDenied:
            statusStr = @"Denied";
            break;
        case kCLAuthorizationStatusAuthorizedAlways:
            statusStr = @"Always";
            break;
        case kCLAuthorizationStatusAuthorizedWhenInUse:
            statusStr = @"WhenInUse";
            break;
        default:
            statusStr = @"NONE";
            break;
    }
    
    NSString *switchStr = @"NONE";
    if (locationServicesEnabled) {
        switchStr = @"1";
    } else {
        switchStr = @"0";
    }
    
    return @{
             JSAnalysis_SensorInfoKey_GPSSwitch:switchStr,
             JSAnalysis_SensorInfoKey_GPSAuthorizationStatus:statusStr
             };
    
}

+ (void)getGPSLocation:(JSAnalysisGPSResponseBlock)block {
    dispatch_async(dispatch_get_main_queue(), ^{
        JSAnalysisGPSLocationTool *tool = [JSAnalysisGPSLocationTool defaultLocationManager];
        tool.responseBlock = block;
        [tool fetchLocationInfo];
    });
}

@end
