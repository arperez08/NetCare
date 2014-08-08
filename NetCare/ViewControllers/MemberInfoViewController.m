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
@synthesize btnMenu, lblTitle, imgTopBar,imgWhitebox;
@synthesize lblFullName,lblDental,lblMedical,lblPlanName, lblMemNbr;

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
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];

    [self.cardContainer addSubview:imgCardBack];
    
    NSLog(@"userData:%@ userInfo:%@",userData,userInfo);
    
    lblMemNbr.text = [userData objectForKey:@"strMemTinNbr"];
    lblFullName.text = [userInfo objectForKey:@"strName"];
    lblPlanName.text = [userInfo objectForKey:@"strPlanName"];
    lblMedical.text = [userInfo objectForKey:@"strMedical"];
    lblDental.text = [userInfo objectForKey:@"strDental"];
    
    NSString * status = [userInfo objectForKey:@"strStatus"];
    if ([status isEqualToString:@"Eligible"]) {
        UIImage* image = [UIImage imageNamed:@"whitebox"];
        imgWhitebox.image = image;
    }
    UIImage *bgimg = [UIImage imageNamed:@"IDFront"];
    UIImage *img = [self drawTextName:@"" inImage:bgimg atPoint:CGPointMake(0, 0)];
    imgCardBack.image = img;
    
    [self checkInterface];
}

-(void) checkInterface{
    UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        // Portrairt mode
        tabBar.hidden = FALSE;
        self.cardContainer.frame = CGRectMake(1.0, 57.0, 320, 200);
        self.imgCard.frame = CGRectMake(1.0, 5.0, 316, 185);
        self.imgCardBack.frame = CGRectMake(1.0, 5.0, 316, 185);
        self.btnFlip.frame = CGRectMake(1.0, 5.0, 316, 185);
        viewEligibility.hidden = NO;
        btnMenu.hidden = NO;
        lblTitle.hidden = NO;
        imgTopBar.hidden = NO;
    }
    else{
        tabBar.hidden = TRUE;
        if ([[UIScreen mainScreen] bounds].size.height == 568) {            // iPhone 5/5S
            self.cardContainer.frame = CGRectMake(30.0, 20.0, 520, 290);
            self.imgCard.frame = CGRectMake(0.0, 0.0, 510, 290);
            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 510, 290);
            self.btnFlip.frame = CGRectMake(0.0, 0.0, 510, 290);
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
}

- (UIImage*) drawTextName:(NSString*) text inImage:(UIImage*) myImage atPoint:(CGPoint) point {
    UIGraphicsBeginImageContext(myImage.size);
    [myImage drawInRect:CGRectMake(1, 5, 575, 365)];
    UITextView *myText = [[UITextView alloc] init];
    myText.frame = CGRectMake(10,110,320,300);
    //myText.text = text;
    myText.text = [NSString stringWithFormat:@"%@\n\nMember#: %@\n\n%@", lblFullName.text, lblMemNbr.text,lblPlanName.text];
    myText.font = [UIFont fontWithName:@"Arial" size:18.0f];
    myText.textColor = [UIColor blackColor];
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByWordWrapping;
    paragraphStyle.alignment = NSTextAlignmentLeft;
    NSDictionary *attributes = @{NSFontAttributeName: myText.font,NSParagraphStyleAttributeName: paragraphStyle};
    [myText.text drawInRect:myText.frame withAttributes:attributes];
    UIImage *myNewImage = UIGraphicsGetImageFromCurrentImageContext();
    return myNewImage;
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
            self.cardContainer.frame = CGRectMake(30.0, 20.0, 520, 290);
            self.imgCard.frame = CGRectMake(0.0, 0.0, 510, 290);
            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 510, 290);
            self.btnFlip.frame = CGRectMake(0.0, 0.0, 510, 290);
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
        self.cardContainer.frame = CGRectMake(1.0, 57.0, 320, 200);
        self.imgCard.frame = CGRectMake(1.0, 5.0, 316, 185);
        self.imgCardBack.frame = CGRectMake(1.0, 5.0, 316, 185);
        self.btnFlip.frame = CGRectMake(1.0, 5.0, 316, 185);
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
