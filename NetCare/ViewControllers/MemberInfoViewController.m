//
//  MemberInfoViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "PKRevealController.h"
#import "UIImage+MDQRCode.h"

@interface MemberInfoViewController ()

@end

@implementation MemberInfoViewController
@synthesize imgCard, imgCardBack, cardContainer,btnFlip,viewEligibility,imgQRCode;
@synthesize btnMenu, lblTitle, imgTopBar,imgWhitebox;
@synthesize lblFullName,lblDental,lblMedical,lblPlanName, lblMemNbr;
@synthesize imgExpiredCard,imgExpiredDetails,lblTitleBar;

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
    
    //self.title = @"Member Information";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];

    NSLog(@"userData:%@ userInfo:%@",userData,userInfo);
    
    lblMemNbr.text = [userData objectForKey:@"strMemTinNbr"];
    lblFullName.text = [userInfo objectForKey:@"strName"];
    lblPlanName.text = [userInfo objectForKey:@"strPlanName"];
    
    [self.imgCard removeFromSuperview];
    [self.cardContainer addSubview:imgCardBack];

    NSString * status = [userInfo objectForKey:@"strStatus"];
    if ([status isEqualToString:@"Eligible"]) {
        UIImage *bgimg = [UIImage imageNamed:@"IDFront"];
        UIImage *img = [self drawTextName:@"" inImage:bgimg atPoint:CGPointMake(0, 0)];
        NSString *strMemTinNbr = [userData objectForKey:@"strMemTinNbr"];
        imgQRCode.image = [self generateQRCode:strMemTinNbr];
        UIImage *imgWithQR = [self drawQR:imgQRCode.image inImage:img atPoint:CGPointMake(0, 0)];
        imgCardBack.image = imgWithQR;
    }
    else{
        UIImage *bgimg = [UIImage imageNamed:@"IDFront"];
        UIImage *img = [self drawTextName:@"" inImage:bgimg atPoint:CGPointMake(0, 0)];
        NSString *strMemTinNbr = [userData objectForKey:@"strMemTinNbr"];
        imgQRCode.image = [self generateQRCode:strMemTinNbr];
        UIImage *imgWithQR = [self drawQR:imgQRCode.image inImage:img atPoint:CGPointMake(0, 0)];
        UIImage *imgWithExpired = [self drawExpire:imgExpiredCard.image inImage:imgWithQR atPoint:CGPointMake(0, 0)];
        imgCardBack.image = imgWithExpired;
    }
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        imgCardBack.transform = CGAffineTransformMakeRotation(M_PI/2);
        imgCard.transform = CGAffineTransformMakeRotation(M_PI/2);
    }
    
    //[self.cardContainer addSubview:imgQRCode];
    //[self.cardContainer addSubview:imgExpiredCard];
    [self checkInterface];
}

-(UIImage *) generateQRCode:(NSString*) userMemberNumber {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0.0,0.0,320.0,320.0)];
	imageView.image = [UIImage mdQRCodeForString:userMemberNumber size:imageView.bounds.size.width fillColor:[UIColor blackColor]];
    return imageView.image;
}

-(void) checkInterface{
    UIView *tabBar = [self.tabBarController.view.subviews objectAtIndex:1];
    if([UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortrait || [UIApplication sharedApplication].statusBarOrientation == UIInterfaceOrientationPortraitUpsideDown) {
        
        // Portrairt mode
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//            self.cardContainer.frame = CGRectMake(1.0, 57.0, 320, 200);
//            self.imgCard.frame = CGRectMake(1.0, 1.0, 316, 195);
//            self.imgCardBack.frame = CGRectMake(1.0, 1.0, 316, 195);
//            self.btnFlip.frame = CGRectMake(1.0, 1.0, 316, 195);
            if ([[UIScreen mainScreen] bounds].size.height == 568) {
                self.cardContainer.frame = CGRectMake(5.0, 55.0, 320, 450);
                self.imgCard.frame = CGRectMake(1.0, 1.0, 320, 450);
                self.imgCardBack.frame = CGRectMake(1.0, 1.0, 320, 450);
                self.btnFlip.frame = CGRectMake(1.0, 1.0, 320, 450);
            }
            else{
                self.cardContainer.frame = CGRectMake(25.0, 55.0, 280, 380);
                self.imgCard.frame = CGRectMake(0.0, 0.0, 280, 380);
                self.imgCardBack.frame = CGRectMake(0.0, 0.0, 280, 380);
                self.btnFlip.frame = CGRectMake(0.0, 0.0, 280, 380);
            }
        }
        else{
            self.cardContainer.frame = CGRectMake(1.0, 63.0, 768, 451);
            self.imgCard.frame = CGRectMake(58.0, 1.0, 652, 431);
            self.imgCardBack.frame = CGRectMake(58.0, 1.0, 652, 431);
            self.btnFlip.frame = CGRectMake(58.0, 1.0, 652, 431);
        }
        
        tabBar.hidden = FALSE;
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

- (UIImage*) drawExpire:(UIImage*) qrCode inImage:(UIImage*) myImage atPoint:(CGPoint) point {
    UIGraphicsBeginImageContext(myImage.size);
    [myImage drawInRect:CGRectMake(1, 5, 575, 365)];
    UIImageView *myExpireImage = [[UIImageView alloc]init];
    myExpireImage.frame = CGRectMake(0,50,640,274);
    myExpireImage.image = qrCode;
    [myExpireImage.image drawInRect:myExpireImage.frame];
    UIImage *myNewImage = UIGraphicsGetImageFromCurrentImageContext();
    return myNewImage;
}

- (UIImage*) drawQR:(UIImage*) qrCode inImage:(UIImage*) myImage atPoint:(CGPoint) point {
    UIGraphicsBeginImageContext(myImage.size);
    [myImage drawInRect:CGRectMake(1, 5, 575, 365)];
    UIImageView *myQRImage = [[UIImageView alloc]init];
    myQRImage.frame = CGRectMake(450,205,100,100);
    myQRImage.image = qrCode;
    [myQRImage.image drawInRect:myQRImage.frame];
    UIImage *myNewImage = UIGraphicsGetImageFromCurrentImageContext();
    return myNewImage;
}

- (UIImage*) drawTextName:(NSString*) text inImage:(UIImage*) myImage atPoint:(CGPoint) point {
    NSString *strCoverage =@"";
    NSString *strMedical = [userInfo objectForKey:@"strMedical"];
    NSString *strDental = [userInfo objectForKey:@"strDental"];
    NSString *strVision = [userInfo objectForKey:@"strVision"];
    NSString *strDrugs = [userInfo objectForKey:@"strDrugs"];
    if ([strMedical isEqualToString:@"T"]) {
        if ([strCoverage  isEqualToString: @""])
            strCoverage = [NSString stringWithFormat:@"%@ %@",strCoverage,@"MEDICAL"];
        else
            strCoverage = [NSString stringWithFormat:@"%@/ %@",strCoverage,@"MEDICAL"];
    }
    if ([strDental isEqualToString:@"T"]) {
        if ([strCoverage  isEqualToString: @""])
            strCoverage = [NSString stringWithFormat:@"%@ %@",strCoverage,@"DENTAL"];
        else
            strCoverage = [NSString stringWithFormat:@"%@/ %@",strCoverage,@"DENTAL"];
    }
    if ([strVision isEqualToString:@"T"]) {
        if ([strCoverage  isEqualToString: @""])
            strCoverage = [NSString stringWithFormat:@"%@ %@",strCoverage,@"VISION"];
        else
            strCoverage = [NSString stringWithFormat:@"%@/ %@",strCoverage,@"VISION"];
    }
    if ([strDrugs isEqualToString:@"T"]) {
        if ([strCoverage  isEqualToString: @""])
            strCoverage = [NSString stringWithFormat:@"%@ %@",strCoverage,@"DRUGS"];
        else
            strCoverage = [NSString stringWithFormat:@"%@/ %@",strCoverage,@"DRUGS"];
    }
    lblMedical.text =strCoverage;
    UIGraphicsBeginImageContext(myImage.size);
    [myImage drawInRect:CGRectMake(1, 5, 575, 365)];
    UITextView *myText = [[UITextView alloc] init];
    myText.frame = CGRectMake(10,110,320,300);
    //myText.text = text;
    myText.text = [NSString stringWithFormat:@"%@\nMember#: %@\n\n%@\n\n%@", lblFullName.text, lblMemNbr.text,lblPlanName.text,strCoverage];
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

	if ([imgCardBack superview])
    {
		[self.imgCardBack removeFromSuperview];
 		[self.cardContainer addSubview:imgCard];
	}
	else
    {
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
//    if(toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft || toInterfaceOrientation == UIInterfaceOrientationLandscapeRight)
//    {
//        tabBar.hidden = TRUE;
//        if ([[UIScreen mainScreen] bounds].size.height == 568) {            // iPhone 5/5S
//            self.cardContainer.frame = CGRectMake(30.0, 20.0, 520, 290);
//            self.imgCard.frame = CGRectMake(0.0, 0.0, 510, 290);
//            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 510, 290);
//            self.btnFlip.frame = CGRectMake(0.0, 0.0, 510, 290);
//            viewEligibility.hidden = YES;
//            btnMenu.hidden = YES;
//            lblTitle.hidden = YES;
//            imgTopBar.hidden = YES;
//        }
//        else{                                                               // iPhone 4/4S
//            self.cardContainer.frame = CGRectMake(20.0, 20.0, 450, 290);
//            self.imgCard.frame = CGRectMake(0.0, 0.0, 450, 290);
//            self.imgCardBack.frame = CGRectMake(0.0, 0.0, 450, 290);
//            self.btnFlip.frame = CGRectMake(0.0, 0.0, 450, 290);
//            viewEligibility.hidden = YES;
//            btnMenu.hidden = YES;
//            lblTitle.hidden = YES;
//            imgTopBar.hidden = YES;
//        }
//    }
//    else
//    {
        // Portrairt mode
        tabBar.hidden = FALSE;
        //self.cardContainer.frame = CGRectMake(1.0, 57.0, 320, 200);
        //self.imgCard.frame = CGRectMake(1.0, 1.0, 316, 195);
        //self.imgCardBack.frame = CGRectMake(1.0, 1.0, 316, 195);
        //self.btnFlip.frame = CGRectMake(1.0, 1.0, 316, 195);
        viewEligibility.hidden = NO;
        btnMenu.hidden = NO;
        lblTitle.hidden = NO;
        imgTopBar.hidden = NO;
//    }
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
