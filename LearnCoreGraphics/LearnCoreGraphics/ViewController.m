//
//  ViewController.m
//  LearnCoreGraphics
//
//  Created by Hanying Zhang on 15/5/28.
//  Copyright (c) 2015年 myself. All rights reserved.
//

#import "ViewController.h"
#import "CustomView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet CustomView *contentView;
@end

@implementation ViewController
{
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)viewDidAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
