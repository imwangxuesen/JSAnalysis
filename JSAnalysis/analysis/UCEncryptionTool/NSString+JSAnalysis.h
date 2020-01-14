//
//  NSString+UCAnalysis.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2018/3/2.
//  Copyright © 2018年 Jsoon. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (JSAnalysis)

/**
 aes256 加密然后 加 base64
 

 @param key key
 @return 加密后的结果
 */
- (NSString *)AES256EncryptWithKey:(NSString *)key;


/**
 base64字符串解密 再 aes256解密

 @param key key
 @return 解密后的结果
 */
- (NSString *)AES256DecryptWithKey:(NSString *)key;

/**
 md5加密
 */
- (NSString *)js_md5Str;

/**
 json字符串转对象（NSArray、NSDictionary）

 @param jsonStr 需要被转换的json字符串
 @return 对应对象或者nil
 */
+ (id)js_jsonStrToObject:(NSString *)jsonStr;

/**
 对象转字符串，去掉空格和换行符

 @param jsonObject 需要被转换的对象
 @return json 字符串
 */
+ (NSString *)js_jsonObjectToStr:(id)jsonObject;

- (NSString *)urlEncode;
@end
