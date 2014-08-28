//
//  TermsConditionsViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/28/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TermsConditionsViewController : UIViewController{
    BOOL privacyChecked;
    BOOL termChecked;
    BOOL fromMenu;
}
@property (nonatomic) BOOL fromMenu;
@property (nonatomic) BOOL privacyChecked;
@property (strong, nonatomic) IBOutlet UIButton *btnAccept;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;

- (IBAction)btnAccpet:(id)sender;
- (IBAction)btnBack:(id)sender;

@end
