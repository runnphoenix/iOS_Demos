//
//  ViewController.m
//  Invocation
//
//  Created by workMac on 16/8/17.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Init
    NSMethodSignature *signature = [ViewController instanceMethodSignatureForSelector:@selector(sendMessageWithNumber:title:content:)];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:signature];
    // Target & Selector
    invocation.target = self;
    invocation.selector = @selector(sendMessageWithNumber:title:content:);
    // Arguments
    NSString *number = @"13812345678";
    [invocation setArgument: &number atIndex:2];
    NSString *title = @"Hello";
    [invocation setArgument:&title atIndex:3];
    NSString *content = @"Content";
    [invocation setArgument: &content atIndex:4];
    // Invoke
    [invocation invoke];
}

- (void)sendMessageWithNumber:(NSString*)number title:(NSString*)title content:(NSString*)content {
    NSLog(@"电话: %@, 主题：%@, 内容: %@", number, title, content);
}

- (void)compare {
    /*
    [self performSelector:<#(SEL)#>];
    [self performSelector:<#(SEL)#> withObject:<#(id)#>];
    [self performSelector:<#(SEL)#> withObject:<#(id)#> withObject:<#(id)#>];
    [self performSelector:<#(nonnull SEL)#> withObject:<#(nullable id)#> afterDelay:<#(NSTimeInterval)#>];
    [self performSegueWithIdentifier:<#(nonnull NSString *)#> sender:<#(nullable id)#>];
    [self performSelectorOnMainThread:<#(nonnull SEL)#> withObject:<#(nullable id)#> waitUntilDone:<#(BOOL)#>];
    [self performSelectorInBackground:<#(nonnull SEL)#> withObject:<#(nullable id)#>];
     */
}

@end
