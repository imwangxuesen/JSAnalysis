//
//  JSAnalysis.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


#ifndef __OPTIMIZE__
#define JSLog(...) NSLog(__VA_ARGS__)
#else
#define JSLog(...) {}
#endif

/**
 获取AnalysisBox的方式
 
 以下获取方式都会在全局子线程执行
 
 自动失败重传三次,依旧失败则在下一次启动时上传。

 - JSAnalysisGetAnalysisBoxOptionManual: 手动获取,返回box,自行处理。可到指定官网、或调用接口进行解密。
 - JSAnalysisGetAnalysisBoxOptionForceAuto: 暴力自动,获取到box会自动将数据上传到JSAnalysis官网。可根据box查询到解密后的值。
 - JSAnalysisGetAnalysisBoxOptionIntelligentAuto: 智能自动,会在指定电量阈值以上、应用空闲时获取信息、上传信息。但也有可能会因为应用状态始终告警造成获取信息延迟或失败。
 */
typedef NS_ENUM(NSInteger,JSAnalysisGetAnalysisBoxOption) {
    JSAnalysisGetAnalysisBoxOptionManual,
    JSAnalysisGetAnalysisBoxOptionForceAuto,
    JSAnalysisGetAnalysisBoxOptionIntelligentAuto,
};


/**
 获取用户标识block

 @return 用户标识
 */
typedef NSString * _Nonnull (^GetUserIdBlock)(void);

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis : NSObject

/**
 必须设置
 */
@property (nonatomic, copy, nonnull) NSString *appKey;
@property (nonatomic, assign) BOOL debug;

/**
 电量阈值
 
 默认为0.2(20%)
 
 JSAnalysisGetAnalysisBoxOptionIntelligentAuto模式下,
 如果电量低于batteryThreshold值,并且非充电状态下,SDK将停止工作。
 */
@property (nonatomic, assign) CGFloat batteryThreshold;

/**
 box info value的缓存,每次获取重新刷新
 */
@property (nonatomic, copy ,readonly) NSDictionary *cacheBoxInfo;

/**
 获取本应用的用户标识，用”userId“作为key
 */
@property (nonatomic, copy) GetUserIdBlock userIdBlock;

/**
 单例
 初始化
 */
+ (instancetype)standardAnalysis;

/**
 获取UIApplication实例
 */
+ (UIApplication *)sharedApplication;

/**
 获取AnalysisBox
 
 analysisBoxInfo: eg
 @{
    加密后的box信息
    @"box":@"asdkjflkasdjlfkjasldkjflkajsdfljkasd",
    数据签名
    @"sign":@"lsdjfkldsjlkfjsdkljf",
    时间戳
    @"timestamp":12312377678,
 }
 */
- (void)getAnalysisBoxWithOption:(JSAnalysisGetAnalysisBoxOption)option responseBlock:(void(^)(NSDictionary *analysisBoxInfo))block;

@end

NS_ASSUME_NONNULL_END
