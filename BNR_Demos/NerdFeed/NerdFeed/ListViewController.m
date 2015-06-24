//
//  ViewController.m
//  NerdFeed
//
//  Created by workMac on 15/6/22.
//  Copyright (c) 2015年 Gree. All rights reserved.
//

#import "ListViewController.h"
#import "ContentViewController.h"

@interface ListViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self fetchData];
}

- (void)fetchData
{
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://forums.bignerdranch.com/smartfeed.php?limit=1_DAY&sort_by=standard&feed_type=RSS2.0&feed_style=COMPACT"]];
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *task = [session dataTaskWithRequest:request
                                            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                if (data) {
                                                    NSString *string = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
                                                    NSLog(@"Date Fetched:%@",string);
                                                }else{
                                                    NSLog(@"error:%@",[error localizedDescription]);
                                                }
                                            }];
    [task resume];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellID"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellID"];
    }
    
    cell.textLabel.text = @"xxx";
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    ContentViewController *contentVC = [[ContentViewController alloc]init];
    [self.navigationController pushViewController:contentVC animated:YES];
}

@end
