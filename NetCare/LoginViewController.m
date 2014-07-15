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
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "RegistrationViewController.h"

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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    
    txtUser.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Username" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    txtPassword.attributedPlaceholder = [[NSAttributedString alloc] initWithString:@"Password" attributes:@{NSForegroundColorAttributeName: [UIColor lightGrayColor]}];
    
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

- (IBAction)btnRegister:(id)sender {
    RegistrationViewController *rvc = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
    [self.navigationController setNavigationBarHidden:YES];
    [self.navigationController pushViewController:rvc animated:YES];
    
}


@end
