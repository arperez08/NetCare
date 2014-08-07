//
//  DependentInfoViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface DependentInfoViewController : UIViewController
{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}
- (IBAction)btnShowMenu:(id)sender;
@end
