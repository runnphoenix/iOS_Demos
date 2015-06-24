//
//  ViewController.m
//  SMSTest
//
//  Created by workMac on 15/6/3.
//  Copyright (c) 2015年 Gree. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *composeRicipentsTF;
@property (weak, nonatomic) IBOutlet UITextField *SMSContentTF;
@property (weak, nonatomic) IBOutlet UITextField *turnRicipentsTF;

@end

@implementation ViewController
{
    MFMessageComposeViewController *controller;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendSMS:(UIButton *)sender
{
    if (self.composeRicipentsTF.text != nil && self.SMSContentTF.text != nil) {
        controller = [[MFMessageComposeViewController alloc]init];
        controller.recipients = @[self.composeRicipentsTF.text];
        controller.body = self.SMSContentTF.text;
        controller.messageComposeDelegate = self;
        
        [self presentViewController:controller animated:YES completion:^{
            nil;
        }];
    }
}

- (IBAction)turnToSystemSMS:(UIButton *)sender
{
    if (self.turnRicipentsTF.text != nil) {
        [[UIApplication sharedApplication]openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms:%@",self.turnRicipentsTF.text]]];
    }
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
        case MessageComposeResultFailed:
        {
            [self showErrorOfSending];
            break;
        }
        case MessageComposeResultSent:
            break;
        default:
            break;
    }
}

- (void)showErrorOfSending
{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Fail" message:@"could not send message" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"OK"
                                                            style:UIAlertActionStyleDefault
                                                          handler:^(UIAlertAction *action) {
                                                              nil;
                                                          }];
    [alert addAction:confirmAction];
    
    [controller presentViewController:alert animated:YES completion:nil];
}

@end
