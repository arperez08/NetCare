//
//  SettingsViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SettingsViewController : UIViewController
{
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}

- (IBAction)btnBack:(id)sender;
- (IBAction)btnProfile:(id)sender;
- (IBAction)btnChangePass:(id)sender;

@end
