//
//  ViewController.m
//  9Alert
//
//  Created by workMac on 16/8/15.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "SSID.h"
#import "LocationManager.h"
#import <MapKit/MapKit.h>

@interface ViewController () <CLLocationManagerDelegate, UIPickerViewDelegate, UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UILabel *currentSSIDLabel;
@property (weak, nonatomic) IBOutlet UILabel *referenceSSIDLabel;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UIPickerView *timePicker;
@end

@implementation ViewController {
    LocationManager *_locationManager;  // 位置管理
    NSMutableArray *_annotations;       // 位置标记
    
    NSDate *_StartDate;            // 工作开始时间
    NSDate *_EndDate;              // 工作结束时间
    
    BOOL _duringWork;   // 是否处在工作状态下
    NSArray *_workHours;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _locationManager = [[LocationManager alloc]init];
    _locationManager.delegate = self;
    _locationManager.allowsBackgroundLocationUpdates = YES; // 没有这句代码，不会在后台运行
    [_locationManager startUpdatingLocation];
    
    _annotations = [NSMutableArray array];
    
    _duringWork = NO;
    
    self.timePicker.dataSource = self;
    self.timePicker.delegate = self;
    
    _workHours = @[@"7", @"8", @"9", @"10", @"11"];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self refreshWiFiLabels];
    [self setPickerViewDisplay];
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
        _duringWork = YES;
        
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        unsigned workLength = [[[NSUserDefaults standardUserDefaults]valueForKey:@"WorkLength"] intValue];
        notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:workLength * 3600];
        notification.timeZone = [NSTimeZone defaultTimeZone];
        notification.alertTitle = @"下班了，下班了";
        notification.alertBody = @"美好的夜生活开始了";
        notification.soundName = UILocalNotificationDefaultSoundName;
        [[UIApplication sharedApplication] scheduleLocalNotification:notification];
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
        //TODO: 给出未连接WiFi的警告
    }
}

#pragma mark - Picker
#pragma mark DataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _workHours.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _workHours[row];
}

#pragma mark Delegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    [[NSUserDefaults standardUserDefaults] setValue:_workHours[row] forKey:@"WorkLength"];
}

#pragma mark - Set PickerView Display
- (void)setPickerViewDisplay {
    unsigned workLength = [[[NSUserDefaults standardUserDefaults]valueForKey:@"WorkLength"]intValue];
    unsigned row = workLength - [_workHours[0]intValue];
    [self.timePicker selectRow:row inComponent:0 animated:YES];
}

@end

