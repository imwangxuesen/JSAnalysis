//
//  JSAnalysisGPSLocationTool.h
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/2/13.
//  Copyright © 2019 WangXuesen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^JSAnalysisGPSResponseBlock)(CLLocation *location, NSError *error);

@interface JSAnalysisGPSLocationTool : NSObject<CLLocationManagerDelegate> {
    CLLocationManager   *_locationManager;
}

@property (nonatomic, assign) CLLocationDegrees currentLongitude;    //经度
@property (nonatomic, assign) CLLocationDegrees currentLatitude;     //纬度
// 地理位置回调block
@property (nonatomic, copy) JSAnalysisGPSResponseBlock responseBlock;

+ (id)defaultLocationManager;  //默认地理位置管理者
- (void)fetchLocationInfo;


@end

