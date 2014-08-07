//
//  DependentInfoViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "DependentInfoViewController.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "SBJson.h"


@interface DependentInfoViewController ()

@end

@implementation DependentInfoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus currrentStatus = [reachability currentReachabilityStatus];
    return currrentStatus;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Getting your dependents information.";
    [HUB showWhileExecuting:@selector(getDependentsInfo) onTarget:self withObject:nil animated:YES];
}

- (void) getDependentsInfo {
    NSString *strMemTINNbr= [userData objectForKey:@"strMemTinNbr"];
    NSString *dtDOB = [userData objectForKey:@"dtDOB"];
    NSArray *components = [dtDOB componentsSeparatedByString:@" "];
    NSString *strDOB = components[0];
    
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetUserIDInfo"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:strMemTINNbr forKey:@"strMemTINNbr"];
    [request setPostValue:strDOB forKey:@"strDOB"];
    [request setPostValue:@"1" forKey:@"intMemType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData DependentsInfo: %@",responseData);
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSMutableArray *arrayData = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
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
