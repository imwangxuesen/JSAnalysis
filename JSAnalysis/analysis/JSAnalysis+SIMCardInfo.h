//
//  JSAnalysis+SIMCardInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis.h"

// 是否允许VOIP
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_AllowsVOIP;
// 运行商名称
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_CarrierName;
// ISO国家代码
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_ISOCountryCode;
// 移动网络国家代码
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_MobileCountryCode;
// 移动网络代码
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_MobileNetworkCode;
// 网络制式
FOUNDATION_EXTERN NSString *const JSAnalysis_SIMCardInfoKey_RadioAccessTechnology;

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (SIMCardInfo)

/**
 获取SIM卡信息
 
 可根据
 JSAnalysis_SIMCardInfoKey_ISOCountryCode
 JSAnalysis_SIMCardInfoKey_MobileCountryCode
 JSAnalysis_SIMCardInfoKey_MobileNetworkCode
 三个key对应value是否为@”NONE“来判断是否插入了SIM卡。
 如果都为@”NONE“为未插入SIM卡。

 return @{
    JSAnalysis_SIMCardInfoKey_AllowsVOIP:@(use),
    JSAnalysis_SIMCardInfoKey_CarrierName:name?:@"NONE",
    JSAnalysis_SIMCardInfoKey_ISOCountryCode:code?:@"NONE",
    JSAnalysis_SIMCardInfoKey_MobileCountryCode:mcc?:@"NONE",
    JSAnalysis_SIMCardInfoKey_MobileNetworkCode:mnc?:@"NONE",
    JSAnalysis_SIMCardInfoKey_RadioAccessTechnology:radioType?:@"NONE"
 };
 */
+ (NSDictionary *)getSIMCardInfo API_UNAVAILABLE(macos, tvos);

@end

NS_ASSUME_NONNULL_END
