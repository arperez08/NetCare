//
//  LoginViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface LoginViewController : UIViewController{
    MBProgressHUD *HUB;
    BOOL loginSuccess;
    NSMutableDictionary *userData;
}
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnRegister:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;

@end
