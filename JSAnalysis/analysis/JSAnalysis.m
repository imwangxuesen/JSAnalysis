//
//  JSAnalysis.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis.h"
#import "JSAnalysis+Userinfo.h"
#import "JSAnalysis+AppInfo.h"
#import "JSAnalysis+ClientInfo.h"
#import "JSAnalysis+NetInfo.h"
#import "JSAnalysis+ContentInfo.h"
#import "JSAnalysis+SIMCardInfo.h"
#import "JSAnalysis+ScreenInfo.h"
#import "JSAnalysis+SensorInfo.h"
#import "JSAnalysis+SystemSourceInfo.h"
#import "JSAnalysisEncryptionTool.h"

// 测试环境 url
static NSString *JSAnalysis_Debug_Url = @"https://www.baidu.com";
// 线上环境 url
static NSString *JSAnalysis_Online_Url = @"https://www.baidu.com";

@interface JSAnalysis()<NSURLSessionDataDelegate>
@property (nonatomic, copy) NSDictionary *cacheBoxInfo;

@property (nonatomic, strong) NSMutableData *data;


@end

@implementation JSAnalysis {
    
}

NSString *noneValue(NSString *value){
    return value?:@"NONE";
}

+ (instancetype)standardAnalysis {
    static JSAnalysis *_standard = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _standard = [[JSAnalysis alloc] init];
    });
    return _standard;
}

+ (UIApplication *)sharedApplication {
    Class UIApplicationClass = NSClassFromString(@"UIApplication");
    if (UIApplicationClass && [UIApplicationClass respondsToSelector:@selector(sharedApplication)]) {
        return [UIApplication performSelector:@selector(sharedApplication)];
    }
    return nil;
}

- (void)getAnalysisBoxWithOption:(JSAnalysisGetAnalysisBoxOption)option responseBlock:(void(^)(NSDictionary *analysisBoxInfo))block {
    switch (option) {
        case JSAnalysisGetAnalysisBoxOptionManual:{
            [self getAnalysisBoxWithResponseBlock:block upload:NO];

        }
            break;
        case JSAnalysisGetAnalysisBoxOptionForceAuto:{
            [self getAnalysisBoxWithResponseBlock:block upload:YES];

        }
            break;
        case JSAnalysisGetAnalysisBoxOptionIntelligentAuto:{
            if ([JSAnalysis getBatteryLevel] > self.batteryThreshold || [[JSAnalysis getBatteryState] isEqualToString:@"Charging"] || [JSAnalysis isSimulator]) {
                [self getAnalysisBoxWithResponseBlock:block upload:YES];
            }
        }
            break;
            
        default:
            break;
    }
}


- (void)getAnalysisBoxWithResponseBlock:(void(^)(NSDictionary *analysisBoxInfo))block upload:(BOOL)upload {
    [self getAllInfo:^(NSDictionary *infoDic) {
        NSLog(@"%@",infoDic);
        NSDictionary *boxInfo = [JSAnalysisEncryptionTool us_analysisEncryptWithDic:infoDic] ?: @{};
        self.cacheBoxInfo = boxInfo;
        
        if (block) {
            block(boxInfo);
        }
        
        if (upload) {
            [self uploadAnalysisBox:boxInfo];
        }
        
    }];
}

- (void)getAllInfo:(void(^)(NSDictionary *infoDic))responseBlock {
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //app_info
        NSString *appName = [JSAnalysis getAppName];
        NSString *appBundle = [JSAnalysis getAppBundleID];
        NSString *appVersion = [JSAnalysis getAppVersion];
        NSString *sdkVersion = [JSAnalysis getAnalysisSDKVersion];
        NSString *userId = self.userIdBlock? self.userIdBlock() : @"NONE";
        
        // client_info
        NSString *deviceName = [JSAnalysis getDeviceName];
        NSString *deviceModel = [JSAnalysis getDeviceModelID];
        NSString *brand = [JSAnalysis getDeviceBrand];
        NSString *osName = [JSAnalysis getOSName];
        NSString *osVersion = [JSAnalysis getOSVersion];
        NSString *osSDK = osVersion;
        NSString *manufacturer = [JSAnalysis getManufacturer];
        NSString *initialLanguage = [JSAnalysis getOSLanguage];
        NSString *timeZone = [JSAnalysis getTimeZone];
        NSString *dumpEnergy = [NSString stringWithFormat:@"%.2f",[JSAnalysis getBatteryLevel]];
        NSString *batteryState = [JSAnalysis getBatteryState];
        NSString *charging = [batteryState isEqualToString:@"Charging"] ? @"1" : @"0";
        NSString *uuid = [JSAnalysis getUUID];
        NSString *idfa = [JSAnalysis getIDFA];
        NSString *jailbroken = [JSAnalysis isJailbroken];
        NSString *simulator = [NSString stringWithFormat:@"%d",[JSAnalysis isSimulator]];
        NSString *cpuUsage = [NSString stringWithFormat:@"%.2f",[JSAnalysis getCpuUsage]];
        NSString *appCpuUsage = [NSString stringWithFormat:@"%.2f",[JSAnalysis getAppCpuUsage]];
        
        // net_info
        NSString *networkType = [JSAnalysis getNetworkType];
        NSString *SSID = [JSAnalysis getSSID];
        NSString *mac = @"NONE";
        if (![JSAnalysis isSimulator]) {
            mac = [JSAnalysis getWiFiMacAddress];
        }
        NSString *routerMac = [JSAnalysis getBSSID];
        NSDictionary *ipAddressInfo = [JSAnalysis getIPAddress];
        NSString *wifiIp = [ipAddressInfo objectForKey:JSAnalysis_NetInfoKey_WiFiIP];
        NSString *cellIp = [ipAddressInfo objectForKey:JSAnalysis_NetInfoKey_CellIP];
        
        NSDictionary *gateWayInfo = [JSAnalysis getGatewayInfo];
        NSString *routerAddress = noneValue([gateWayInfo objectForKey:JSAnalysis_NetInfoKey_ifa_addr]);
        //路由器广播地址
        NSString *routerDstaddr = noneValue([gateWayInfo objectForKey:JSAnalysis_NetInfoKey_ifa_dstaddr]);
        NSString *routerName = noneValue([gateWayInfo objectForKey:JSAnalysis_NetInfoKey_ifa_name]);
        NSString *routerNetmask = noneValue([gateWayInfo objectForKey:JSAnalysis_NetInfoKey_ifa_netmask]);
        NSString *routerGateway = noneValue([gateWayInfo objectForKey:JSAnalysis_NetInfoKey_ifa_gateway]);
        NSString *proxyIp = [JSAnalysis getNetworkProxy];
        NSString *bluetoothName = [JSAnalysis getDeviceName];
        
        // sim card info
        NSDictionary *info = [JSAnalysis getSIMCardInfo];
        NSString *voipStatus = [[info objectForKey:JSAnalysis_SIMCardInfoKey_AllowsVOIP] stringValue];
        NSString *simCountryIso = [info objectForKey:JSAnalysis_SIMCardInfoKey_ISOCountryCode];
        NSString *simOperatorName = [info objectForKey:JSAnalysis_SIMCardInfoKey_CarrierName];
        NSString *simOperator = [info objectForKey:JSAnalysis_SIMCardInfoKey_MobileNetworkCode];
        NSString *mobileCountryCode = [info objectForKey:JSAnalysis_SIMCardInfoKey_MobileCountryCode];
        
        // 网络制式
        NSString *radioType = [info objectForKey:JSAnalysis_SIMCardInfoKey_RadioAccessTechnology];
        NSString *simState = @"UNKNOW";
        if (!([simCountryIso isEqualToString:@"NONE"] && [mobileCountryCode isEqualToString:@"NONE"] && [simOperator isEqualToString:@"NONE"])) {
            simState = @"INSTALL";
        }
        
        NSString *screenWidth = [NSString stringWithFormat:@"%.0f",[JSAnalysis getScreenWidth]];
        NSString *screenHeight = [NSString stringWithFormat:@"%.0f",[JSAnalysis getScreenHeight]];
        NSString *density = [NSString stringWithFormat:@"%.0f",[JSAnalysis getScreenDensity]];
        NSString *screenBrightness = [NSString stringWithFormat:@"%.0f",[JSAnalysis getScreenBrigtness]];
        
        NSDictionary *gpsStatusInfo = [JSAnalysis getGPSStatusInfo];
        NSString *gpsSwitch = [gpsStatusInfo objectForKey:JSAnalysis_SensorInfoKey_GPSSwitch];
        if (![gpsSwitch isKindOfClass:[NSString class]]) {
            gpsSwitch = gpsSwitch ? @"1" :@"0";
        }
        NSString *gpsStatus = [gpsStatusInfo objectForKey:JSAnalysis_SensorInfoKey_GPSAuthorizationStatus];
        
        NSString *totalMemoryStr = [NSString stringWithFormat:@"%lld",[JSAnalysis getPhysicalMemory]] ?: @"NONE";
        NSString *usedMemoryStr = [NSString stringWithFormat:@"%lld",[JSAnalysis getUsedMemory]] ?: @"NONE";
        NSString *appUsedMemoryStr = [NSString stringWithFormat:@"%lld",[JSAnalysis getAppUsedMemory]] ?: @"NONE";
        
        
        NSString *totalSpaceStr = [NSString stringWithFormat:@"%lld",[JSAnalysis getTotalSpace]] ?: @"NONE";
        NSString *freeSpaceStr = [NSString stringWithFormat:@"%lld",[JSAnalysis getFreeSpace]] ?: @"NONE";

        
        NSString *kernelVersion = [JSAnalysis getKernelVersion];
        
        NSDictionary *timeInfo = [JSAnalysis getSystemTimeInfo];
        // 现在时间
        NSString *nowTime = [timeInfo objectForKey:JSAnalysis_SensorInfoKey_NowTime];
        // 系统启动时间
        NSString *bootTime = [timeInfo objectForKey:JSAnalysis_SensorInfoKey_BootTime];
        // 运行时间
        NSString *upTime = [timeInfo objectForKey:JSAnalysis_SensorInfoKey_Uptime];
        
        dispatch_group_t group = dispatch_group_create();
        

#if !TARGET_IPHONE_SIMULATOR
        
        __block NSInteger gpsLeaveCount = 1;
        dispatch_group_enter(group);
        [JSAnalysis getGPSLocation:^(CLLocation *location, NSError *error) {
            if (gpsLeaveCount < 1) return;
            
            if (gpsLeaveCount == 1) {
                dispatch_group_leave(group);
            }
            gpsLeaveCount--;
            
        }];
#endif
    
        NSString *launchTime = @"NONE";
//        if ([osVersion intValue] >= 8) {
//            dispatch_group_enter(group);
//            dispatch_async(dispatch_get_main_queue(), ^{
                launchTime = [JSAnalysis getAppLoadTime] ? [@([JSAnalysis getAppLoadTime]) stringValue] : @"NONE";
//                dispatch_group_leave(group);
//            });
//        }
        
        dispatch_group_notify(group, dispatch_get_main_queue(), ^{
#if TARGET_IPHONE_SIMULATOR
            NSString *tempLongitude = @"SIMULATOR_FALSE_DATE";
            NSString *tempLatitude = @"SIMULATOR_FALSE_DATE";
#endif
            
#if !TARGET_IPHONE_SIMULATOR
            CLLocationDegrees tpLatitude = [[JSAnalysisGPSLocationTool defaultLocationManager] currentLatitude];
            NSString *tempLatitude = tpLatitude? [NSString stringWithFormat:@"%lf",tpLatitude] : @"NONE";

            CLLocationDegrees tpLongitude = [[JSAnalysisGPSLocationTool defaultLocationManager] currentLongitude];
            NSString *tempLongitude = tpLongitude ? [NSString stringWithFormat:@"%lf",tpLongitude] : @"NONE";
#endif
            
            NSDictionary *resDic = @{
                                     @"appInfo":@{
                                             @"appName":appName,
                                             @"appBundle":appBundle,
                                             @"appVersion":appVersion,
                                             @"sdkVersion":sdkVersion,
                                             @"launchTime":launchTime,
                                             @"userId":userId
                                             },
                                     @"clientInfo":@{
                                             @"deviceName":deviceName,
                                             @"deviceModel":deviceModel,
                                             @"brand":brand,
                                             @"osName":osName,
                                             @"osVersion":osVersion,
                                             @"osSDK":osSDK,
                                             @"manufacturer":manufacturer,
                                             @"initialLanguage":initialLanguage,
                                             @"timeZone":timeZone,
                                             @"dumpEnergy":dumpEnergy,
                                             @"batteryState":batteryState,
                                             @"charging":charging,
                                             @"UUID":uuid,
                                             @"IDFA":idfa,
                                             @"jailbroken":jailbroken,
                                             @"simulator":simulator,
                                             @"cpuUsage":cpuUsage,
                                             @"appCpuUsage":appCpuUsage,
                                             @"kernelVersion":kernelVersion,
                                             @"bootTime":bootTime,
                                             @"upTime":upTime,
                                             @"nowTime":nowTime
                                             },
                                     @"netInfo":@{
                                             @"networkType":networkType,
                                             @"SSID":SSID,
                                             @"mac":mac,
                                             @"routerAddress":routerAddress,
                                             @"routerMac":routerMac,
                                             @"cellIp":cellIp,
                                             @"wifiIp":wifiIp,
                                             @"proxyIp":proxyIp,
                                             @"bluetoothName":bluetoothName,
                                             @"voipStatus":voipStatus,
                                             @"radioType":radioType,
                                             @"routerDstaddr":routerDstaddr,
                                             @"routerGateway":routerGateway,
                                             @"routerName":routerName,
                                             @"routerNetmask":routerNetmask,

                                             },
                                     
                                     @"phoneCardInfo":@{
                                             @"simCountryIso":simCountryIso,
                                             @"simOperatorName":simOperatorName,
                                             @"simOperator":simOperator,
                                             @"mobileCountryCode":mobileCountryCode,
                                             @"simState":simState
                                             },
                                     @"screenInfo":@{
                                             @"screenWidth":screenWidth,
                                             @"screenHeight":screenHeight,
                                             @"density":density,
                                             @"screenBrightness":screenBrightness
                                             },
                                     @"sensorInfo":@{
                                             @"gpsLongitude":tempLongitude,
                                             @"gpsLatitude":tempLatitude,
                                             @"gpsStatus":gpsStatus,
                                             @"gpsSwitch":gpsSwitch,
                                             },
                                     
                                     @"storageInfo":@{
                                             @"totalMemory":totalMemoryStr,
                                             @"usedMemory":usedMemoryStr,
                                             @"appUsedMemory":appUsedMemoryStr,
                                             @"totalSpace":totalSpaceStr,
                                             @"freeSpace":freeSpaceStr,
                                             }
                                     };
            if (responseBlock) {
                responseBlock(resDic);
            }
        });
    });
}

#pragma mark - Request
- (void)uploadAnalysisBox:(nonnull NSDictionary *)analysisBox {
    
    self.data = [NSMutableData data];
    NSURL *url = self.debug ? [NSURL URLWithString:JSAnalysis_Debug_Url] : [NSURL URLWithString:JSAnalysis_Online_Url];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"POST"];
    [request addValue:@"application/x-www-form-urlencoded ;charset=utf-8" forHTTPHeaderField:@"Content-Type"];

    [self.data appendData:[[NSString stringWithFormat:@"appBundle=%@&clientId=%@&sdkVersion=%@&sign=%@&timestamp=%@&jsBox=%@&userId=%@",analysisBox[@"appBundle"],analysisBox[@"clientId"],analysisBox[@"sdkVersion"],analysisBox[@"sign"],analysisBox[@"timestamp"],analysisBox[@"jsBox"],analysisBox[@"userId"]] dataUsingEncoding:NSUTF8StringEncoding]];
    
    [request setHTTPBody:self.data];

    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request];
    [dataTask resume];
}

#pragma mark - NSURLSessionDataDelegate
- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler {
    completionHandler(NSURLSessionResponseAllow);
}

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data{
    [self.data appendData:data];
}

- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error {
    if(error) {// 重传
        JSLog(@"JSAnalysis Upload box error: %@",error);
    }
    NSString *result =[[ NSString alloc] initWithData:self.data encoding:NSUTF8StringEncoding];
    JSLog(@"JSAnalysis Upload box status: %@",result);
}

#pragma mark - Getter
- (CGFloat)batteryThreshold {
    if (!_batteryThreshold) {
        _batteryThreshold = 0.2;
    }
    return _batteryThreshold;
}

@end
