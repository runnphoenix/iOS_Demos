//
//  ViewController.m
//  9Alert
//
//  Created by workMac on 16/8/3.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "SSID.h"
#import "LocationManager.h"
#import <UserNotifications/UserNotifications.h>
#import <MapKit/MapKit.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *currentSSIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *referenceSSIDLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController {
    LocationManager *_locationManager;
    NSMutableArray *_annotations;
    unsigned _maxWorkHours;
    
    NSDate *_dailyStartDate;
    NSDate *_dailyEndDate;
    
    BOOL _duringWork;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[LocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.allowsBackgroundLocationUpdates = YES; // 没有这句代码，不会在后台运行
    [_locationManager startUpdatingLocation];
    
    _annotations = [NSMutableArray array];
    
    _duringWork = NO;
    [[UNUserNotificationCenter currentNotificationCenter] requestAuthorizationWithOptions:UNAuthorizationOptionNone
                                                                        completionHandler:^(BOOL granted, NSError * _Nullable error) {
        
                                                                        }];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshWiFiLabels];
}

// 刷新WiFi名称显示
- (void)refreshWiFiLabels {
    self.currentSSIDLabel.text = [SSID sharedSSID].ssid;
    NSString *referenceSSID = [[NSUserDefaults standardUserDefaults] objectForKey:@"referenceSSID"];
    if (!referenceSSID) {
        referenceSSID = @" ";
    }
    self.referenceSSIDLabel.text = referenceSSID;
}

// 获取到地点信息之后到代理方法
- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    // 刷新WiFi名称显示
    [self refreshWiFiLabels];

    // 记录地点信息
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = [locations lastObject].coordinate;
    [_annotations addObject:annotation];
    
    if (_annotations.count > 30) {
        MKPointAnnotation *toRemoveAnnotation = [_annotations firstObject];
        [_annotations removeObjectAtIndex:0];
        [self.mapView removeAnnotation:toRemoveAnnotation];
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self.mapView showAnnotations:_annotations animated:YES];
    }
    
    // 处理时间
    BOOL underWorkWiFi = [[SSID sharedSSID].ssid isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"referenceSSID"]];
    if (underWorkWiFi && !_duringWork) { //处在工作地点WiFi下且没有开始计时，则开始计时
        NSLog(@"XXXXXXXXX");
        _duringWork = YES;
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:20 repeats:NO];
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc]init];
        content.title = @"下班了，下班了，现在可以下班了！！";
        content.body = @"美好的夜生活终于开始了！！！！";
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:@"" content:content trigger:trigger];
        [[UNUserNotificationCenter currentNotificationCenter] addNotificationRequest:request
                                                              withCompletionHandler:^(NSError * _Nullable error) {
                                                                  
                                                              }];
    }
}

// 将当前WiFi设置为参考WiFi
- (IBAction)setCurrentWifiAsReference:(id)sender {
    // 如果已取得当前WiFi名称
    if (self.currentSSIDLabel.text) {
        // 设置界面显示
        self.referenceSSIDLabel.text = self.currentSSIDLabel.text;
        // 如果是将新的WiFi作为参考，那么改写已储存的名称信息
        if (![self.currentSSIDLabel.text isEqualToString:[[NSUserDefaults standardUserDefaults] objectForKey:@"referenceSSID"]]) {
            [[NSUserDefaults standardUserDefaults] setObject:self.currentSSIDLabel.text forKey:@"referenceSSID"];
        }
    }else{
        //TODO: 给出未连接WiFi到警告
    }
}

@end
