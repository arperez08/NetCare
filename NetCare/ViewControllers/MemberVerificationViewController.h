//
//  MemberVerificationViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/26/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface MemberVerificationViewController : UIViewController<AVCaptureMetadataOutputObjectsDelegate>
{
    MBProgressHUD *HUB;
}

@property (strong, nonatomic) IBOutlet UITextField *txtMemberNumber;
@property (weak, nonatomic) IBOutlet UIView *viewPreview;
@property (weak, nonatomic) IBOutlet UILabel *lblStatus;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *bbitemStart;

@property (strong, nonatomic) IBOutlet UIButton *btnGo;
- (IBAction)btnShowMenu:(id)sender;
- (IBAction)btnGoChange:(id)sender;
- (IBAction)btnStart:(id)sender;
- (IBAction)btnGo:(id)sender;
@end
