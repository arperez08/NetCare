//
//  SideMenuiPadViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/18/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "SideMenuiPadViewController.h"
#import "PKRevealController.h"
#import "LoginViewController.h"
#import "MainViewController.h"
#import "MemberInfoViewController.h"
#import "DependentInfoViewController.h"
#import "ClaimsViewController.h"
#import "DeductibleViewController.h"
#import "FindProviderViewController.h"
#import "ProductListingViewController.h"
#import "EventsViewController.h"
#import "GenSurveyViewController.h"
#import "FAQViewController.h"
#import "AboutViewController.h"
#import "FindProviderMenuViewController.h"
#import "SettingsViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "MemberVerificationViewController.h"

@interface SideMenuiPadViewController ()

@end

@implementation SideMenuiPadViewController
@synthesize scrollView,btnClaims,btnDeductible,btnMemberInfo;

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 800);
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    strUserTyp  = [[userData objectForKey:@"strUserTyp"] intValue];
    
    if (strUserTyp > 0) {
        btnDeductible.enabled = NO;
        btnClaims.enabled = NO;
        [btnMemberInfo setTitle:@"  Member Coverage Verifier" forState:UIControlStateNormal];
    }
    else{
        btnDeductible.enabled = YES;
        btnClaims.enabled = YES;
        [btnMemberInfo setTitle:@"  Member Information" forState:UIControlStateNormal];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) sendAudit: (NSString *) moduleName {
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    NSString *userName = [userLogin objectForKey:@"Username"];
    NSString *strMemTinNbr = [userData objectForKey:@"strMemTinNbr"];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy HH:mm:ss"];
    NSString *dateNow = [dateFormat stringFromDate:now];
    
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"RegisterAudit"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:moduleName forKey:@"strModule"];
    [request setPostValue:strMemTinNbr forKey:@"strMemTINNbr"];
    [request setPostValue:userName forKey:@"strUserName"];
    [request setPostValue:dateNow forKey:@"strEntryDTime"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"RegisterAudit: %@",responseData);
    }
}




- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


- (IBAction)btnHome:(id)sender {
    //[self sendAudit:@"Home"];
    MainViewController *mvc = [[MainViewController alloc] initWithNibName:@"MainViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *navigateVC = [[UINavigationController alloc] initWithRootViewController:mvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navigateVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnAbout:(id)sender {
    //[self sendAudit:@"About"];
    AboutViewController *avc = [[AboutViewController alloc] initWithNibName:@"AboutViewController_iPad" bundle:[NSBundle mainBundle]];
    GenSurveyViewController *gsvc = [[GenSurveyViewController alloc] initWithNibName:@"GenSurveyViewController_iPad" bundle:[NSBundle mainBundle]];
    FAQViewController *faqvc = [[FAQViewController alloc] initWithNibName:@"FAQViewController_iPad" bundle:[NSBundle mainBundle]];
    
    avc.title = @"About NetCare";
    avc.tabBarItem.image = [UIImage imageNamed:@"about"];
    gsvc.title = @"Contact Us";
    gsvc.tabBarItem.image = [UIImage imageNamed:@"survey"];
    faqvc.title = @"FAQ's";
    faqvc.tabBarItem.image = [UIImage imageNamed:@"FAQs"];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[avc, gsvc, faqvc];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
    //UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    
    UIColor *hexColor = [self colorFromHexString:@"#0d2b9c"];
    self.tabBarController.tabBar.barTintColor = hexColor;
    self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
    self.tabBarController.tabBar.itemPositioning = UITabBarItemPositioningFill;
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnMemberInfo:(id)sender {
    //[self sendAudit:@"Member Information"];
    int strDepedent = [[userInfo objectForKey:@"strDepedent"]intValue];
    
    if (strUserTyp > 0){
        MemberVerificationViewController *hvc = [[MemberVerificationViewController alloc] initWithNibName:@"MemberVerificationViewController_iPad" bundle:[NSBundle mainBundle]];
        SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
        UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
        UIViewController *leftViewController = smvc;
        PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                        leftViewController:leftViewController
                                                                                       rightViewController:nil
                                                                                                   options:nil];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:revealController animated:YES];
    }
    else{
        if (strDepedent == 0) {
            MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController_iPad" bundle:[NSBundle mainBundle]];
            DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController_iPad" bundle:[NSBundle mainBundle]];
            hvc.title = @"Member Information";
            hvc.tabBarItem.image = [UIImage imageNamed:@"primary"];
            dvc.title = @"Dependent(s)";
            dvc.tabBarItem.image = [UIImage imageNamed:@"dependent"];
            self.tabBarController = [[UITabBarController alloc] init];
            self.tabBarController.viewControllers = @[hvc, dvc];
            SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
            UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:self.tabBarController];
            //UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
            UIViewController *leftViewController = smvc;
            PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                            leftViewController:leftViewController
                                                                                           rightViewController:nil
                                                                                                       options:nil];
            UIColor *hexColor = [self colorFromHexString:@"#0d2b9c"];
            self.tabBarController.tabBar.barTintColor = hexColor;
            self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
            self.tabBarController.tabBar.itemPositioning = UITabBarItemPositioningFill;
            [self.tabBarController.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:revealController animated:YES];
        }
        else{
            MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController_iPad" bundle:[NSBundle mainBundle]];
            SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
            UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
            UIViewController *leftViewController = smvc;
            PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                            leftViewController:leftViewController
                                                                                           rightViewController:nil
                                                                                                       options:nil];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:revealController animated:YES];
        }
    }
}

- (IBAction)btnEligibility:(id)sender {
    
}

- (IBAction)btnClaims:(id)sender {
    //[self sendAudit:@"Claims"];
    ClaimsViewController *hvc = [[ClaimsViewController alloc] initWithNibName:@"ClaimsViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnDeductable:(id)sender {
    //[self sendAudit:@"Duductible"];
    DeductibleViewController *hvc = [[DeductibleViewController alloc] initWithNibName:@"DeductibleViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnLogout:(id)sender {
    //[self sendAudit:@"Logout"];
    LoginViewController *mvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (IBAction)btnSettings:(id)sender {
    //[self sendAudit:@"Settings"];
    SettingsViewController *hvc = [[SettingsViewController alloc] initWithNibName:@"SettingsViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
    
}

- (IBAction)btnProduct:(id)sender {
    //[self sendAudit:@"Product"];
    ProductListingViewController *hvc = [[ProductListingViewController alloc] initWithNibName:@"ProductListingViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnEvents:(id)sender {
    //[self sendAudit:@"Events"];
    EventsViewController *hvc = [[EventsViewController alloc] initWithNibName:@"EventsViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnSurvey:(id)sender {
    GenSurveyViewController *hvc = [[GenSurveyViewController alloc] initWithNibName:@"GenSurveyViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnFAQ:(id)sender {
    FAQViewController *hvc = [[FAQViewController alloc] initWithNibName:@"FAQViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnFindProvider:(id)sender {
    //[self sendAudit:@"Find Provider"];
    FindProviderMenuViewController *hvc = [[FindProviderMenuViewController alloc] initWithNibName:@"FindProviderMenuViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
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


@end