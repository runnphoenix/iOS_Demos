//
//  ViewController.h
//  BackgroundFetchDemo
//
//  Created by Gabriel Theodoropoulos on 22/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblNews;
- (IBAction)removeDataFile:(UIBarButtonItem *)sender;
- (void)fetchNewDataWithCompletionHandler:(void(^)(UIBackgroundFetchResult))completionHandler;
@end
