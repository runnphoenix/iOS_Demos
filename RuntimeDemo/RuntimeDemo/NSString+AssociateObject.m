//
//  NSObject+AssociateObject.m
//  RuntimeDemo
//
//  Created by workMac on 16/8/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "NSString+AssociateObject.h"
#import <objc/runtime.h>

@implementation NSString (AssociateObject)

- (NSString *)stringNumber {
    return objc_getAssociatedObject(self, @"stringNumber");
}

- (void)setStringNumber:(NSNumber *)stringNumber {
    objc_setAssociatedObject(self, @"stringNumber", stringNumber, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
