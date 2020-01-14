//
//  JSAnalysis+NetInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis+NetInfo.h"
#import "JSReachability.h"
#import <SystemConfiguration/CaptiveNetwork.h>
#import <ifaddrs.h>
#import <arpa/inet.h>
#import <sys/sysctl.h>
#import <net/if.h>
#import <net/if_dl.h>
#import <netinet/in.h>
#import "getgateway.h"
#import <UIKit/UIKit.h>
#include <resolv.h>
#include <dns.h>
#import <resolv.h>
#import <netdb.h>
#import <netinet/ip.h>
#import <net/ethernet.h>

NSString *const JSAnalysis_NetInfoKey_CellIP = @"JSAnalysis_NetInfoKey_CellIP";
NSString *const JSAnalysis_NetInfoKey_WiFiIP = @"JSAnalysis_NetInfoKey_WiFiIP";

NSString *const JSAnalysis_NetInfoKey_ifa_addr = @"JSAnalysis_NetInfoKey_ifa_addr";
NSString *const JSAnalysis_NetInfoKey_ifa_dstaddr = @"JSAnalysis_NetInfoKey_ifa_dstaddr";
NSString *const JSAnalysis_NetInfoKey_ifa_netmask = @"JSAnalysis_NetInfoKey_ifa_netmask";
NSString *const JSAnalysis_NetInfoKey_ifa_name = @"JSAnalysis_NetInfoKey_ifa_name";
NSString *const JSAnalysis_NetInfoKey_ifa_gateway = @"JSAnalysis_NetInfoKey_ifa_gateway";

NSString *const JSAnalysis_IP_ADDR_IPv4 = @"ipv4";
NSString *const JSAnalysis_IP_ADDR_IPv6 = @"ipv6";
NSString *const JSAnalysis_Default_MAC = @"02:00:00:00:00:00";
#define JSAnalysis_mDNS_Group_Name "_apple-mobdev2._tcp.local"


struct js_analysis_info {
    NSString *ifa_name;
    NSString *ifa_addr;
    NSString *ifa_netmask;
    NSString *ifa_dstaddr;
    NSString *ifa_flags;
};

@implementation JSAnalysis (NetInfo)

+ (NSString *)getNetworkType {
    JSReachability *reachability = [JSReachability reachabilityForInternetConnection];
    [reachability startNotifier];
    
    NetworkStatus status = [reachability currentReachabilityStatus];
    
    if (status == ReachableViaWiFi) {
        return @"WiFi";
    } else if (status == ReachableViaWWAN) {
        return @"WWAN";
    }
    
    return @"NONE";
    
}

+ (NSString *)getSSID {
    return [JSAnalysis getWiFiInfoWithKey:@"SSID"];
}

+ (NSString *)getBSSID {
    return [JSAnalysis getWiFiInfoWithKey:@"BSSID"];
}

+ (NSString *)getWiFiInfoWithKey:(NSString *)key {
    NSString *currentSSID = @"NONE";
    CFArrayRef myArray = CNCopySupportedInterfaces();
    if (myArray != nil){
        NSDictionary* myDict = (__bridge NSDictionary *) CNCopyCurrentNetworkInfo(CFArrayGetValueAtIndex(myArray, 0));
        if (myDict!=nil){
            currentSSID = [myDict valueForKey:key]?:@"NONE";
            /* myDict包含信息：
             {
             BSSID = "ac:29:3a:99:33:45";
             SSID = "三千";
             SSIDDATA = <e4b889e5 8d83>;
             }
             */
        } else {
            currentSSID=@"NONE";
        }
        CFRelease(myArray);

    } else {
        currentSSID=@"NONE";
    }
    return currentSSID;
}

+ (NSString *)getNetworkProxy {
    CFDictionaryRef dicRef = CFNetworkCopySystemProxySettings();
    CFBooleanRef proxyAuto = (const CFBooleanRef)CFDictionaryGetValue(dicRef,(const void*)kCFNetworkProxiesProxyAutoConfigEnable);
    CFBooleanRef proxyHTTPManual = (const CFBooleanRef)CFDictionaryGetValue(dicRef,(const void*)kCFNetworkProxiesHTTPEnable);
    if (proxyAuto) {
        return (__bridge NSString *)(const CFStringRef)CFDictionaryGetValue(dicRef,(const void*)kCFNetworkProxiesProxyAutoConfigURLString) ?: @"NONE";
        
    } else if (proxyHTTPManual) {
        NSString *ip = (__bridge NSString *)(const CFStringRef)CFDictionaryGetValue(dicRef,(const void*)kCFNetworkProxiesHTTPProxy);
        NSString *port = (__bridge NSString *)(const CFStringRef)CFDictionaryGetValue(dicRef,(const void*)kCFNetworkProxiesHTTPPort);
        return [NSString stringWithFormat:@"%@:%@",ip,port] ?: @"NONE";
        
    }
    
    return  @"NONE";
}

+ (NSDictionary *)getGatewayInfo {
    NSString *address = @"NONE";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    NSMutableDictionary *infoDic = [NSMutableDictionary new];
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0) {
        temp_addr = interfaces;
        while(temp_addr != NULL) {
            if(temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // 本机地址
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                    
                    //router IP----192.168.1.255 广播地址
                    NSString *ifa_dstaddr = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_dstaddr)->sin_addr)];
                    
                    //--255.255.255.0 子网掩码地址
                    NSString *ifa_netmask = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_netmask)->sin_addr)];
                    
                    //--en0 接口
                    //  en0       Ethernet II    protocal interface
                    //  et0       802.3             protocal interface
                    //  ent0      Hardware device interface
                    NSString *ifa_name = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_name)->sin_addr)];
                    
                    [infoDic setObject:address?:@"NONE" forKey:JSAnalysis_NetInfoKey_ifa_addr];
                    [infoDic setObject:ifa_dstaddr?:@"NONE" forKey:JSAnalysis_NetInfoKey_ifa_dstaddr];
                    [infoDic setObject:ifa_netmask?:@"NONE" forKey:JSAnalysis_NetInfoKey_ifa_netmask];
                    [infoDic setObject:ifa_name?:@"NONE" forKey:JSAnalysis_NetInfoKey_ifa_name];
                    
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    in_addr_t i = inet_addr([address cStringUsingEncoding:NSUTF8StringEncoding]);
    in_addr_t* x = &i;
    unsigned char *s = getdefaultgateway(x);
    free(s);
    NSString *routerIp = [NSString stringWithFormat:@"%d.%d.%d.%d",s[0],s[1],s[2],s[3]];
    [infoDic setObject:routerIp?:@"NONE" forKey:JSAnalysis_NetInfoKey_ifa_gateway];
    return infoDic;
}

+ (NSDictionary *)getIPAddresses
{
    NSMutableDictionary *addresses = [NSMutableDictionary dictionaryWithCapacity:8];
    
    // retrieve the current interfaces - returns 0 on success
    struct ifaddrs *interfaces;
    if(!getifaddrs(&interfaces)) {
        // Loop through linked list of interfaces
        struct ifaddrs *interface;
        for(interface=interfaces; interface; interface=interface->ifa_next) {
            if(!(interface->ifa_flags & IFF_UP) /* || (interface->ifa_flags & IFF_LOOPBACK) */ ) {
                continue; // deeply nested code harder to read
            }
            const struct sockaddr_in *addr = (const struct sockaddr_in*)interface->ifa_addr;
            char addrBuf[ MAX(INET_ADDRSTRLEN, INET6_ADDRSTRLEN) ];
            if(addr && (addr->sin_family==AF_INET || addr->sin_family==AF_INET6)) {
                NSString *name = [NSString stringWithUTF8String:interface->ifa_name];
                NSString *type;
                if(addr->sin_family == AF_INET) {
                    if(inet_ntop(AF_INET, &addr->sin_addr, addrBuf, INET_ADDRSTRLEN)) {
                        type = JSAnalysis_IP_ADDR_IPv4;
                    }
                } else {
                    const struct sockaddr_in6 *addr6 = (const struct sockaddr_in6*)interface->ifa_addr;
                    if(inet_ntop(AF_INET6, &addr6->sin6_addr, addrBuf, INET6_ADDRSTRLEN)) {
                        type = JSAnalysis_IP_ADDR_IPv6;
                    }
                }
                if(type) {
                    NSString *key = [NSString stringWithFormat:@"%@/%@", name, type];
                    addresses[key] = [NSString stringWithUTF8String:addrBuf];
                }
            }
        }
        // Free memory
        freeifaddrs(interfaces);
    }
    return [addresses count] ? addresses : nil;
}

+ (NSDictionary *)getIPAddress {
    NSDictionary *addresses = [JSAnalysis getIPAddresses];
    NSString *wifiIP = [addresses objectForKey:@"en0/ipv4"];
    NSString *cellIP = [addresses objectForKey:@"pdp_ip0/ipv4"];
    
    return @{JSAnalysis_NetInfoKey_CellIP:cellIP ?: @"NONE",
             JSAnalysis_NetInfoKey_WiFiIP:wifiIP ?: @"NONE"};
    
}

/**
 获取当前网口的总流量
 
 #include <ifaddrs.h>
 #include <net/if.h>
 */
+ (long long int)getInterfaceBytes {
    
    struct ifaddrs *ifa_list =0, *ifa;
    if(getifaddrs(&ifa_list) == -1) return 0;
    
    uint32_t iBytes =0;//下行
    uint32_t oBytes =0;//上行
    
    for(ifa = ifa_list; ifa; ifa = ifa->ifa_next) {
        
        if(AF_LINK!= ifa->ifa_addr->sa_family)
            continue;
        
        if(!(ifa->ifa_flags&IFF_UP) && !(ifa->ifa_flags&IFF_RUNNING))
            continue;
        
        if(ifa->ifa_data==0)
            continue;
        
        if(strncmp(ifa->ifa_name,"lo",2)) {
            struct if_data*if_data = (struct if_data*)ifa->ifa_data;
            iBytes += if_data->ifi_ibytes;
            oBytes += if_data->ifi_obytes;
        }
    }
    
    freeifaddrs(ifa_list);
    freeifaddrs(ifa);
    //返回下行的总流量
    return iBytes;
}

//网速格式化方法
+ (NSString*)formatNetWorkBytes:(long long int)rate {
    
    if(rate < 1024) {
        return [NSString stringWithFormat:@"%lldB/秒", rate];
        
    } else if(rate >= 1024 && rate < 1024*1024) {
        return [NSString stringWithFormat:@"%.1fKB/秒", (double)rate /1024];
        
    } else if(rate >= 1024*1024 && rate < 1024*1024*1024){
        return [NSString stringWithFormat:@"%.2fMB/秒", (double)rate / (1024*1024)];
        
    } else if(rate >= 1024*1024*1024){
        return [NSString stringWithFormat:@"%.2fGB/秒", (double)rate / (1024*1024*1024)];
        
    } else {
        return @"0dB/秒";
    }
}

+ (NSString *)getBluetoothName {
    return [[UIDevice currentDevice] name];
}

/**
 获取本机DNS服务器
 需要引入libresolv.tbd
 引用头文件
 #include <arpa/inet.h>
 #include <ifaddrs.h>
 #include <resolv.h>
 #include <dns.h>
 */
+ (NSString *)getDNSServers {
    res_state res = malloc(sizeof(struct __res_state));
    
    int result = res_ninit(res);
    NSMutableArray *dnsArray = @[].mutableCopy;
    if (result == 0) {
        for ( int i = 0; i < res->nscount; i++ ) {
            NSString *s = [NSString stringWithUTF8String :  inet_ntoa(res->nsaddr_list[i].sin_addr)];
            [dnsArray addObject:s];
        }
    } else {
        NSLog(@"%@",@" res_init result != 0");
    }
    
    res_nclose(res);
    NSMutableString *dnsStr = [[NSMutableString alloc] init];
    [dnsArray enumerateObjectsUsingBlock:^(NSString *  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [dnsStr appendString:obj];
        if (idx != dnsArray.count-1) {
            [dnsStr appendString:@","];
        }
    }];
    return dnsStr;
}

+ (nullable NSString *)getWiFiMacAddress {
    res_9_init();
    int len;
    //get currnet wifi ip address
    NSDictionary *ipDic = [JSAnalysis getIPAddress];
    NSString *ip = [ipDic objectForKey:JSAnalysis_NetInfoKey_WiFiIP];
    if(ip == nil || [ip isEqualToString:@"NONE"]) {
        fprintf(stderr, "could not get current IP address of en0\n");
        return JSAnalysis_Default_MAC;
    }//end if
    
    //set port and destination
    _res.nsaddr_list[0].sin_family = AF_INET;
    _res.nsaddr_list[0].sin_port = htons(5353);
    _res.nsaddr_list[0].sin_addr.s_addr = [self IPv4Pton:ip];
    _res.nscount = 1;
    
    unsigned char response[NS_PACKETSZ];
    
    //send mdns query
    if((len = res_9_query(JSAnalysis_mDNS_Group_Name, ns_c_in, ns_t_ptr, response, sizeof(response))) < 0) {
        
        fprintf(stderr, "res_search(): %s\n", hstrerror(h_errno));
        return JSAnalysis_Default_MAC;
    }//end if
    
    //parse mdns message
    ns_msg handle;
    if(ns_initparse(response, len, &handle) < 0) {
        fprintf(stderr, "ns_initparse(): %s\n", hstrerror(h_errno));
        return JSAnalysis_Default_MAC;
    }//end if
    
    //get answer length
    len = ns_msg_count(handle, ns_s_an);
    if(len < 0) {
        fprintf(stderr, "ns_msg_count return zero\n");
        return JSAnalysis_Default_MAC;
    }//end if
    
    //try to get mac address from data
    NSString *macAddress = nil;
    for(int i = 0 ; i < len ; i++) {
        ns_rr rr;
        ns_parserr(&handle, ns_s_an, 0, &rr);
        
        if(ns_rr_class(rr) == ns_c_in &&
           ns_rr_type(rr) == ns_t_ptr &&
           !strcmp(ns_rr_name(rr), JSAnalysis_mDNS_Group_Name)) {
            char *ptr = (char *)(ns_rr_rdata(rr) + 1);
            int l = (int)strcspn(ptr, "@");
            
            char *tmp = calloc(l + 1, sizeof(char));
            if(!tmp) {
                perror("calloc()");
                continue;
            }//end if
            memcpy(tmp, ptr, l);
            macAddress = [NSString stringWithUTF8String:tmp];
            free(tmp);
        }//end if
    }//end for each
    macAddress = macAddress ? macAddress : JSAnalysis_Default_MAC;
    return macAddress;
}//end getMacAddressFromMDNS

+ (in_addr_t)IPv4Pton: (nonnull NSString *)IPAddr {
    in_addr_t network = INADDR_NONE;
    return inet_pton(AF_INET, [IPAddr UTF8String], &network) == 1 ?
    network : INADDR_NONE;
}//end IPv4Pton:

@end
