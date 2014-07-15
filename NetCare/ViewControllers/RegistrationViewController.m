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


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES];
    scrollView.contentSize = CGSizeMake(scrollView.frame.size.width, 900);
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

#define kOFFSET_FOR_KEYBOARD 80.0


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnSubmit:(id)sender {
    [self alertStatus:@"A confirmation email was sent..." :@"Notification"];
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

-(void)updateTextField:(id)sender
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];
    //txtBday.text = [dateFormat stringFromDate:BdayPicker.date];
    //bdayString = BdayPicker.date;
    txtDOB.text = [dateFormat stringFromDate:BdayPicker.date];
}


-(void)showBDay:(id)sender forEvent:(UIEvent*)event
{
    [self dismissKeyboard];
    UIViewController *bdayNameView = [[UIViewController alloc]init];
    bdayNameView.view.frame = CGRectMake(0,0, 300, 150);
    BdayPicker = [[UIDatePicker alloc] init];
    BdayPicker.frame  = CGRectMake(0,0, 300, 100);
    BdayPicker.datePickerMode = UIDatePickerModeDate;
    [bdayNameView.view addSubview:BdayPicker];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MMM dd, yyyy"];

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
