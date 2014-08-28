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
#import "FindProviderMenuViewController.h"
#import "MemberVerificationViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface MainViewController ()

@end

@implementation MainViewController
@synthesize btnClaims;

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
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    int strUserTyp  = [[userData objectForKey:@"strUserTyp"] intValue];
    if (strUserTyp > 0){
        btnClaims.enabled = NO;
    }
    else{
        btnClaims.enabled = YES;
    }
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Retrieving and validating data…";
    [HUB showWhileExecuting:@selector(sendAudit:) onTarget:self withObject:nil animated:YES];
}


-(void) sendAudit: (NSString *) moduleName {
    moduleName = @"Home";
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
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        FindProviderMenuViewController *hvc = [[FindProviderMenuViewController alloc] initWithNibName:@"FindProviderMenuViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:hvc animated:YES];
    }
    else{
        FindProviderMenuViewController *hvc = [[FindProviderMenuViewController alloc] initWithNibName:@"FindProviderMenuViewController_iPad" bundle:[NSBundle mainBundle]];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:hvc animated:YES];
    }
}

- (IBAction)btnClaimUpdates:(id)sender {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ClaimsViewController *hvc = [[ClaimsViewController alloc] initWithNibName:@"ClaimsViewController" bundle:[NSBundle mainBundle]];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:hvc animated:YES];
    }
    else{
        ClaimsViewController *hvc = [[ClaimsViewController alloc] initWithNibName:@"ClaimsViewController_iPad" bundle:[NSBundle mainBundle]];
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:hvc animated:YES];
    }
}

- (IBAction)bthMemberInfo:(id)sender {
    //int userType = [[userData objectForKey:@"strUserTyp"]intValue];
    int strDepedent = [[userInfo objectForKey:@"strDepedent"]intValue];
    int strUserTyp  = [[userData objectForKey:@"strUserTyp"] intValue];
    
    if (strUserTyp > 0){
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            MemberVerificationViewController *hvc = [[MemberVerificationViewController alloc] initWithNibName:@"MemberVerificationViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:hvc animated:YES];
        }
        else{
            MemberVerificationViewController *hvc = [[MemberVerificationViewController alloc] initWithNibName:@"MemberVerificationViewController_iPad" bundle:[NSBundle mainBundle]];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:hvc animated:YES];
        }
    }
    else{
        if (strDepedent == 0) {
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController" bundle:[NSBundle mainBundle]];
                DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController" bundle:[NSBundle mainBundle]];
                hvc.title = @"Member Information";
                hvc.tabBarItem.image = [UIImage imageNamed:@"primary"];
                dvc.title = @"Dependent(s)";
                dvc.tabBarItem.image = [UIImage imageNamed:@"dependent"];
                self.tabBarController = [[UITabBarController alloc] init];
                self.tabBarController.viewControllers = @[hvc, dvc];
                
                UIColor *hexColor = [self colorFromHexString:@"#0d2b9c"];
                self.tabBarController.tabBar.barTintColor = hexColor;
                self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
                [self.tabBarController.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:self.tabBarController animated:YES];
            }
            else{
                MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController_iPad" bundle:[NSBundle mainBundle]];
                DependentInfoViewController *dvc = [[DependentInfoViewController alloc] initWithNibName:@"DependentInfoViewController_iPad" bundle:[NSBundle mainBundle]];
                hvc.title = @"Member Information";
                hvc.tabBarItem.image = [UIImage imageNamed:@"primary"];
                dvc.title = @"Dependent(s)";
                dvc.tabBarItem.image = [UIImage imageNamed:@"dependent"];
                self.tabBarController = [[UITabBarController alloc] init];
                self.tabBarController.viewControllers = @[hvc, dvc];
                
                UIColor *hexColor = [self colorFromHexString:@"#0d2b9c"];
                self.tabBarController.tabBar.barTintColor = hexColor;
                self.tabBarController.tabBar.tintColor = [UIColor whiteColor];
                self.tabBarController.tabBar.itemPositioning = UITabBarItemPositioningFill;
                [self.tabBarController.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:self.tabBarController animated:YES];
                
            }
        }
        else{
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:hvc animated:YES];
            }
            else{
                MemberInfoViewController *hvc = [[MemberInfoViewController alloc] initWithNibName:@"MemberInfoViewController_iPad" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:hvc animated:YES];
            }
        }
    }
}

@end
