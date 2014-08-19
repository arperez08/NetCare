//
//  DeductibleViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "DeductibleViewController.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface DeductibleViewController ()

@end

@implementation DeductibleViewController
@synthesize txtFamRemaining,txtIFamDeductable,txtIndDeductable,txtIndRemaining;

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
    
    self.title = @"Deductible";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Retrieving and validating data…";
    [HUB showWhileExecuting:@selector(getDeductibleData) onTarget:self withObject:nil animated:YES];
}

- (void)getDeductibleData {
    NSString *strMemNbr = [userData objectForKey:@"strMemTinNbr"];
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetDeductible"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:strMemNbr forKey:@"strMemTinNbr"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Data: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *jsonData = [arrayData objectAtIndex:0];
        
        txtIndDeductable.text = [NSString stringWithFormat:@"%.02f",[[jsonData objectForKey:@"strIndivDeductible"] floatValue]];
        txtIFamDeductable.text = [NSString stringWithFormat:@"%.02f",[[jsonData objectForKey:@"strFamDeductible"] floatValue]];
        
        float indCurrDeduc = [[jsonData objectForKey:@"strIndCurrDeduc"] floatValue];
        float FamCurrDeduc = [[jsonData objectForKey:@"strFamCurrDeduc"] floatValue];
        float IndRemaining = [txtIndDeductable.text floatValue] - indCurrDeduc;
        float FamRemaining = [txtIFamDeductable.text floatValue] - FamCurrDeduc;
        
        txtIndRemaining.text = [NSString stringWithFormat:@"%.02f",IndRemaining];
        txtFamRemaining.text = [NSString stringWithFormat:@"%.02f",FamRemaining];
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

@end
