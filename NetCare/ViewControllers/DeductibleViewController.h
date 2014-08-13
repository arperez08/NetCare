//
//  DeductibleViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface DeductibleViewController : UIViewController
{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}

@property (strong, nonatomic) IBOutlet UITextField *txtIndDeductable;
@property (strong, nonatomic) IBOutlet UITextField *txtIndRemaining;
@property (strong, nonatomic) IBOutlet UITextField *txtIFamDeductable;
@property (strong, nonatomic) IBOutlet UITextField *txtFamRemaining;


- (IBAction)btnShowMenu:(id)sender;
@end
