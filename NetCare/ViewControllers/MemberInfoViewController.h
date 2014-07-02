//
//  MemberInfoViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MemberInfoViewController : UIViewController{
    UIView *containerView;
	UIImageView *mainView;
	UIImageView *flipToView;
}
@property (nonatomic, retain) NSString *cardImageId;
@property (nonatomic, retain) UIView *containerView;
@property (nonatomic, retain) UIImageView *mainView;
@property (nonatomic, retain) UIImageView *flipToView;

- (IBAction)btnFlipImage:(id)sender;


@end
