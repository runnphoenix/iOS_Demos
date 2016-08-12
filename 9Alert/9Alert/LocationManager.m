//
//  LocationManager.m
//  9Alert
//
//  Created by workMac on 16/8/12.
//  Copyright © 2016年 self. All rights reserved.
//

#import "LocationManager.h"

@implementation LocationManager

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.desiredAccuracy = kCLLocationAccuracyBest;
        [self requestAlwaysAuthorization];
    }
    return self;
}

@end
