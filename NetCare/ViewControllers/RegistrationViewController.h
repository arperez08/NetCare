//
//  RegistrationViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/11/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController 
{
    IBOutlet UIScrollView * scrollView;
    BOOL memberCheckbox;
    BOOL providerCheckbox;
    BOOL termsCheckbox;
    
    IBOutlet UIButton *btnTems;
    IBOutlet UIButton *btnMember;
    IBOutlet UIButton *btnProvider;
    
    UIDatePicker *BdayPicker;
    IBOutlet UIButton *btnBday;
    
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnMember:(id)sender;
- (IBAction)btnProvider:(id)sender;
- (IBAction)btnTerms:(id)sender;
- (IBAction)btnSubmit:(id)sender;

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
