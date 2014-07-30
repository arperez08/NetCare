//
//  FindProviderMenuViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "FindProviderMenuViewController.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "ProviderListViewController.h"

@interface FindProviderMenuViewController ()

@end

@implementation FindProviderMenuViewController
@synthesize txtCity,txtCountry,txtSpecialization;
@synthesize btnCountry,btnCity,btnSpecialization;

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
    
    [self.navigationController setNavigationBarHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissKeyboard)];
    [self.view addGestureRecognizer:tap];
    
    arrayItemsCountry = [[NSMutableArray alloc] init];
    [arrayItemsCountry addObject:@"Select Country"];
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier: @"en_US"];
    NSArray *countryArray = [NSLocale ISOCountryCodes];
    for (NSString *countryCode in countryArray)
    {
        NSString *displayNameString = [locale displayNameForKey:NSLocaleCountryCode value:countryCode];
        [arrayItemsCountry addObject:displayNameString];
    }
    //arrayItemsCountry = [arrayItemsCountry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [btnCountry addTarget:self action:@selector(showCountry:forEvent:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showCountry:(id)sender forEvent:(UIEvent*)event
{
    UIViewController *prodNameView = [[UIViewController alloc]init];
    prodNameView.view.frame = CGRectMake(0,0, 280, 162);
    countryPicker = [[UIPickerView alloc] init];
    countryPicker.frame  = CGRectMake(0,0, 280, 162);
    countryPicker.showsSelectionIndicator = YES;
    countryPicker.delegate = self;
    countryPicker.dataSource = self;
    [prodNameView.view addSubview:countryPicker];
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
    if (thePickerView == countryPicker) {
        return [arrayItemsCountry count];
    }
    return [arrayItemsCountry count];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (thePickerView == countryPicker) {
        NSString* countryName = [arrayItemsCountry objectAtIndex:row];
        return countryName;
    }
    NSString* countryName = [arrayItemsCountry objectAtIndex:row];
    return countryName;
}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView == countryPicker) {
        NSString* countryName = [arrayItemsCountry objectAtIndex:row];
        if (![countryName  isEqual: @"Select Country"]) {
            [txtCountry setText:countryName];
        }
    }
}

- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
}

- (IBAction)btnSearch:(id)sender {
    if ([self connected] == NotReachable){
        [self alertStatus:@"No Network Connection" :@"Notification"];
    }
    else{
        [self dismissKeyboard];
        HUB = [[MBProgressHUD alloc]initWithView:self.view];
        [self.view addSubview:HUB];
        //HUB.labelText = @"";
        [HUB showWhileExecuting:@selector(searchData) onTarget:self withObject:nil animated:YES];
    }
    
}

-(void)dismissKeyboard {
    [txtSpecialization resignFirstResponder];
    [txtCity resignFirstResponder];
    [txtCountry resignFirstResponder];
}

- (void) searchData {
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetProvider"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtCountry.text forKey:@"strCountry"];
    [request setPostValue:txtCity.text forKey:@"strCity"];
    [request setPostValue:txtSpecialization.text forKey:@"strSpecialist"];
    [request setPostValue:@	"" forKey:@"strState"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseData: %@",responseData);
        
        ProviderListViewController *plvc = [[ProviderListViewController alloc] initWithNibName:@"ProviderListViewController" bundle:[NSBundle mainBundle]];
        plvc.responseData = responseData;
        //[self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:plvc animated:YES];
    }
    else{
        NSLog(@"error: %@",error);
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
