//
//  SideMenuViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface SideMenuViewController : UIViewController{
    IBOutlet UIScrollView * scrollView;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
    int strUserTyp;
    MBProgressHUD *HUB;
}
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (strong, nonatomic) UITabBarController *tabBarController;

@property (strong, nonatomic) IBOutlet UIButton *btnClaims;
@property (strong, nonatomic) IBOutlet UIButton *btnDeductible;
@property (strong, nonatomic) IBOutlet UIButton *btnMemberInfo;


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
- (IBAction)btnSettings:(id)sender;



@end
