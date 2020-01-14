//
//  GAEncryptionTool.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2017/9/16.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import "JSAnalysisEncryptionTool.h"
#import "NSData+JSAnalysis.h"
#import "NSString+JSAnalysis.h"
#import "NSData+JSCommonCrypto.h"
#import "JSAnalysis.h"

// AES256私钥
static const char JSEncryptionToolAES256Key[]  = "xxxxxxxxxxxxxxxx";

@implementation JSAnalysisEncryptionTool


+ (NSString *)encryptionToolSignDic:(NSDictionary *)dic key:(NSString *)key {
    NSArray *keys = dic.allKeys;
    NSArray *keysResult = [keys sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        return [obj1 compare:obj2];
    }];
    
    NSMutableString *result = [[NSMutableString alloc] init];
    for (int i = 0 ; i<keysResult.count; i++) {
        NSString *key = keysResult[i];
        NSString *value = [dic objectForKey:key];
        NSString *cp = [NSString stringWithFormat:@"%@=%@",key,value];
        if (i == 0) {
            [result appendString:cp];
        }else {
            [result appendFormat:@"&%@",cp];
        }
    }
    
    if (result.length == 0) {
        return @"";
    }
    
    NSString *optionStr = [result stringByAppendingString:key];
    NSString *md5Str = [optionStr js_md5Str];

    return md5Str;
}

+ (NSString *)encryptionToolSignArray:(NSArray *)arr key:(NSString *)key {
    NSMutableDictionary *keyValueMap = [[NSMutableDictionary alloc] init];
    for (NSDictionary *dic in arr) {
        [keyValueMap setObject:dic[@"value"] forKey:dic[@"name"]];
    }
    return [JSAnalysisEncryptionTool encryptionToolSignDic:keyValueMap key:key];
}


+ (NSString *)encryptionToolGetSignWithDic:(NSDictionary *)dic {
    return [JSAnalysisEncryptionTool encryptionToolSignDic:dic key:[JSAnalysis standardAnalysis].appKey ?: @""];
}

+ (NSString *)encryptionToolGetSignWithArray:(NSArray *)array {
    return [JSAnalysisEncryptionTool encryptionToolSignArray:array key:[JSAnalysis standardAnalysis].appKey ?: @""];
}

+ (NSDictionary *)encryptionToolGetResultDic:(NSDictionary *)dic {
    
    NSString *encryption = [JSAnalysisEncryptionTool encryptionToolSignDic:dic key:[JSAnalysis standardAnalysis].appKey ?: @""];
    NSMutableDictionary *tmpParam = [[NSMutableDictionary alloc] initWithDictionary:dic];
    [tmpParam setObject:encryption forKey:@"sign"];
    return tmpParam;
}

+ (NSString *)URLDecodedString:(NSString *)str {
    NSString *decodedString = (__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapes(NULL, (__bridge CFStringRef)str, CFSTR(""));
    return decodedString;
}

+ (NSString *)encryptionToolAES256ForString:(NSString *)content {
    
    NSString *key = [JSAnalysisEncryptionTool AES256key];
    NSData *strData = [content dataUsingEncoding:NSUTF8StringEncoding];
    CCCryptorStatus status = kCCSuccess;
    
    NSData * result = [strData dataEncryptedUsingAlgorithm:kCCAlgorithmAES128 key:key initializationVector:nil options:(kCCOptionPKCS7Padding|kCCOptionECBMode) error:&status];
    NSString *base64String = [result base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithLineFeed];
    
    return base64String;
    
}

+ (NSString *)encryptionToolAES256ForDictionary:(NSDictionary *)content {
    
    if (!content) return nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:content options:0 error:NULL];
    if (jsonData.length == 0) return nil;
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    return [JSAnalysisEncryptionTool encryptionToolAES256ForString:jsonString];
}

+ (NSString *)AES256key {
    return [NSString stringWithUTF8String:JSEncryptionToolAES256Key];
}

+ (NSDictionary *)us_analysisEncryptWithDic:(NSDictionary *)dic {
    //敏感数据加密s
    NSString *paramEncryptString = [JSAnalysisEncryptionTool encryptionToolAES256ForDictionary:dic];
    
    //最终参数
    NSMutableDictionary *resultParam = [[NSMutableDictionary alloc] init];
    [resultParam setObject:dic[@"appInfo"][@"appBundle"]?:@"NONE" forKey:@"appBundle"];
    [resultParam setObject:dic[@"appInfo"][@"sdkVersion"] forKey:@"sdkVersion"];
    [resultParam setObject:dic[@"clientInfo"][@"IDFA"] forKey:@"clientId"];
    [resultParam setObject:dic[@"appInfo"][@"userId"] forKey:@"userId"];

    //敏感数据
    [resultParam setObject:paramEncryptString?:@"" forKey:@"jsBox"];
    
    //时间戳
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a = [dat timeIntervalSince1970] * 1000;  //  *1000 是精确到毫秒，不乘就是精确到秒
    NSString *timeString = [NSString stringWithFormat:@"%.0f", a];
    [resultParam setObject:timeString forKey:@"timestamp"];
    
    //签名
    NSString *signKey = [JSAnalysis standardAnalysis].appKey;
    if (signKey) {
        
        NSString *sign = [JSAnalysisEncryptionTool encryptionToolGetSignWithDic:resultParam];
        [resultParam setObject:sign forKey:@"sign"];
    }
    
    paramEncryptString = [paramEncryptString urlEncode];
    [resultParam setObject:paramEncryptString?:@"" forKey:@"jsBox"];

    
    return resultParam;
}


@end
