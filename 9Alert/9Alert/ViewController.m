//
//  ViewController.m
//  9Alert
//
//  Created by workMac on 16/8/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "SSID.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[SSID sharedSSID].SSID);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
