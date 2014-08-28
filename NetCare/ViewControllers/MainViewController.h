//
//  MainViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface MainViewController : UIViewController{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}
@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) IBOutlet UIButton *btnClaims;


- (IBAction)btnShowMenu:(id)sender;
- (IBAction)btnFindProvider:(id)sender;
- (IBAction)btnClaimUpdates:(id)sender;
- (IBAction)bthMemberInfo:(id)sender;


@end
