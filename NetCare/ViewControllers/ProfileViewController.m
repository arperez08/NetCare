//
//  ProfileViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProfileViewController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize btnModify,txtAnswer,txtDOB,txtEmail,txtFirstName,txtLastname,txtMemberNumber,txtMiddleName,txtSecurityQ,txtUsername,imgAnswer,imgEmail,imgQuestion;

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


-(void)dismissKeyboard {
    [txtEmail resignFirstResponder];
    [txtSecurityQ resignFirstResponder];
    [txtAnswer resignFirstResponder];
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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    txtMemberNumber.text = [userData objectForKey:@"strMemTinNbr"];
    txtFirstName.text = [userData objectForKey:@"strFirstName"];
    txtMiddleName.text = [userData objectForKey:@"strMiddleName"];
    txtLastname.text = [userData objectForKey:@"strLastName"];
    txtEmail.text = [userData objectForKey:@"strEmailAdd"];
    txtUsername.text =  [userData objectForKey:@"strUserName"];

    NSString *dtDOB = [userData objectForKey:@"dtDOB"];
    NSArray *components = [dtDOB componentsSeparatedByString:@" "];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate * dateDOB = [dateFormat dateFromString:components[0]];
    txtDOB.text = [dateFormat stringFromDate:dateDOB];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    [btnSecurity addTarget:self action:@selector(showSecQuestions:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    arrayQuestions=[[NSMutableArray alloc]initWithObjects:
                    @"Select Question",
                    @"Who is your favorite actor, musician, or artist?",
                    @"What is the name of your favorite pet?",
                    @"In what city were you born?",
                    @"What high school did you attend?",
                    @"What is the name of your first school?",
                    @"What is your favorite movie?",
                    @"What is your mother's maiden name?",
                    @"What street did you grow up on?",
                    @"What was the make of your first car?",
                    @"When is your anniversary?",
                    @"What is your favorite color?",
                    @"What is your father's middle name?",
                    @"What is the name of your first grade teacher?",
                    @"What was your high school mascot?",
                    @"Which is your favorite web browser?",
                    nil];
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Retrieving and validating data…";
    [HUB showWhileExecuting:@selector(getSecurityQuestion) onTarget:self withObject:nil animated:YES];
    
}

- (void) getSecurityQuestion{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetProfile"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:[userData objectForKey:@"strMemTinNbr"] forKey:@"strMemTinNbr"];
    [request setPostValue:[userData objectForKey:@"strUserName"] forKey:@"strUserName"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"GetProfile: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        NSString *strArrayCount = [NSString stringWithFormat:@"%d",[arrayData count]];
        if (![strArrayCount isEqualToString:@"0"]) {
            NSMutableDictionary *jsonData = [arrayData objectAtIndex:0];
            txtSecurityQ.text = [jsonData objectForKey:@"strSecQstion"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnModify:(id)sender {
    if (boolSwitch == NO) {
        imgQuestion.hidden = NO;
        imgEmail.hidden = NO;
        imgAnswer.hidden = NO;
        
        txtAnswer.enabled = YES;
        txtEmail.enabled = YES;
        btnSecurity.enabled = YES;
        
        [btnModify setTitle: @"Save" forState: UIControlStateNormal];
        boolSwitch = YES;
    }
    else{
        if ([txtAnswer.text isEqualToString:@""]) {
            [self alertStatus:@"Please answer your security question." :@"Notification"];
        }
        else{
            imgQuestion.hidden = YES;
            imgEmail.hidden = YES;
            imgAnswer.hidden = YES;
            
            txtAnswer.enabled = NO;
            txtEmail.enabled = NO;
            btnSecurity.enabled = NO;
            
            [btnModify setTitle: @"Modify Profile" forState: UIControlStateNormal];
            boolSwitch = NO;
            HUB = [[MBProgressHUD alloc]initWithView:self.view];
            [self.view addSubview:HUB];
            HUB.labelText = @"Updating user profile...";
            [HUB showWhileExecuting:@selector(saveProfile) onTarget:self withObject:nil animated:YES];
        }
    }
}

- (void) saveProfile{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"UpdateProfile"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtUsername.text forKey:@"strMemTINNbr"];
    [request setPostValue:txtUsername.text forKey:@"strUserName"];
    [request setPostValue:txtEmail.text forKey:@"strEmailAdd"];
    [request setPostValue:txtSecurityQ.text forKey:@"strSecQstion"];
    [request setPostValue:txtAnswer.text forKey:@"strSecAns"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"UpdateProfile: %@",responseData);
        NSMutableArray *arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
    }
}

-(void)showSecQuestions:(id)sender forEvent:(UIEvent*)event{
    [self dismissKeyboard];
    UIViewController *prodNameView = [[UIViewController alloc]init];
    prodNameView.view.frame = CGRectMake(0,0, 320, 162);
    securityQuestion = [[UIPickerView alloc] init];
    securityQuestion.frame  = CGRectMake(0,0, 320, 162);
    securityQuestion.showsSelectionIndicator = YES;
    securityQuestion.delegate = self;
    securityQuestion.dataSource = self;
    [prodNameView.view addSubview:securityQuestion];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:prodNameView];
    popoverController.cornerRadius = 0;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= YES;
    [popoverController showPopoverWithTouch:event];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return [arrayQuestions count];
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView == securityQuestion) {
        NSString* questions = [arrayQuestions objectAtIndex:row];
        if ((![questions  isEqual: @"Select Question"]) || !questions) {
            [txtSecurityQ setText:questions];
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setTextAlignment:NSTextAlignmentCenter];
        [tView setLineBreakMode:0];
    }
    if (thePickerView == securityQuestion) {
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        NSString* countryName = [arrayQuestions objectAtIndex:row];
        tView.text=countryName;
    }
    return tView;
}



- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSecurityQuestion:(id)sender {
}
@end
