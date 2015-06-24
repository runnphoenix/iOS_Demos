//
//  ViewController.m
//  BackgroundFetchDemo
//
//  Created by Gabriel Theodoropoulos on 22/2/14.
//  Copyright (c) 2014 Appcoda. All rights reserved.
//

#import "ViewController.h"
#import "XMLParser.h"
#define NewsFeed @"http://feeds.reuters.com/reuters/technologyNews"

@interface ViewController ()
@property (nonatomic,strong) UIRefreshControl *refreshControl;
@property (nonatomic,strong) NSArray *arrNewsData;
@property (nonatomic,strong) NSString *dataFilePath;
-(void)refreshData;
-(void)performNewFetchedDataActionsWithDataArray:(NSArray *)dataArray;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tblNews.delegate = self;
    self.tblNews.dataSource = self;
    
    NSString *directory = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)firstObject];
    self.dataFilePath = [directory stringByAppendingPathComponent:@"newsData"];
    
    self.refreshControl = [[UIRefreshControl alloc]init];
    [self.refreshControl addTarget:self
                            action:@selector(refreshData)
                  forControlEvents:UIControlEventValueChanged];
    [self.tblNews addSubview:self.refreshControl];
    [self refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshData
{
    XMLParser *xmlParser = [[XMLParser alloc]initWithXMLURLString:NewsFeed];
    [xmlParser startParsingWithCompletionHandler:^(BOOL success, NSArray *dataArray, NSError *error) {
        if (success) {
            [self performNewFetchedDataActionsWithDataArray:dataArray];
            [self.refreshControl endRefreshing];
        }else{
            NSLog(@"%@",[error localizedDescription]);
        }
    }];
}

- (void)performNewFetchedDataActionsWithDataArray:(NSArray *)dataArray
{
    if (self.arrNewsData) {
        self.arrNewsData = nil;
    }
    self.arrNewsData = [NSArray arrayWithArray:dataArray];
    
    [self.tblNews reloadData];
    
    if (![self.arrNewsData writeToFile:self.dataFilePath atomically:YES]) {
        NSLog(@"Fail to write file");
    }
}

- (void)fetchNewDataWithCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler
{
    XMLParser *parser = [[XMLParser alloc]initWithXMLURLString:NewsFeed];
    [parser startParsingWithCompletionHandler:^(BOOL success, NSArray *dataArray, NSError *error) {
        if (success) {
            NSDictionary *latestResult = [dataArray objectAtIndex:0];
            NSString *latestTitle = [latestResult objectForKey:@"title"];
            NSDictionary *result = [self.arrNewsData firstObject];
            NSString *title = [result objectForKey:@"title"];
            if ([latestTitle isEqualToString:title]) {
                completionHandler(UIBackgroundFetchResultNoData);
                NSLog(@"No new data found");
            }else{
                [self performNewFetchedDataActionsWithDataArray:dataArray];
                completionHandler(UIBackgroundFetchResultNewData);
            }
        }else{
            completionHandler(UIBackgroundFetchResultFailed);
            NSLog(@"Fail to load Data");
        }
    }];
}

- (IBAction)removeDataFile:(UIBarButtonItem *)sender
{
    if ([[NSFileManager defaultManager]fileExistsAtPath:self.dataFilePath]){
        [[NSFileManager defaultManager]removeItemAtPath:self.dataFilePath error:nil];
        
        self.arrNewsData = nil;
        [self.tblNews reloadData];
    }
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrNewsData.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"idCellNewsTitle"];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"idCellNewsTitle"];
    }
    
    NSDictionary *dic = [self.arrNewsData objectAtIndex:indexPath.row];
    cell.textLabel.text = [dic objectForKey:@"title"];
    cell.detailTextLabel.text = [dic objectForKey:@"pubData"];
    
    return cell;
}


@end