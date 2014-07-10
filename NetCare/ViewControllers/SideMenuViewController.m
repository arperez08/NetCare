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
#import "EligibilityViewController.h"
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
    avc.tabBarItem.image = [UIImage imageNamed:@"About Netcare"];
    gsvc.title = @"Contact Us";
    gsvc.tabBarItem.image = [UIImage imageNamed:@"Gen Survey"];
    faqvc.title = @"FAQ's";
    faqvc.tabBarItem.image = [UIImage imageNamed:@"FAQ's"];
    
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
    
    //UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"topbar.png"]];
    //[self.tabBarController.tabBar insertSubview:imageView atIndex:0];
    
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnMemberInfo:(id)sender {
    MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController" bundle:[NSBundle mainBundle]];
    DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController" bundle:[NSBundle mainBundle]];
    hvc.title = @"Principal";
    hvc.tabBarItem.image = [UIImage imageNamed:@"member"];
    dvc.title = @"Dependent(s)";
    dvc.tabBarItem.image = [UIImage imageNamed:@"dependents"];
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
    
    
    [revealController shouldAutorotate];
    
    //[self.navigationController setNavigationBarHidden:YES animated:YES];
    [self.tabBarController.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnEligibility:(id)sender {
    EligibilityViewController *hvc = [[EligibilityViewController alloc] initWithNibName:@"EligibilityViewController" bundle:[NSBundle mainBundle]];
    SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
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
