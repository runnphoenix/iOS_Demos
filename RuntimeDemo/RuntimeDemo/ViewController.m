//
//  ViewController.m
//  RuntimeDemo
//
//  Created by workMac on 16/8/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AssociateObject.h"
#import "SwizzlingObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test AssociatedObject
    NSString *st = @"xx";
    st.stringNumber = @(3);
    NSLog(@"%@",st.stringNumber);
    
    // Method Swizzling
    SwizzlingObject *obj = [[SwizzlingObject alloc]init];
    [obj print1];
    [obj print2];
}

@end
