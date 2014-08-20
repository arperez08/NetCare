//
//  ForgotPassViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/13/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ForgotPassViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "ChangePasswordViewController.h"

@interface ForgotPassViewController ()

@end

@implementation ForgotPassViewController
@synthesize txtAnswer,txtMemberNum,txtSecretQuestion,txtUsername,viewQuestion,btnNext,usersEmail;
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
    viewQuestion.hidden = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
}

-(void)dismissKeyboard {
    [txtMemberNum resignFirstResponder];
    [txtUsername resignFirstResponder];
    [txtAnswer resignFirstResponder];
}


#define kOFFSET_FOR_KEYBOARD 60.0

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
    [super viewWillAppear:YES];
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
    [super viewWillDisappear:YES];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (void) getSecurityQuestion{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetSecQstion"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtMemberNum.text forKey:@"strMemTinNbr"];
    [request setPostValue:txtUsername.text forKey:@"struUserName"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Data: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        
        NSString *strArrayCount = [NSString stringWithFormat:@"%d",[arrayData count]];

        if (![strArrayCount isEqualToString:@"0"]) {
            NSMutableDictionary *jsonData = [arrayData objectAtIndex:0];
            txtSecretQuestion.text = [jsonData objectForKey:@"strSecQstion"];
            usersEmail = [jsonData objectForKey:@"strEmail"];
            viewQuestion.hidden = NO;
            btnNext.hidden = YES;
        }
        else{
            [self alertStatus:@"Can't retrieved data using your Member Number and Username, please check." :@"Error"];
        }
    }
}

- (void) getResult {
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"AuthForgotPass"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtMemberNum.text forKey:@"strMemTinNbr"];
    [request setPostValue:txtUsername.text forKey:@"struUserName"];
    [request setPostValue:txtAnswer.text forKey:@"strSecAns"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Data: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSMutableDictionary *jsonData = [arrayData objectAtIndex:0];
        NSString *status = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strStatus"]];
        
        if ([status isEqualToString:@"Success"]) {
            
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                ChangePasswordViewController *rvc = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController" bundle:[NSBundle mainBundle]];
                rvc.userName = txtUsername.text;
                rvc.memberNumber = txtMemberNum.text;
                rvc.userEmail = usersEmail;
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
            else{
                ChangePasswordViewController *rvc = [[ChangePasswordViewController alloc] initWithNibName:@"ChangePasswordViewController_iPad" bundle:[NSBundle mainBundle]];
                rvc.userName = txtUsername.text;
                rvc.memberNumber = txtMemberNum.text;
                rvc.userEmail = usersEmail;
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
        }
        else{
            [self alertStatus:@"Please check your data." :@"Error"];
        }
    }
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnNext:(id)sender {
    if ([txtMemberNum.text isEqualToString:@""]){
        [self alertStatus:@"Please input Member Number." :@"Error"];
    }
    else if ([txtUsername.text isEqualToString:@""]){
        [self alertStatus:@"Please input Username." :@"Error"];
    }
    else{
        HUB = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:HUB];
        HUB.labelText = @"Retrieving and validating data…";
        [HUB showWhileExecuting:@selector(getSecurityQuestion) onTarget:self withObject:nil animated:YES];
    }
}

- (IBAction)btnSubmit:(id)sender {
//    HUB = [[MBProgressHUD alloc]initWithView:self.view];
//    [self.view addSubview:HUB];
//    [HUB showWhileExecuting:@selector(getResult) onTarget:self withObject:nil animated:YES];
    [self getResult];
}
@end
