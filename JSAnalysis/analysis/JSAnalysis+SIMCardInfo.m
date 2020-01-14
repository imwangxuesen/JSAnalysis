//
//  JSAnalysis+SIMCardInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis+SIMCardInfo.h"
#import <CoreTelephony/CTTelephonyNetworkInfo.h>
#import <CoreTelephony/CTCarrier.h>

NSString *const JSAnalysis_SIMCardInfoKey_AllowsVOIP = @"JSAnalysis_SIMCardInfoKey_AllowsVOIP";
NSString *const JSAnalysis_SIMCardInfoKey_CarrierName = @"JSAnalysis_SIMCardInfoKey_CarrierName";
NSString *const JSAnalysis_SIMCardInfoKey_ISOCountryCode = @"JSAnalysis_SIMCardInfoKey_ISOCountryCode";
NSString *const JSAnalysis_SIMCardInfoKey_MobileCountryCode = @"JSAnalysis_SIMCardInfoKey_MobileCountryCode";
NSString *const JSAnalysis_SIMCardInfoKey_MobileNetworkCode = @"JSAnalysis_SIMCardInfoKey_MobileNetworkCode";
NSString *const JSAnalysis_SIMCardInfoKey_RadioAccessTechnology = @"JSAnalysis_SIMCardInfoKey_RadioAccessTechnology";

@implementation JSAnalysis (SIMCardInfo)

/**
 #import <CoreTelephony/CTTelephonyNetworkInfo.h>
 #import <CoreTelephony/CTCarrier.h>
 sim卡信息
 */
+ (NSDictionary *)getSIMCardInfo{
    CTTelephonyNetworkInfo *info = [[CTTelephonyNetworkInfo alloc] init];
    CTCarrier *carrier = nil;
    NSString *radioType = nil;
    if (@available(iOS 12.1, *)) {
        
        if (info && [info respondsToSelector:@selector(serviceSubscriberCellularProviders)]) {
            
            NSDictionary *dic = [info serviceSubscriberCellularProviders];
            if (dic.allKeys.count) {
                carrier = [dic objectForKey:dic.allKeys[0]];
            }
        }
        
        if (info && [info respondsToSelector:@selector(serviceCurrentRadioAccessTechnology)]) {
            
            NSDictionary *radioDic = [info serviceCurrentRadioAccessTechnology];
            if (radioDic.allKeys.count) {
                radioType = [radioDic objectForKey:radioDic.allKeys[0]];
            }
        }
        
        
    } else {
        carrier = [info subscriberCellularProvider];
        radioType = [info currentRadioAccessTechnology];

    }
    
    //运营商可用
    BOOL use = carrier.allowsVOIP;
    //运营商名字
    NSString *name = carrier.carrierName;
    //ISO国家代码
    NSString *code = carrier.isoCountryCode;
    //移动国家代码
    NSString *mcc = [carrier mobileCountryCode];
    //移动网络代码
    NSString *mnc = [carrier mobileNetworkCode];
    return @{
             JSAnalysis_SIMCardInfoKey_AllowsVOIP:@(use),
             JSAnalysis_SIMCardInfoKey_CarrierName:name?:@"NONE",
             JSAnalysis_SIMCardInfoKey_ISOCountryCode:code?:@"NONE",
             JSAnalysis_SIMCardInfoKey_MobileCountryCode:mcc?:@"NONE",
             JSAnalysis_SIMCardInfoKey_MobileNetworkCode:mnc?:@"NONE",
             JSAnalysis_SIMCardInfoKey_RadioAccessTechnology:radioType?:@"NONE"
             };
}

@end
