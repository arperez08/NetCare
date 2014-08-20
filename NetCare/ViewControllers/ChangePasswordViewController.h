//
//  ChangePasswordViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/13/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ChangePasswordViewController : UIViewController{
    MBProgressHUD *HUB;
    NSString *userName;
    NSString *memberNumber;
    NSString *userEmail;
    IBOutlet UITextField *txtNewPassword;
    IBOutlet UITextField *txtRePassword;
}
@property (strong, nonatomic) NSString *userName;
@property (strong, nonatomic) NSString *memberNumber;
@property (strong, nonatomic) NSString *userEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtNewPassword;
@property (strong, nonatomic) IBOutlet UITextField *txtRePassword;


- (IBAction)btnBack:(id)sender;
- (IBAction)btnSubmit:(id)sender;

- (IBAction)btnShowPassNew:(id)sender;
- (IBAction)btnShowPassRe:(id)sender;


@end
