//
//  ViewController.m
//  CellHeight
//
//  Created by workMac on 16/8/30.
//  Copyright © 2016年 self. All rights reserved.
//

#import "ViewController.h"
#import "HeightTableViewCell.h"

@interface ViewController  ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController {
    NSArray *_contents;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _contents = @[@"12345", @"1234567890",
                  @"12345", @"12345678901234567890",
                  @"12345", @"123456789012345678901234567890",
                  @"12345", @"12345678901234567890123456789012345678901234567890"];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.estimatedRowHeight = 24;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _contents.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect rect = [_contents[indexPath.row] boundingRectWithSize:CGSizeMake(100, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:attributes
                                           context:nil];
    NSLog(@"%f",ceil(rect.size.height));
    return ceil(rect.size.height) + 15;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *cellID = @"cellID";
    HeightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"HeightTableViewCell" owner:self options:nil] lastObject];
    }
    cell.heightLabel.text = _contents[indexPath.row];
    cell.heightLabel.numberOfLines = MAXFLOAT;
    
    return cell;
}

@end
