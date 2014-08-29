//
//  RegistrationViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/11/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface RegistrationViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>
{
    MBProgressHUD *HUB;
    
    IBOutlet UIScrollView * scrollView;
    BOOL memberCheckbox;
    BOOL providerCheckbox;
    BOOL termsCheckbox;
    
    IBOutlet UIButton *btnTems;
    IBOutlet UIButton *btnMember;
    IBOutlet UIButton *btnProvider;
    
    UIDatePicker *BdayPicker;
    IBOutlet UIButton *btnBday;
    
    UIPickerView *securityQuestion;
    IBOutlet UIButton *btnSecurity;
    NSMutableArray *arrayQuestions;
    
    BOOL privacyChecked;
    BOOL termsChecked;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnMember:(id)sender;
- (IBAction)btnProvider:(id)sender;
- (IBAction)btnTerms:(id)sender;
- (IBAction)btnSubmit:(id)sender;


@property (nonatomic) BOOL privacyChecked;
@property (nonatomic) BOOL termsChecked;

@property (strong, nonatomic) IBOutlet UITextField *txtSecQuestion;
@property (strong, nonatomic) IBOutlet UITextField *txtAnswer;

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtTINNum;
@property (strong, nonatomic) IBOutlet UITextField *txtSSN;
@property (strong, nonatomic) IBOutlet UITextField *txtMemberNum;
@property (strong, nonatomic) IBOutlet UITextField *txtLastName;
@property (strong, nonatomic) IBOutlet UITextField *txtFirstName;
@property (strong, nonatomic) IBOutlet UITextField *txtMiddle;
@property (strong, nonatomic) IBOutlet UITextField *txtDOB;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtUserName;
@property (strong, nonatomic) IBOutlet UITextField *txtPasswrod;
@property (strong, nonatomic) IBOutlet UITextField *txtRePassword;
@property (strong, nonatomic) IBOutlet UIButton *btnTems;
@property (strong, nonatomic) IBOutlet UIButton *btnMember;
@property (strong, nonatomic) IBOutlet UIButton *btnProvider;
@end
