//
//  JSAnalysisGPSLocationTool.m
//  AnalysisDemo
//
//  Created by WangXuesen on 2019/2/13.
//  Copyright © 2019 WangXuesen. All rights reserved.
//

#import "JSAnalysisGPSLocationTool.h"

@implementation JSAnalysisGPSLocationTool

+ (id)defaultLocationManager{
    static JSAnalysisGPSLocationTool *locationManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        locationManager = [[JSAnalysisGPSLocationTool alloc] init];
    });
    return locationManager;
}

//初始化:
- (instancetype)init {
    if (self = [super init]) {
        _locationManager = [[CLLocationManager alloc] init];
        _locationManager.delegate = self;
        _locationManager.distanceFilter = kCLLocationAccuracyNearestTenMeters;

    }
    return self;
}

- (void)fetchLocationInfo{
    if ([CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedAlways || [CLLocationManager authorizationStatus] == kCLAuthorizationStatusAuthorizedWhenInUse) {
        
        [_locationManager startUpdatingLocation];

    } else {
        
        if (_responseBlock) {
            NSError *error = [[NSError alloc] initWithDomain:NSNetServicesErrorDomain code:1001 userInfo:@{@"res":@"not_authorize"}];
            _responseBlock(nil,error);
        }
        
    }
    
}

- (void)stopFetchingLocationInfo{
    [_locationManager stopUpdatingLocation];
    
}

- (void)updateCacheWithLocation:(CLLocation *)location {
    if (location) {
        self.currentLatitude = [location coordinate].latitude;
        self.currentLongitude = [location coordinate].longitude;
        
        if (_responseBlock) {
            _responseBlock(location,nil);
        }
        
    }
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    [self stopFetchingLocationInfo];
    [self updateCacheWithLocation:locations.count > 0 ? locations[0] : nil];
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error{
    if (_responseBlock) {
        NSMutableDictionary *userInfo = [[NSMutableDictionary alloc] init];
        for (NSString *key in error.userInfo.allKeys) {
            id value = error.userInfo[key];
            if (value) {
                [userInfo setObject:value forKey:key];
            }
        }
        NSError *error = [[NSError alloc] initWithDomain:NSNetServicesErrorDomain code:1001 userInfo:@{@"res":userInfo ?: @"get location error"}];
        _responseBlock(nil,error);
    }
}
@end
