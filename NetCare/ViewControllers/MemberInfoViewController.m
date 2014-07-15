//
//  MemberInfoViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "PKRevealController.h"

@interface MemberInfoViewController ()

@end

@implementation MemberInfoViewController
@synthesize imgCard, imgCardBack, cardContainer,btnFlip,viewEligibility;
@synthesize btnMenu, lblTitle, imgTopBar;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Member Information";
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    

    [self.cardContainer addSubview:imgCardBack];
}

- (IBAction)btnFlipImage:(id)sender {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:0.75];
	
	[UIView setAnimationTransition:([self.imgCard superview] ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
						   forView:self.cardContainer cache:YES];
	if ([imgCardBack superview]){
		[self.imgCardBack removeFromSuperview];
		[self.cardContainer addSubview:imgCard];
	}
	else{
		[self.imgCard removeFromSuperview];
		[self.cardContainer addSubview:imgCardBack];
	}
	[UIView commitAnimations];
}

- (BOOL)shouldAutorotate{
    return YES;
}

-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;
{
    UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
    {
         tabBar.hidden = TRUE;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {            // iPhone 5/5S
            self.cardContainer.frame = CGRectMake(20.0, 20.0, 530, 290);
            self.imgCard.frame = CGRectMake(0.0, 0.0, 530, 290);
            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 530, 290);
            self.btnFlip.frame = CGRectMake(0.0, 0.0, 530, 290);
            viewEligibility.hidden = YES;
            btnMenu.hidden = YES;
            lblTitle.hidden = YES;
            imgTopBar.hidden = YES;
        }
        else{                                                               // iPhone 4/4S
            self.cardContainer.frame = CGRectMake(20.0, 20.0, 450, 290);
            self.imgCard.frame = CGRectMake(0.0, 0.0, 450, 290);
            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 450, 290);
            self.btnFlip.frame = CGRectMake(0.0, 0.0, 450, 290);
            viewEligibility.hidden = YES;
            btnMenu.hidden = YES;
            lblTitle.hidden = YES;
            imgTopBar.hidden = YES;
        }
    }
    else
    {
        // Portrairt mode
        tabBar.hidden = FALSE;
        self.cardContainer.frame = CGRectMake(12.0, 57.0, 300, 175);
        self.imgCard.frame = CGRectMake(0.0, 0.0, 300, 175);
        self.imgCardBack.frame = CGRectMake(0.0, 0.0, 300, 175);
        self.btnFlip.frame = CGRectMake(0.0, 0.0, 280, 165);
        viewEligibility.hidden = NO;
        btnMenu.hidden = NO;
        lblTitle.hidden = NO;
        imgTopBar.hidden = NO;
    }
}

#pragma mark - Actions
- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
}

@end
