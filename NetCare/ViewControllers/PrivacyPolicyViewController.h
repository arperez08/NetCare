//
//  PrivacyPolicyViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/28/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PrivacyPolicyViewController : UIViewController
{
    BOOL privacyChecked;
    BOOL fromMenu;
    
}
@property (nonatomic) BOOL fromMenu;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)btnAccept:(id)sender;
- (IBAction)btnBack:(id)sender;

@end
