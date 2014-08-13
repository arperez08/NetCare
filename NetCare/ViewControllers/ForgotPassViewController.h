//
//  ForgotPassViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/13/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ForgotPassViewController : UIViewController
{
    MBProgressHUD *HUB;
    IBOutlet UITextField *txtMemberNum;
    IBOutlet UITextField *txtUsername;
    IBOutlet UILabel *txtSecretQuestion;
    IBOutlet UITextField *txtAnswer;
    IBOutlet UIView *viewQuestion;
    IBOutlet UIButton *btnNext;
    NSString *securityQuestion;
}
@property (strong, nonatomic) IBOutlet UITextField *txtMemberNum;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UILabel *txtSecretQuestion;
@property (strong, nonatomic) IBOutlet UITextField *txtAnswer;
@property (strong, nonatomic) IBOutlet UIView *viewQuestion;
@property (strong, nonatomic) IBOutlet UIButton *btnNext;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnNext:(id)sender;
- (IBAction)btnSubmit:(id)sender;
@end
