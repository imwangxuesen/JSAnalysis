//
//  NSString+UCAnalysis.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2018/3/2.
//  Copyright © 2018年 Jsoon. All rights reserved.
//

#import "NSString+JSAnalysis.h"
#import "NSData+JSAnalysis.h"

@implementation NSString (JSAnalysis)

- (NSString *)AES256EncryptWithKey:(NSString *)key {
    NSData *secretTextData = [self dataUsingEncoding:NSUTF8StringEncoding];
    NSData *cipherTextData = [secretTextData AES256EncryptWithKey:key];
    NSString *base64 = [cipherTextData base64EncodedStringWithOptions:0];
    return base64;
}

- (NSString *)AES256DecryptWithKey:(NSString *)key {
    NSData *decodedData = [[NSData alloc] initWithBase64EncodedString:self options:0];
    NSData *decipherTextData = [decodedData AES256DecryptWithKey:key];
    NSString *result =[[NSString alloc] initWithData:decipherTextData encoding:NSUTF8StringEncoding];
    return result;
}

- (NSString *)js_md5Str {
    NSData *data = [self dataUsingEncoding:NSUTF8StringEncoding];
    const void *str = [data bytes];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(str, (CC_LONG)data.length, result);
    
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < CC_MD5_DIGEST_LENGTH; i++) {
        
        [hash appendFormat:@"%02X", result[i]];
    }
    
    return [hash lowercaseString];
}

+ (id)js_jsonStrToObject:(NSString *)jsonStr {
    if (!jsonStr) return nil;
    NSData *jsonData = [jsonStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData
                                                    options:NSJSONReadingMutableContainers
                                                      error:nil];
    
    if (jsonObject != nil && error == nil){
        return jsonObject;
    }else{
        return nil;
    }
}

+ (NSString *)js_jsonObjectToStr:(id)jsonObject {
    NSMutableString *jsonString = nil;
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:jsonObject
                                                       options:NSJSONWritingPrettyPrinted // Pass 0 if you don't care about the readability of the generated string
                                                         error:&error];
    if (! jsonData) {
    } else {
        jsonString = [[NSMutableString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    [jsonString replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:NSMakeRange(0, jsonString.length)];
    [jsonString replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:NSMakeRange(0, jsonString.length)];
    
    return jsonString;
}


- (NSString *)urlEncode {
    return [self urlEncodeUsingEncoding:NSUTF8StringEncoding];
}

- (NSString *)urlEncodeUsingEncoding:(NSStringEncoding)encoding {
    return (__bridge_transfer NSString *)CFURLCreateStringByAddingPercentEscapes(NULL,
                                                                                 (__bridge CFStringRef)self,
                                                                                 NULL,
                                                                                 (CFStringRef)@"!*'\"();:@&=+$,/?%#[]% ",
                                                                                 CFStringConvertNSStringEncodingToEncoding(encoding));
}


@end
