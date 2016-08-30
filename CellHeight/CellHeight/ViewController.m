//
//  ViewController.m
//  CellHeight
//
//  Created by workMac on 16/8/30.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"

@interface ViewController  ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController {
    NSArray *_contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contents = @[@"12345", @"12345678901234567890123456789012345678901234567890", @"12345", @"12345678901234567890123456789012345678901234567890", @"12345678901234567890123456789012345678901234567890", @"12345", @"12345678901234567890123456789012345678901234567890", @"12345", @"12345678901234567890123456789012345678901234567890", @"12345", @"12345678901234567890123456789012345678901234567890", @"12345678901234567890123456789012345678901234567890", @"12345", @"12345678901234567890123456789012345678901234567890"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [_contents[indexPath.row] sizeWithAttributes:nil].height;
    ;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    cell.textLabel.text = _contents[indexPath.row];
    cell.textLabel.numberOfLines = MAXFLOAT;
    
    return cell;
}

@end
