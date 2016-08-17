//
//  SwizzlingObject.m
//  RuntimeDemo
//
//  Created by workMac on 16/8/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "SwizzlingObject.h"
#import <objc/runtime.h>

@implementation SwizzlingObject

- (instancetype)init {
    if (self = [super init]) {
        Method didAppear = class_getInstanceMethod([self class], @selector(print1));
        Method willAppear = class_getInstanceMethod([self class], @selector(print2));
        
        method_exchangeImplementations(didAppear, willAppear);
    }
    return self;
}

- (void)print1 {
    NSLog(@"1 - %@", NSStringFromSelector(_cmd));
}

- (void)print2 {
    NSLog(@"2 - %@", NSStringFromSelector(_cmd));
}

@end
