//
//  SSID.h
//  9Alert
//
//  Created by workMac on 16/8/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SSID : NSObject
@property (nonatomic, copy, readonly) NSString *ssid;
+ (instancetype)sharedSSID;
@end
