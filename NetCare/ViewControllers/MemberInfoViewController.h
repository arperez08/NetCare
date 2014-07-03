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
    
}
@property (nonatomic, retain) IBOutlet UIImageView *imgCard;
@property (nonatomic, retain) IBOutlet UIImageView *imgCardBack;
@property (nonatomic, retain) IBOutlet UIView *cardContainer;
@property (nonatomic, retain) IBOutlet UIButton *btnFlip;
@property (strong, nonatomic) IBOutlet UIView *viewEligibility;

- (IBAction)btnFlipImage:(id)sender;


@end
