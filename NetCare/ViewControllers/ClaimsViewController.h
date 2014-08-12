//
//  ClaimsViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ClaimsViewController : UIViewController
{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
    
    IBOutlet UITextField *txtFromDate;
    IBOutlet UITextField *txtToDate;
    
}
@property (strong, nonatomic) IBOutlet UITextField *txtFromDate;
@property (strong, nonatomic) IBOutlet UITextField *txtToDate;

- (IBAction)btnShowMenu:(id)sender;
- (IBAction)btnSubmit:(id)sender;

@end
