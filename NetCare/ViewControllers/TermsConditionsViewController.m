//
//  TermsConditionsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/28/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "TermsConditionsViewController.h"
#import "RegistrationViewController.h"
#import "UIBAlertView.h"
#import "PKRevealController.h"

@interface TermsConditionsViewController ()

@end

@implementation TermsConditionsViewController
@synthesize privacyChecked,fromMenu,btnAccept,btnBack;

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
    if (fromMenu == YES) {
        btnAccept.hidden = YES;
        UIImage *btnImage = [UIImage imageNamed:@"menubtn.png"];
        [btnBack setImage:btnImage forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnAccpet:(id)sender {
    UIBAlertView *alert = [[UIBAlertView alloc] initWithTitle:@"Message" message:@"Agree with Terms and Condition" cancelButtonTitle:@"Cancel" otherButtonTitles:@"Agree",nil];
    [alert showWithDismissHandler:^(NSInteger selectedIndex, BOOL didCancel) {
        if (didCancel){
            return;
        }
        else{
            if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
                RegistrationViewController *rvc = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController" bundle:[NSBundle mainBundle]];
                rvc.privacyChecked = privacyChecked;
                rvc.termsChecked = YES;
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
            else{
                RegistrationViewController *rvc = [[RegistrationViewController alloc] initWithNibName:@"RegistrationViewController_iPad" bundle:[NSBundle mainBundle]];
                rvc.privacyChecked = privacyChecked;
                rvc.termsChecked = YES;
                [self.navigationController setNavigationBarHidden:YES];
                [self.navigationController pushViewController:rvc animated:YES];
            }
        }
    }];
}

- (IBAction)btnBack:(id)sender {
    if (fromMenu == YES) {
        [self showLeftView:sender];
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
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
@end
