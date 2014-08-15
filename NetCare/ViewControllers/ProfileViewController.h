//
//  ProfileViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ProfileViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
    IBOutlet UIButton *btnModify;
    BOOL boolSwitch;
    
    UIPickerView *securityQuestion;
    IBOutlet UIButton *btnSecurity;
    NSMutableArray *arrayQuestions;
}

@property (strong, nonatomic) IBOutlet UITextField *txtMemberNumber;
@property (strong, nonatomic) IBOutlet UITextField *txtLastname;
@property (strong, nonatomic) IBOutlet UITextField *txtMiddleName;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtUsername;
@property (strong, nonatomic) IBOutlet UITextField *txtSecurityQ;
@property (strong, nonatomic) IBOutlet UITextField *txtAnswer;
@property (strong, nonatomic) IBOutlet UIButton *btnModify;

@property (strong, nonatomic) IBOutlet UIImageView *imgEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imgQuestion;
@property (strong, nonatomic) IBOutlet UIImageView *imgAnswer;


- (IBAction)btnModify:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnSecurityQuestion:(id)sender;

@end
