//
//  SideMenuiPadViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/3/14.
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

@interface SideMenuiPadViewController ()

@end

@implementation SideMenuiPadViewController

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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnHome:(id)sender {
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
    AboutViewController *hvc = [[AboutViewController alloc] initWithNibName:@"AboutViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnMemberInfo:(id)sender {
    MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController_iPad" bundle:[NSBundle mainBundle]];
    DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController_iPad" bundle:[NSBundle mainBundle]];
    hvc.title = @"Principal";
    hvc.tabBarItem.image = [UIImage imageNamed:@"member"];
    dvc.title = @"Dependent(s)";
    dvc.tabBarItem.image = [UIImage imageNamed:@"dependents"];
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
    [self.navigationController pushViewController:revealController animated:YES];
}

- (IBAction)btnEligibility:(id)sender {

}

- (IBAction)btnClaims:(id)sender {
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
    LoginViewController *mvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:[NSBundle mainBundle]];
    [self.navigationController pushViewController:mvc animated:YES];
}

- (IBAction)btnProduct:(id)sender {
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
    FindProviderViewController *hvc = [[FindProviderViewController alloc] initWithNibName:@"FindProviderViewController_iPad" bundle:[NSBundle mainBundle]];
    SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
    UINavigationController *homeVC = [[UINavigationController alloc] initWithRootViewController:hvc];
    UIViewController *leftViewController = smvc;
    PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:homeVC
                                                                                    leftViewController:leftViewController
                                                                                   rightViewController:nil
                                                                                               options:nil];
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
