//
//  SideMenuViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "SideMenuViewController.h"
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

@interface SideMenuViewController ()

@end

@implementation SideMenuViewController
@synthesize scrollView;

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
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (UIColor *)colorFromHexString:(NSString *)hexString {
    unsigned rgbValue = 0;
    NSScanner *scanner = [NSScanner scannerWithString:hexString];
    [scanner setScanLocation:1];
    [scanner scanHexInt:&rgbValue];
    return [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0];
}


- (IBAction)btnHome:(id)sender {
    MainViewController *mvc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
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
    AboutViewController *avc = [[AboutViewController alloc] initWithNibName:@"AboutViewController" bundle:[NSBundle mainBundle]];
    GenSurveyViewController *gsvc = [[GenSurveyViewController alloc] initWithNibName:@"GenSurveyViewController" bundle:[NSBundle mainBundle]];
    FAQViewController *faqvc = [[FAQViewController alloc] initWithNibName:@"FAQViewController" bundle:[NSBundle mainBundle]];
    
    avc.title = @"About NetCare";
    avc.tabBarItem.image = [UIImage imageNamed:@"about"];
    gsvc.title = @"Contact Us";
    gsvc.tabBarItem.image = [UIImage imageNamed:@"survey"];
    faqvc.title = @"FAQ's";
    faqvc.tabBarItem.image = [UIImage imageNamed:@"FAQs"];
    
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[avc, gsvc, faqvc];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
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
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnMemberInfo:(id)sender {
    MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController" bundle:[NSBundle mainBundle]];
    DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController" bundle:[NSBundle mainBundle]];
    hvc.title = @"Principal";
    hvc.tabBarItem.image = [UIImage imageNamed:@"primary"];
    dvc.title = @"Dependent(s)";
    dvc.tabBarItem.image = [UIImage imageNamed:@"dependent"];
    self.tabBarController = [[UITabBarController alloc] init];
    self.tabBarController.viewControllers = @[hvc, dvc];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
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
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnEligibility:(id)sender {

}

- (IBAction)btnClaims:(id)sender {
    ClaimsViewController *hvc = [[ClaimsViewController alloc] initWithNibName:@"ClaimsViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                leftViewController:leftViewController
                                                                rightViewController:nil
                                                                options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnDeductable:(id)sender {
    DeductibleViewController *hvc = [[DeductibleViewController alloc] initWithNibName:@"DeductibleViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                leftViewController:leftViewController
                                                                rightViewController:nil
                                                                options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnLogout:(id)sender {
    LoginViewController *mvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (IBAction)btnProduct:(id)sender {
    ProductListingViewController *hvc = [[ProductListingViewController alloc] initWithNibName:@"ProductListingViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                leftViewController:leftViewController
                                                                rightViewController:nil
                                                                options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnEvents:(id)sender {
    EventsViewController *hvc = [[EventsViewController alloc] initWithNibName:@"EventsViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnSurvey:(id)sender {
    GenSurveyViewController *hvc = [[GenSurveyViewController alloc] initWithNibName:@"GenSurveyViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnFAQ:(id)sender {
    FAQViewController *hvc = [[FAQViewController alloc] initWithNibName:@"FAQViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnFindProvider:(id)sender {
    FindProviderViewController *hvc = [[FindProviderViewController alloc] initWithNibName:@"FindProviderViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
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
