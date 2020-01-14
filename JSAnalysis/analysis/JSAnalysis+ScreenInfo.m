//
//  JSAnalysis+ScreenInfo.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/1/21.
//  Copyright © 2019 JSredit. All rights reserved.
//

#import "JSAnalysis+ScreenInfo.h"

@implementation JSAnalysis (ScreenInfo)

+ (CGFloat)getScreenHeight {
    return [UIScreen mainScreen].bounds.size.height;
}

+ (CGFloat)getScreenWidth {
    return [UIScreen mainScreen].bounds.size.width;
}

+ (CGFloat)getScreenDensity {
    return [UIScreen mainScreen].scale;
}

+ (CGFloat)getScreenBrigtness {
    return [UIScreen mainScreen].brightness;
}
@end
