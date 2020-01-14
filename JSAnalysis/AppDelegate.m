//
//  AppDelegate.m
//  JSAnalysis
//
//  Created by WangXuesen on 2020/1/13.
//  Copyright © 2020 Jsoon. All rights reserved.
//

#import "AppDelegate.h"
#import "analysis/JSAnalysis.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [JSAnalysis standardAnalysis].appKey = @"d366a1f6590e4f4fa660375c4e5fba7f";
    [JSAnalysis standardAnalysis].debug = YES;
    NSLog(@"start");
    [[JSAnalysis standardAnalysis] getAnalysisBoxWithOption:JSAnalysisGetAnalysisBoxOptionIntelligentAuto responseBlock:^(NSDictionary * _Nonnull analysisBox) {
        NSLog(@"%@",analysisBox);
    }];
    
    [[JSAnalysis standardAnalysis]]
    return YES;
}


#pragma mark - UISceneSession lifecycle


- (UISceneConfiguration *)application:(UIApplication *)application configurationForConnectingSceneSession:(UISceneSession *)connectingSceneSession options:(UISceneConnectionOptions *)options {
    // Called when a new scene session is being created.
    // Use this method to select a configuration to create the new scene with.
    return [[UISceneConfiguration alloc] initWithName:@"Default Configuration" sessionRole:connectingSceneSession.role];
}


- (void)application:(UIApplication *)application didDiscardSceneSessions:(NSSet<UISceneSession *> *)sceneSessions {
    // Called when the user discards a scene session.
    // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
    // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
}


@end
