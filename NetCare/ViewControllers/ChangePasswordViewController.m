//
//  ChangePasswordViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/13/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ChangePasswordViewController.h"
#import "LoginViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface ChangePasswordViewController ()

@end

@implementation ChangePasswordViewController
@synthesize memberNumber,userName, txtNewPassword,txtRePassword, userEmail;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) alertStatus:(NSString *)msg :(NSString *)title
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"Ok"
                                              otherButtonTitles:nil, nil];
    [alertView performSelectorOnMainThread:@selector(show) withObject:nil waitUntilDone:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void) resetPassword{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"ResetPass"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:memberNumber forKey:@"strMemTinNbr"];
    [request setPostValue:userName forKey:@"struUserName"];
    [request setPostValue:txtNewPassword.text forKey:@"strNewPass"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        
        [self sendAudit:@"ChangePassword"];
        
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Data: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *jsonData = [arrayData objectAtIndex:0];
        NSString *status = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strStatus"]];
        if ([status isEqualToString:@"Success"]) {
            [self alertStatus:@"Reset password successful. Please login with your new password." :@"Notification"];
            [self sendEmailReset:userEmail];
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                LoginViewController *rvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
            else{
                LoginViewController *rvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController_iPad" bundle:[NSBundle mainBundle]];
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
            //LoginViewController *rvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
        }
    }
}

- (void) sendEmailReset: (NSString *) strEmailAdd {
    if (!strEmailAdd) {
        NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
        NSMutableDictionary *userData = [[NSMutableDictionary alloc] init];
        userData = [userLogin objectForKey:@"userData"];
        strEmailAdd = [userData objectForKey:@"strEmailAdd"];
    }
    
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"SendReset"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:strEmailAdd forKey:@"strEmailAdd"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"SendReset: %@",responseData);
    }
}

-(void) sendAudit: (NSString *) moduleName {
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    //NSString *userName = [userLogin objectForKey:@"Username"];
    NSMutableDictionary *userData = [userLogin objectForKey:@"userData"];
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

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSubmit:(id)sender {
    if (([txtNewPassword.text isEqualToString:@""]) && ([txtRePassword.text isEqualToString:@""])) {
        [self alertStatus:@"New Password is required" :@"Error"];
    }
    else{
        if ([txtNewPassword.text isEqual:txtRePassword.text]) {
            //HUB = [[MBProgressHUD alloc]initWithView:self.view];
            //[self.view addSubview:HUB];
            //[HUB showWhileExecuting:@selector(resetPassword) onTarget:self withObject:nil animated:YES];
            [self resetPassword];
        }
        else{
            [self alertStatus:@"Password did not match" :@"Error"];
        }
    }
}

- (IBAction)btnShowPassNew:(id)sender {
    if (txtNewPassword.secureTextEntry == NO) {
        txtNewPassword.secureTextEntry = YES;
    }
    else{
        txtNewPassword.secureTextEntry = NO;
    }
}

- (IBAction)btnShowPassRe:(id)sender {
    if (txtRePassword.secureTextEntry == NO) {
        txtRePassword.secureTextEntry = YES;
    }
    else{
        txtRePassword.secureTextEntry = NO;
    }
}
@end
