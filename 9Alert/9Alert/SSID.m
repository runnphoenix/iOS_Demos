//
//  SSID.m
//  9Alert
//
//  Created by workMac on 16/8/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import "SSID.h"
#import <SystemConfiguration/CaptiveNetwork.h>

@implementation SSID

+ (instancetype)sharedSSID {
    static SSID *ssid = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        ssid = [[SSID alloc]init];
    });
    
    return ssid;
}

- (NSString *)ssid {
    return [[self class] getWifiName];
}

+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

@end
