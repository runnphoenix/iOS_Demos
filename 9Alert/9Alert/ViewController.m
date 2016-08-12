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
#import <MapKit/MapKit.h>

@interface ViewController () <CLLocationManagerDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation ViewController {
    LocationManager *_locationManager;
    NSMutableArray *_annotations;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"%@",[SSID sharedSSID].SSID);
    
    _locationManager = [[LocationManager alloc]init];
    _locationManager.delegate = self;
    [_locationManager startUpdatingLocation];
    
    _annotations = [NSMutableArray array];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations {
    NSLog(@"XXXXXXX");
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc]init];
    annotation.coordinate = [locations lastObject].coordinate;
    [_annotations addObject:annotation];
    
    if (_annotations.count > 100) {
        MKPointAnnotation *toRemoveAnnotation = [_annotations firstObject];
        [_annotations removeObjectAtIndex:0];
        [self.mapView removeAnnotation:toRemoveAnnotation];
    }
    
    if ([UIApplication sharedApplication].applicationState == UIApplicationStateActive) {
        [self.mapView showAnnotations:_annotations animated:YES];
        NSLog(@"Active: %@",[locations lastObject]);
    }else {
        NSLog(@"Inactive: %@",[locations lastObject]);
    }
}

@end
