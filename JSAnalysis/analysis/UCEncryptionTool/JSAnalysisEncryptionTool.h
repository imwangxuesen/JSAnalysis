//
//  JSAnalysisEncryptionTool.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2017/9/16.
//  Copyright © 2017年 Xuesen Wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NSData+JSAnalysis.h"
#import "NSString+JSAnalysis.h"

NS_ASSUME_NONNULL_BEGIN
@interface JSAnalysisEncryptionTool : NSObject

/**
 对字典参数进行签名
 
 @param dic 被签名字典
 @param key key
 @return sign
 */
+ (NSString *)encryptionToolSignDic:(NSDictionary *)dic key:(NSString *)key;

/**
 对数组参数进行签名（h5）
 
 @param arr 被签名数组参数
 @param key key
 @return sign
 */

+ (NSString *)encryptionToolSignArray:(NSArray *)arr key:(NSString *)key;

/**
 获取签名后的参数字典
 
 @param dic 本身参数
 @return 签名后的字典
 */
+ (NSDictionary *)encryptionToolGetResultDic:(NSDictionary *)dic;

/**
 获取签名
 
 @param dic 本身参数
 @return 签名
 */
+ (NSString *)encryptionToolGetSignWithDic:(NSDictionary *)dic;

/**
 获取签名
 
 @param array 本身参数
 @return 签名
 */
+ (NSString *)encryptionToolGetSignWithArray:(NSArray *)array;

/**
 解析web端参数

 @param str web端传过来的参数
 @return 解析后的string
 */
+ (NSString *)URLDecodedString:(NSString *)str;

/**
 AES256加密敏感字符串

 @param content 需要加密的内容
 @return 加密后的base64字符串
 */
+ (NSString *)encryptionToolAES256ForString:(NSString *)content;

/**
 AES256加密敏感字典

 @param content 需要加密的内容
 @return 加密后的base64字符串
 */
+ (NSString *)encryptionToolAES256ForDictionary:(NSDictionary *)content;

/**
 解密 被加密的base64字符串

 @param base64Content 需要解密的base64json字符串
 @return 解密后的字典
 */
//+ (NSDictionary *)decryptionAES256:(NSString *)base64Content;

/**
 AES256 key

 @return key
 */
+ (NSString *)AES256key;

/**
 获取加密和签名规则后的参数字典

 @param dic 需要加密和签名
 @return eg:@{
                @"box":@"skjflkasjdlfkjasld;kjflkasjdflkjsdxxxx",
                @"timestamp":@"1231231231",
                @"sign":@"sdlkjflksajdflkjsflksdjfdddfk="
            }
 */
+ (NSDictionary *)us_analysisEncryptWithDic:(NSDictionary *)dic;

@end
NS_ASSUME_NONNULL_END

