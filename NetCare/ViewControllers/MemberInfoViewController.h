//
//  MemberInfoViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberInfoViewController : UIViewController{
    IBOutlet UIImageView *imgCard;
    IBOutlet UIImageView *imgCardBack;
    IBOutlet UIView *cardContainer;
    IBOutlet UIButton *btnFlip;
    IBOutlet UIButton *btnMenu;
    IBOutlet UILabel *lblTitle;
    IBOutlet UIImageView *imgTopBar;
    IBOutlet UILabel *lblFullName;
    IBOutlet UILabel *lblMemNbr;
    IBOutlet UILabel *lblPlanName;
    IBOutlet UILabel *lblMedical;
    IBOutlet UILabel *lblDental;
    IBOutlet UIImageView *imgWhitebox;
    
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}
@property (nonatomic, retain) IBOutlet UIImageView *imgCard;
@property (nonatomic, retain) IBOutlet UIImageView *imgCardBack;
@property (nonatomic, retain) IBOutlet UIView *cardContainer;
@property (nonatomic, retain) IBOutlet UIButton *btnFlip;
@property (strong, nonatomic) IBOutlet UIView *viewEligibility;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgTopBar;
@property (strong, nonatomic) IBOutlet UIImageView *imgWhitebox;

@property (strong, nonatomic) IBOutlet UILabel *lblFullName;
@property (strong, nonatomic) IBOutlet UILabel *lblMemNbr;
@property (strong, nonatomic) IBOutlet UILabel *lblPlanName;
@property (strong, nonatomic) IBOutlet UILabel *lblMedical;
@property (strong, nonatomic) IBOutlet UILabel *lblDental;

- (IBAction)btnFlipImage:(id)sender;
- (IBAction)btnShowMenu:(id)sender;

@end
