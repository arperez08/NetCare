//
//  MemberInfoViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "PKRevealController.h"

#define kImageHeight		191.0
#define kImageWidth			315.0
#define kTransitionDuration	0.75
#define kTopPlacement		140.0

@interface MemberInfoViewController ()

@end

@implementation MemberInfoViewController
@synthesize containerView, mainView, flipToView, cardImageId;
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
    
    UIImage *revealImagePortrait = [UIImage imageNamed:@"ico_menu_sm"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
    
    CGRect frame = CGRectMake(round((self.view.bounds.size.width - kImageWidth) / 2.0),
							  kTopPlacement, kImageWidth, kImageHeight);
	self.containerView = [[UIView alloc] initWithFrame:frame];
	[self.view addSubview:self.containerView];

	// create the initial image view
	frame = CGRectMake(0.0, 0.0, kImageWidth, kImageHeight);
	self.mainView = [[UIImageView alloc] initWithFrame:frame];
	self.mainView.image = [UIImage imageNamed:@"blankCard.jpg"];
	[self.containerView addSubview:mainView];
    
    // create the alternate image view (to transition between)
	CGRect imageFrame = CGRectMake(0.0, 0.0, kImageWidth, kImageHeight);
	self.flipToView = [[UIImageView alloc] initWithFrame:imageFrame];
	self.flipToView.image = [UIImage imageNamed:@"blankCard.jpg"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button addTarget:self action:@selector(btnFlipImage:) forControlEvents:UIControlEventTouchDown];
    [button setTitle:@"" forState:UIControlStateNormal];
    button.frame = CGRectMake(0.0, 0.0, kImageWidth, kImageHeight);
    [self.containerView addSubview:button];
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

- (IBAction)btnFlipImage:(id)sender {
    [UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:kTransitionDuration];
	
	[UIView setAnimationTransition:([self.mainView superview] ?
									UIViewAnimationTransitionFlipFromLeft : UIViewAnimationTransitionFlipFromRight)
						   forView:self.containerView cache:YES];
	if ([flipToView superview])
	{
		[self.flipToView removeFromSuperview];
		[self.containerView addSubview:mainView];
	}
	else
	{
		[self.mainView removeFromSuperview];
		[self.containerView addSubview:flipToView];
	}
	[UIView commitAnimations];
}
@end
