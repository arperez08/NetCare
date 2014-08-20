//
//  GenSurveyViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface GenSurveyViewController : UIViewController
{
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}
- (IBAction)btnShowMenu:(id)sender;
- (IBAction)btnSubmit:(id)sender;

@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtSubject;
@property (strong, nonatomic) IBOutlet UITextView *txtComments;



@end
