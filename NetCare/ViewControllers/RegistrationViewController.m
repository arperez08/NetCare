//
//  RegistrationViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/11/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "RegistrationViewController.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "SBJson.h"
#import "LoginViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize scrollView;
@synthesize txtTINNum, txtSSN, txtMemberNum, txtLastName, txtFirstName,txtMiddle, txtDOB, txtEmail, txtUserName,txtPasswrod, txtRePassword;
@synthesize btnTems,btnMember,btnProvider;

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


-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

-(BOOL)connected {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus currrentStatus = [reachability currentReachabilityStatus];
    return currrentStatus;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    memberCheckbox = YES;
    providerCheckbox = NO;
    termsCheckbox = NO;
    
    [self.navigationController setNavigationBarHidden:YES];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 950);
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];

    [btnBday addTarget:self action:@selector(showBDay:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    txtTINNum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"TIN" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtSSN.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"SSN" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtMemberNum.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Member Number" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtLastName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Last Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtFirstName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"First Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtMiddle.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Middle Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtDOB.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Date of Birth" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtEmail.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Email Address" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtUserName.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"User Name" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtPasswrod.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
    txtRePassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Re-Enter Password" attributes:@{NSForegroundColorAttributeName: [UIColor grayColor]}];
}

-(void)dismissKeyboard {
    [txtTINNum resignFirstResponder];
    [txtSSN resignFirstResponder];
    [txtMemberNum resignFirstResponder];
    [txtLastName resignFirstResponder];
    [txtFirstName resignFirstResponder];
    [txtMiddle resignFirstResponder];
    [txtDOB resignFirstResponder];
    [txtEmail resignFirstResponder];
    [txtUserName resignFirstResponder];
    [txtPasswrod resignFirstResponder];
    [txtRePassword resignFirstResponder];
}

-(BOOL) NSStringIsValidEmail:(NSString *)checkString {
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}


- (IBAction)btnSubmit:(id)sender {
    if ([self connected] == NotReachable){
        [self alertStatus:@"No Network Connection" :@"Notification"];
    }
    else{
        [self dismissKeyboard];
        [self validateData];
    }
}

- (void) validateData{
    if (memberCheckbox) {
        if (([txtSSN.text isEqualToString:@""]) && ([txtMemberNum.text isEqualToString:@""])) {
            [self alertStatus:@"SSN or Member number is required" :@"Error"];
        }
        else{
            if (([txtLastName.text isEqualToString:@""]) || ([txtFirstName.text isEqualToString:@""]) || ([txtDOB.text isEqualToString:@""]) || ([txtEmail.text isEqualToString:@""]) || ([txtUserName.text isEqualToString:@""]) || ([txtPasswrod.text isEqualToString:@""])) {
                
                if ([txtLastName.text isEqualToString:@""]) {
                    [self alertStatus:@"Last Name is required." :@"Error"];
                }
                else if ([txtFirstName.text isEqualToString:@""]) {
                    [self alertStatus:@"First Name is required." :@"Error"];
                }
                else if ([txtDOB.text isEqualToString:@""]) {
                    [self alertStatus:@"Date of Birth is required." :@"Error"];
                }
                else if ([txtEmail.text isEqualToString:@""]) {
                    [self alertStatus:@"Email is required." :@"Error"];
                }
                else if ([txtUserName.text isEqualToString:@""]) {
                    [self alertStatus:@"Username is required." :@"Error"];
                }
                else if ([txtPasswrod.text isEqualToString:@""]) {
                    [self alertStatus:@"Password is required." :@"Error"];
                }
            }
            else{
                if ([self NSStringIsValidEmail:txtEmail.text]){
                    if ([txtPasswrod.text isEqual:txtRePassword.text]) {
                        if (!termsCheckbox) {
                            [self alertStatus:@"Please accept terms and conditions" :@"Error"];
                        }
                        else{
                            HUB = [[MBProgressHUD alloc]initWithView:self.view];
                            [self.view addSubview:HUB];
                            [HUB showWhileExecuting:@selector(submitData) onTarget:self withObject:nil animated:YES];
                        }
                    }
                    else{
                        [self alertStatus:@"Password did not match" :@"Error"];
                    }
                }
                else{
                    [self alertStatus:@"Invalid email address" :@"Error"];
                }
            }
        }
    }
    else{
        if ([txtTINNum.text isEqualToString:@""]) {
            [self alertStatus:@"TIN number is required" :@"Error"];
        }
        else{
            if (([txtLastName.text isEqualToString:@""]) || ([txtFirstName.text isEqualToString:@""]) || ([txtDOB.text isEqualToString:@""]) || ([txtEmail.text isEqualToString:@""]) || ([txtUserName.text isEqualToString:@""]) || ([txtPasswrod.text isEqualToString:@""])) {
                
                if ([txtLastName.text isEqualToString:@""]) {
                    [self alertStatus:@"Last Name is required." :@"Error"];
                }
                else if ([txtFirstName.text isEqualToString:@""]) {
                    [self alertStatus:@"First Name is required." :@"Error"];
                }
                else if ([txtDOB.text isEqualToString:@""]) {
                    [self alertStatus:@"Date of Birth is required." :@"Error"];
                }
                else if ([txtEmail.text isEqualToString:@""]) {
                    [self alertStatus:@"Email is required." :@"Error"];
                }
                else if ([txtUserName.text isEqualToString:@""]) {
                    [self alertStatus:@"Username is required." :@"Error"];
                }
                else if ([txtPasswrod.text isEqualToString:@""]) {
                    [self alertStatus:@"Password is required." :@"Error"];
                }
            }
            else{
                if ([self NSStringIsValidEmail:txtEmail.text]){
                    if ([txtPasswrod.text isEqual:txtRePassword.text]) {
                        if (!termsCheckbox) {
                            [self alertStatus:@"Please accept terms and conditions" :@"Error"];
                        }
                        else{
                            HUB = [[MBProgressHUD alloc]initWithView:self.view];
                            [self.view addSubview:HUB];
                            [HUB showWhileExecuting:@selector(submitData) onTarget:self withObject:nil animated:YES];
                        }
                    }
                    else{
                        [self alertStatus:@"Password did not match" :@"Error"];
                    }
                }
                else{
                    [self alertStatus:@"Invalid email address" :@"Error"];
                }
            }
        }
    }
}

- (void) submitData {
    int intIDType = 0;
    if (!memberCheckbox)
        intIDType = 1;
    NSString *strIDType = [NSString stringWithFormat:@"%d",intIDType];
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"RegisterUser"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtMemberNum.text forKey:@"strMemTINNbr"];
    [request setPostValue:txtSSN.text forKey:@"strSSN"];
    [request setPostValue:txtFirstName.text forKey:@"strFirstName"];
    [request setPostValue:txtMiddle.text forKey:@"strMiddleName"];
    [request setPostValue:txtLastName.text forKey:@"strLastName"];
    [request setPostValue:txtDOB.text forKey:@"strDOB"];
    [request setPostValue:txtEmail.text forKey:@"strEmailAdd"];
    [request setPostValue:txtUserName.text forKey:@"strUserName"];
    [request setPostValue:txtPasswrod.text forKey:@"strPassword"];
    [request setPostValue:strIDType forKey:@"intUserType"];
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
            [self alertStatus:@"Registeration successfull, please check your registered email address for more information." :@"Success"];
            LoginViewController *Lvc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:[NSBundle mainBundle]];
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:Lvc animated:YES];
        }
        else{
            [self alertStatus:strStatus :@"Error"];
        }
    }
    else{
        [self alertStatus:[NSString stringWithFormat:@"%@",error] :@"Error"];
        NSLog(@"error: %@",error);
    }
}

- (IBAction)btnMember:(id)sender {
    if (!memberCheckbox) {
        [btnMember setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        memberCheckbox = YES;
        [btnProvider setImage:nil forState:UIControlStateNormal];
        providerCheckbox = NO;
        txtTINNum.enabled = FALSE;
        txtTINNum.alpha = 0.3;
        txtTINNum.text = @"";
        txtSSN.enabled = TRUE;
        txtSSN.alpha = 1.0;
        txtMemberNum.enabled = TRUE;
        txtMemberNum.alpha = 1.0;
    }
}

- (IBAction)btnProvider:(id)sender {
    if (!providerCheckbox) {
        [btnProvider setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        providerCheckbox = YES;
        [btnMember setImage:nil forState:UIControlStateNormal];
        memberCheckbox = NO;
        txtTINNum.enabled = TRUE;
        txtTINNum.alpha = 1.0;
        txtSSN.enabled = FALSE;
        txtSSN.alpha = 0.3;
        txtSSN.text = @"";
        txtMemberNum.enabled = FALSE;
        txtMemberNum.alpha = 0.3;
        txtMemberNum.text = @"";
    }
}

- (IBAction)btnTerms:(id)sender {
    if (!termsCheckbox) {
        [btnTems setImage:[UIImage imageNamed:@"check.png"] forState:UIControlStateNormal];
        termsCheckbox = YES;
    }
    else if (termsCheckbox) {
        [btnTems setImage:nil forState:UIControlStateNormal];
        termsCheckbox = NO;
    }
}

-(void)updateTextField:(id)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    //txtBday.text = [dateFormat stringFromDate:BdayPicker.date];
    //bdayString = BdayPicker.date;
    txtDOB.text = [dateFormat stringFromDate:BdayPicker.date];
}


-(void)showBDay:(id)sender forEvent:(UIEvent*)event{
    [self dismissKeyboard];
    UIViewController *bdayNameView = [[UIViewController alloc]init];
    bdayNameView.view.frame = CGRectMake(0,0, 300, 150);
    BdayPicker = [[UIDatePicker alloc] init];
    BdayPicker.frame  = CGRectMake(0,0, 300, 100);
    BdayPicker.datePickerMode = UIDatePickerModeDate;
    [bdayNameView.view addSubview:BdayPicker];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];

    if (![txtDOB.text  isEqual: @""]){
        BdayPicker.date = [dateFormat dateFromString:txtDOB.text];
        [BdayPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    else{
        //BdayPicker.date = [dateFormat dateFromString:@"Jan 01, 1970"];
        [BdayPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:bdayNameView];
    popoverController.cornerRadius = 10;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}


@end
