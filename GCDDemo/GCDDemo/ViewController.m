//
//  ViewController.m
//  GCDDemo
//
//  Created by workMac on 16/8/20.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // dispatch_async
    //[self testDispatchSync];
    
    // dispatch_barrier_async
    //[self testDispatchAsync];
    
    // dispatch_Semaphore_signal
    [self testDispatchSemaphoreSignal];
}

- (void)viewWillAppear:(BOOL)animated {
    // dispatch_apply
    //[self testDispatchApply];
    
    // dispatch_barrier_async
    //[self testDispatchBarrierAsync];
}

- (void)testDispatchSync {
    dispatch_sync(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        [NSThread sleepForTimeInterval:1];
        NSLog(@"xx");
    });
    NSLog(@"xxxxx");
}

- (void)testDispatchAsync {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void) {
        NSLog(@"aa");
    });
    NSLog(@"aaaaa");
}

- (void)testDispatchApply {
    dispatch_apply(5, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(size_t i) {
        NSLog(@"%zu",i);
    });
}

- (void)testDispatchBarrierAsync {
    dispatch_queue_t conQue = dispatch_queue_create("self.edu.testQueue", DISPATCH_QUEUE_CONCURRENT);
    __block NSString *string = @"Original String";
    dispatch_async(conQue, ^(void) {
        NSLog(@"%@ 1", string);
        [NSThread sleepForTimeInterval:1];
        NSLog(@"%@ 2", string);
    });
    dispatch_barrier_async(conQue, ^(void) {
        string = @"Changed String";
        NSLog(@"%@", string);
    });
    dispatch_async(conQue, ^(void) {
        NSLog(@"%@", string);
    });
}

- (void)testDispatchSemaphoreSignal {
    dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
    dispatch_queue_t conQue = dispatch_queue_create("self.edu.conque", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_async(conQue, ^{
        [NSThread sleepForTimeInterval:2];
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"1");
        dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(conQue, ^{
        dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
        NSLog(@"2");
        //dispatch_semaphore_signal(semaphore);
    });
    
    dispatch_async(conQue, ^{
        dispatch_semaphore_wait(semaphore, dispatch_time(DISPATCH_TIME_NOW, 1000*USEC_PER_SEC));
        NSLog(@"3");
        dispatch_semaphore_signal(semaphore);
    });
}

@end
