//
//  JSAnalysis+NetInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//  网络信息

#import "JSAnalysis.h"

// 蜂窝网络IP
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_CellIP;
// 无线局域网IP
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_WiFiIP;
// 路由器地址
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_ifa_addr;
// 路由器广播地址
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_ifa_dstaddr;
// 路由器子网掩码
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_ifa_netmask;
// 路由器名称
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_ifa_name;
// 路由器网关
FOUNDATION_EXTERN NSString *const JSAnalysis_NetInfoKey_ifa_gateway;

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (NetInfo)

/**
 获取网络类型
 NONE、WWAN、WIFI

 */
+ (NSString *)getNetworkType;

/**
 获取无线局域网名称
 WiFi 名称
 
 ⚠️ 在iOS12.0以上的系统获取需要打开工程的TARGETS -> Capabilities -> Access WiFi Information 开关（和推送开关在一个地方）
 
 eg: cmcc
 */
+ (NSString *)getSSID;

/**
 获取WiFi BSSID

 ⚠️ 在iOS12.0以上的系统获取需要打开工程的TARGETS -> Capabilities -> Access WiFi Information 开关（和推送开关在一个地方）

 @return eg:"ac:29:3a:99:33:45" / NONE
 */
+ (NSString *)getBSSID;

/**
 获取代理信息
 如果是手动代理 return ip+port
 如果是自动代理 return ip/url
 */
+ (NSString *)getNetworkProxy;

/**
 网关信息
 
 {
    // 本机地址
    JSAnalysis_NetInfoKey_ifa_addr = "10.255.24.25";
    // 广播地址
    JSAnalysis_NetInfoKey_ifa_dstaddr = "10.255.24.255";
    // 名字
    JSAnalysis_NetInfoKey_ifa_name = "101.110.49.0";
    // 子网掩码
    JSAnalysis_NetInfoKey_ifa_netmask = "255.255.255.0";
    // 网关
    JSAnalysis_NetInfoKey_ifa_gateway = "173.190.9.22";
 }
 */
+ (NSDictionary *)getGatewayInfo;

/**
 获取WIFI IP 和 蜂窝IP

 @return @{
            JSAnalysis_NetInfoKey_CellIP:cellIP ?: @"NONE",
            JSAnalysis_NetInfoKey_WiFiIP:wifiIP ?: @"NONE"
          };
 */
+ (NSDictionary *)getIPAddress;

/**
 获取当前网口的总流量
 如果想要获取当前即时网速需要记录上一次和本次的总流量做差值，
 然后除以时间，建议用秒为一个单位。
 
 配合 “+ (NSString *)formatNetWorkBytes:(long long int)rate” 方法使用可以格式化网速

 @return 当前网口bytes总值
 */
+ (long long int)getInterfaceBytes;

/**
 格式化网速

 @param rate 流量
 @return B/秒 .1fKB/秒 .2fMB/秒 .2fGB/秒
 */
+ (NSString *)formatNetWorkBytes:(long long int)rate;

/**
 获取蓝牙名称
 同手机自定义别名
 */
+ (NSString *)getBluetoothName;

/**
 获取DNS服务器列表

 @return eg:@"10.6.22.100,10.5.22.12"
 */
+ (NSString *)getDNSServers;

/**
 获取无线局域网MAC
 ⚠️ 需要连接WIFI，否则获取值为@”02:00:00:00:00:00"

 @return @”02:00:00:00:00:00" 或者 真实的MAC地址
 */
+ (nullable NSString *)getWiFiMacAddress;
@end

NS_ASSUME_NONNULL_END
