//
//  LoginViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "LoginViewController.h"
#import "PKRevealController.h"
#import "MainViewController.h"
#import "SideMenuViewController.h"
#import "SideMenuiPadViewController.h"
#import "RegistrationViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "SBJson.h"


@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize txtPassword,txtUser;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
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
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    txtUser.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    if([userLogin objectForKey:@"Username"] != nil){
        txtUser.text = [userLogin objectForKey:@"Username"];
        //txtPassword.text = [userLogin objectForKey:@"Password"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dismissKeyboard {
    [txtUser resignFirstResponder];
    [txtPassword resignFirstResponder];
}

#define kOFFSET_FOR_KEYBOARD 80.0

-(void)keyboardWillShow {
    // Animate the current view out of the way
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

-(void)textFieldDidBeginEditing:(UITextField *)sender
{
    //if ([sender isEqual:mailTf])
    //{
    //move the main view, so that the keyboard does not hide it.
    if  (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    //}
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}


- (void)viewWillAppear:(BOOL)animated
{
    // register for keyboard notifications
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewWillDisappear:(BOOL)animated
{
    // unregister for keyboard notifications while not visible.
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (IBAction)btnLogin:(id)sender {
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        MainViewController *mvc = [[MainViewController alloc] initWithNibName:@"MainViewController" bundle:[NSBundle mainBundle]];
//        SideMenuViewController *smvc = [[SideMenuViewController alloc] init];
//        
//        UINavigationController *navigateVC = [[UINavigationController alloc] initWithRootViewController:mvc];
//        UIViewController *leftViewController = smvc;
//        PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navigateVC
//                                                                                        leftViewController:leftViewController
//                                                                                       rightViewController:nil
//                                                                                                   options:nil];
//        [self.navigationController setNavigationBarHidden:YES];
//        [self.navigationController pushViewController:revealController animated:YES];
//    }
//    else {
//        MainViewController *mvc = [[MainViewController alloc] initWithNibName:@"MainViewController_iPad" bundle:[NSBundle mainBundle]];
//        SideMenuiPadViewController *smvc = [[SideMenuiPadViewController alloc] init];
//        
//        UINavigationController *navigateVC = [[UINavigationController alloc] initWithRootViewController:mvc];
//        UIViewController *leftViewController = smvc;
//        PKRevealController *revealController = [PKRevealController revealControllerWithFrontViewController:navigateVC
//                                                                                        leftViewController:leftViewController
//                                                                                       rightViewController:nil
//                                                                                                   options:nil];
//        [self.navigationController setNavigationBarHidden:YES];
//        [self.navigationController pushViewController:revealController animated:YES];
//    }

    if ([txtUser.text isEqualToString:@""]) {
         [self alertStatus:@"Please input your Username." :@"Error"];
    }
    else if ([txtPassword.text isEqualToString:@""]){
        [self alertStatus:@"Please input your Password." :@"Error"];
    }
    else {
        if ([self connected] == NotReachable){
            [self alertStatus:@"No Network Connection" :@"Notification"];
        }
        else{
//            HUB = [[MBProgressHUD alloc]initWithView:self.view];
//            [self.view addSubview:HUB];
//            [HUB showWhileExecuting:@selector(userLogin) onTarget:self withObject:nil animated:YES];
            [self userLogin];
        }
    }
}

- (void) userLogin{
    [self dismissKeyboard];
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"AuthenGetUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtUser.text forKey:@"strUserName"];
    [request setPostValue:txtPassword.text forKey:@"strUserPassm"];
    [request setPostValue:@"0" forKey:@"intAuthType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData: %@",responseData);
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSMutableArray *arrayData = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        NSString *strStatus = [NSString stringWithFormat:@"%@",[dictData objectForKey:@"strStatus"]];
        if ([strStatus isEqualToString:@"Success"]) {
            NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
            [userLogin setObject:txtUser.text forKey:@"Username"];
            [userLogin setObject:txtPassword.text forKey:@"Password"];
            
            //HUB = [[MBProgressHUD alloc]initWithView:self.view];
            //HUB.labelText = @"Getting user information...";
            //[self.view addSubview:HUB];
            //[HUB showWhileExecuting:@selector(getUserData) onTarget:self withObject:nil animated:YES];
            
            [self getUserData];
        }
        else{
            [self alertStatus:@"Please check your Username or Password." :@"Error"];
        }
    }
    else{
        [self alertStatus:[NSString stringWithFormat:@"%@",error] :@"Error"];
        NSLog(@"error: %@",error);
    }
}

- (void) getUserData{
    NSString *strMemTINNbr=@"";
    NSString *strDOB=@"";
    
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"AuthenGetUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtUser.text forKey:@"strUserName"];
    [request setPostValue:txtPassword.text forKey:@"strUserPassm"];
    [request setPostValue:@"1" forKey:@"intAuthType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSMutableArray *arrayData = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        strMemTINNbr = [dictData objectForKey:@"strMemTinNbr"];
        NSString *dtDOB = [dictData objectForKey:@"dtDOB"];
        NSArray *components = [dtDOB componentsSeparatedByString:@" "];
        strDOB = components[0];
        
        NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
        [userLogin setObject:dictData forKey:@"userData"];
     }
    strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetUserIDInfo"];
    NSLog(@"strURL: %@",strPortalURL);
    request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:strMemTINNbr forKey:@"strMemTINNbr"];
    [request setPostValue:strDOB forKey:@"strDOB"];
    [request setPostValue:@"0" forKey:@"intMemType"];
    [request startSynchronous];
    urlData = [request responseData];
    error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"responseData UserInfo: %@",responseData);
        SBJsonParser *jsonParser = [SBJsonParser new];
        NSMutableArray *arrayData = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
        NSMutableDictionary *dictData = [arrayData objectAtIndex:0];
        NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
        [userLogin setObject:dictData forKey:@"userInfo"];
        
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
}

- (IBAction)btnRegister:(id)sender {
    RegistrationViewController *rvc = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:rvc animated:YES];
    
}


@end
