//
//  GenSurveyViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GenSurveyViewController : UIViewController
{
    
}
- (IBAction)btnShowMenu:(id)sender;
@property (nonatomic, retain) IBOutlet UIScrollView * scrollView;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtSubject;
@property (strong, nonatomic) IBOutlet UITextView *txtComments;

@end
