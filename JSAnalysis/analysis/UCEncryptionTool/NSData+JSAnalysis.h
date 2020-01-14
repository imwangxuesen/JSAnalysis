//
//  NSData+UCAnalysis.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2018/3/2.
//  Copyright © 2018年 Jsoon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

@interface NSData (JSAnalysis)

- (NSData *)AES256EncryptWithKey:(NSString *)keyStr;   //加密
- (NSData *)AES256DecryptWithKey:(NSString *)keyStr;   //解密
- (NSString *)newStringInBase64FromData;            //追加64编码
+ (NSString *)base64encode:(NSString*)str;           //同上64编码
@end
