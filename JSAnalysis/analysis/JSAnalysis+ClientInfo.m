//
//  JSAnalysis+ClientInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  设备信息

#import "JSAnalysis+ClientInfo.h"
#import <UIKit/UIKit.h>
#import <sys/utsname.h>
#import <AdSupport/AdSupport.h>

@implementation JSAnalysis (ClientInfo)

+ (NSString *)getDeviceName {
    return [[UIDevice currentDevice] name] ?: @"NONE";
}

+ (NSString *)getDeviceModelID {
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *model = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    return model?:@"NONE";
}

+ (NSString *)getDeviceBrand {
    return @"Apple";
}

+ (NSString *)getOSVersion {
    return [[UIDevice currentDevice] systemVersion];
}

+ (NSString *)getManufacturer {
    return @"Apple";
}

+ (NSString *)getOSName {
    return [[UIDevice currentDevice] systemName];
}

+ (NSString *)getOSLanguage {
    NSArray *languageArray = [NSLocale preferredLanguages];
    if (languageArray.count) {
        return [languageArray objectAtIndex:0];
    } else {
        return @"NONE";
    }
}

+ (NSString *)getIDFV {
    return [UIDevice currentDevice].identifierForVendor.UUIDString ?: @"NONE";
}

+ (NSString *)getIDFA {
    return [[[ASIdentifierManager sharedManager] advertisingIdentifier] UUIDString] ?: @"NONE";
}

+ (NSString *)getUUID {
    CFUUIDRef puuid = CFUUIDCreate(nil);
    CFStringRef uuidString = CFUUIDCreateString(nil, puuid);
    NSString *result = (NSString *)CFBridgingRelease(CFStringCreateCopy( NULL, uuidString));
    return result?:@"NONE";
}

+ (BOOL)isSimulator {
#if TARGET_IPHONE_SIMULATOR  //模拟器
    return YES;
#elif TARGET_OS_IPHONE      //真机
    return NO;
#endif
}


+ (NSString *)isJailbroken {
    __block NSMutableString *reason = [NSMutableString string];
    
#if !(TARGET_IPHONE_SIMULATOR)
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        [reason appendString:@"can get Applications access"];
    }
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]) {
        [reason appendString:@"/found Cydia app"];
    } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]) {
        [reason appendString:@"/found MobileSubstrate.dylib"];
    } else if( [[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]) {
        [reason appendString:@"/found bash"];
    } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]) {
        [reason appendString:@"/found sshd"];
    } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]) {
        [reason appendString:@"/found apt"];
    } else if ([[NSFileManager defaultManager] fileExistsAtPath:@"/private/var/lib/apt/"]) {
        [reason appendString:@"/found lib apt"];
    }
    
    UIApplication *app = [JSAnalysis sharedApplication];
    dispatch_semaphore_t sema = dispatch_semaphore_create(0);
    dispatch_async(dispatch_get_main_queue(), ^{
        if (app && [app canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]) {
            [reason appendString:@"/open cydia example.package"];
        }
        dispatch_semaphore_signal(sema);
    });
    dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
    
    FILE *f = fopen("/bin/bash", "r");
    if (f != NULL) {
        fclose(f);
        [reason appendString:@"/open bash r access"];
    }
    fclose(f);
    f = fopen("/Applications/Cydia.app", "r");
    if (f != NULL) {
        fclose(f);
        [reason appendString:@"/open Cydia.app"];
    }
    fclose(f);
    f = fopen("/Library/MobileSubstrate/MobileSubstrate.dylib", "r");
    if (f != NULL) {
        fclose(f);
        [reason appendString:@"/open MobileSubstrate"];
    }
    fclose(f);
    f = fopen("/usr/sbin/sshd", "r");
    if (f != NULL) {
        fclose(f);
        [reason appendString:@"/open sbin sshd"];
    }
    
    fclose(f);
    f = fopen("/etc/apt", "r");
    if (f != NULL) {
        fclose(f);
        [reason appendString:@"/open etc apt"];
    }
    fclose(f);
    
    if (reason.length > 0) {
        return reason;
        
    }else{
        return @"NONE";
    }
    
#endif
    return @"NONE";
}

+ (NSString *)getTimeZone {
    [NSTimeZone resetSystemTimeZone]; // 重置手机系统的时区
    NSInteger offset = [NSTimeZone localTimeZone].secondsFromGMT;
    return [NSString stringWithFormat:@"%@ (GMT+%ldd) offset %ld",[NSTimeZone localTimeZone].name,offset/3600,(long)offset];
}

+ (float)getBatteryLevel {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    return [UIDevice currentDevice].batteryLevel;
}

+ (NSString *)getBatteryState {
    [UIDevice currentDevice].batteryMonitoringEnabled = YES;
    switch ([UIDevice currentDevice].batteryState) {
        case UIDeviceBatteryStateUnknown:
            return @"Unknown";
        case UIDeviceBatteryStateUnplugged:
            return @"Unplugged";
        case UIDeviceBatteryStateCharging:
            return @"Charging";
        case UIDeviceBatteryStateFull:
            return @"Full";
        default:
            return @"NONE";
            break;
    }
}

@end
