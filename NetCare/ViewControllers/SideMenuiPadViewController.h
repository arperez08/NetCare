//
//  SideMenuiPadViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/3/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SideMenuiPadViewController : UIViewController
{
    
}

@property (strong, nonatomic) UITabBarController *tabBarController;
- (IBAction)btnHome:(id)sender;
- (IBAction)btnMemberInfo:(id)sender;
- (IBAction)btnEligibility:(id)sender;
- (IBAction)btnClaims:(id)sender;
- (IBAction)btnDeductable:(id)sender;
- (IBAction)btnFindProvider:(id)sender;
- (IBAction)btnProduct:(id)sender;
- (IBAction)btnEvents:(id)sender;
- (IBAction)btnSurvey:(id)sender;
- (IBAction)btnFAQ:(id)sender;
- (IBAction)btnAbout:(id)sender;
- (IBAction)btnLogout:(id)sender;

@end
