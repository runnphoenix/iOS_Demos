//
//  ViewController.m
//  RuntimeDemo
//
//  Created by workMac on 16/8/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "NSString+AssociateObject.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Test AssociatedObject
    NSString *st = @"xx";
    st.stringNumber = @(3);
    NSLog(@"%@",st.stringNumber);
}

@end
