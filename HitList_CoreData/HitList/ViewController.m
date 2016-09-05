//
//  ViewController.m
//  HitList
//
//  Created by Hanying Zhang on 15/5/30.
//  Copyright (c) 2015年 myself. All rights reserved.
//

#import "ViewController.h"
#import <CoreData/CoreData.h>
#import "AppDelegate.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end

@implementation ViewController {
    NSMutableArray *people;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"The List";
    //下面这个方法以前没有用过
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    people = [NSMutableArray array];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    AppDelegate *delegate  =[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = [delegate managedObjectContext];
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Person"];
    NSError *error;
    NSArray *results = [context executeFetchRequest:request error:&error];
    if (results) {
        for (NSManagedObject *result in results) {
            [people addObject:result];
        }
    }else{
        NSLog(@"could not fetch, error is %@",error);
    }
}

- (IBAction)addName:(UIBarButtonItem *)sender
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"New Name" message:@"Add a new name" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save"
                                                         style:UIAlertActionStyleDefault
                                                       handler:^(UIAlertAction *action) {
                                                           UITextField *textField = alert.textFields.firstObject;
                                                           [self saveName:textField.text];
                                                           [self.tableView reloadData];
                                                       }];
    UIAlertAction *cancleAction = [UIAlertAction actionWithTitle:@"Cancle"
                                                           style:UIAlertActionStyleCancel
                                                         handler:^(UIAlertAction *action) {
                                                            
                                                         }];
    [alert addTextFieldWithConfigurationHandler:^(UITextField *textField) {
           }];
    
    [alert addAction:saveAction];
    [alert addAction:cancleAction];
    
    [self presentViewController:alert animated:YES completion:^{
                                                    }];
}

- (void)saveName:(NSString*)name {
    AppDelegate *dele = (AppDelegate*)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context= [dele managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:context];
    NSManagedObject *person = [[NSManagedObject alloc]initWithEntity:entity insertIntoManagedObjectContext:context];
    
    [person setValue:name forKey:@"name"];
    
    NSError *error;
    if (![context save:&error]){
        NSLog(@"could not save, error is : %@",error);
    }
    
    [people addObject:person];
}

#pragma mark - TableView DataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return people.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    NSManagedObject *person = (NSManagedObject*)people[indexPath.row];
    cell.textLabel.text = [person valueForKey:@"name"];
    
    return cell;
}

@end
