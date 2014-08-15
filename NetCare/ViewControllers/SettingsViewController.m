//
//  SettingsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "SettingsViewController.h"
#import "ChangePasswordViewController.h"
#import "PKRevealController.h"
#import "ProfileViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

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
    [self.navigationController setNavigationBarHidden:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    //[self.navigationController popViewControllerAnimated:YES];
     [self showLeftView:sender];
}

- (IBAction)btnProfile:(id)sender {
    ProfileViewController *rvc = [[ProfileViewController alloc] initWithNibName:@"ProfileViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:rvc animated:YES];
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



- (IBAction)btnChangePass:(id)sender {
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    NSString *userName = [userLogin objectForKey:@"Username"];
    ChangePasswordViewController *rvc = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:[NSBundle mainBundle]];
    rvc.userName = userName;
    rvc.memberNumber = [userData objectForKey:@"strMemTinNbr"];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:rvc animated:YES];
}
@end
