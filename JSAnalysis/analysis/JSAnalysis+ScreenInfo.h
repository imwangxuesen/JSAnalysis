//
//  JSAnalysis+ScreenInfo.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis.h"

NS_ASSUME_NONNULL_BEGIN

@interface JSAnalysis (ScreenInfo)

/**
 获取屏幕高度
 */
+ (CGFloat)getScreenHeight;

/**
 获取屏幕宽度
 */
+ (CGFloat)getScreenWidth;

/**
 获取屏幕密度
 */
+ (CGFloat)getScreenDensity;

/**
 获取屏幕亮度

 @return 0.0~1.0 的小数
 */
+ (CGFloat)getScreenBrigtness;

@end

NS_ASSUME_NONNULL_END
