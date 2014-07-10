//
//  MainViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "MainViewController.h"
#import "PKRevealController.h"
#import "SideMenuViewController.h"
#import "PKRevealController.h"
#import "MemberInfoViewController.h"
#import "DependentInfoViewController.h"
#import "ClaimsViewController.h"
#import "FindProviderViewController.h"



@interface MainViewController ()

@end

@implementation MainViewController


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
    
    UIImage *revealImagePortrait = [UIImage imageNamed:@"ico_menu_sm"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
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

- (IBAction)btnClaimUpdates:(id)sender {
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

- (IBAction)bthMemberInfo:(id)sender {
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

@end
