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
#import "SBJson.h"

@interface FindProviderMenuViewController ()

@end

@implementation FindProviderMenuViewController
@synthesize txtCity,txtCountry,txtSpecialization;
@synthesize btnCountry,btnCity,btnSpecialization,maniScrollView;

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
    arrayItemsCountry = [arrayItemsCountry sortedArrayUsingSelector:@selector(localizedCaseInsensitiveCompare:)];
    [btnCountry addTarget:self action:@selector(showCountry:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnCity addTarget:self action:@selector(showCity:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnSpecialization addTarget:self action:@selector(showSpecialization:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    maniScrollView.contentSize = CGSizeMake(maniScrollView.frame.size.width, 800);
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showSpecialization:(id)sender forEvent:(UIEvent*)event
{
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Loading State/City";
    [HUB showWhileExecuting:@selector(getSpecializationList) onTarget:self withObject:nil animated:YES];
    
    UIViewController *prodNameView = [[UIViewController alloc]init];
    prodNameView.view.frame = CGRectMake(0,0, 280, 162);
    SpecializationPicker = [[UIPickerView alloc] init];
    SpecializationPicker.frame  = CGRectMake(0,0, 280, 162);
    SpecializationPicker.showsSelectionIndicator = YES;
    SpecializationPicker.delegate = self;
    SpecializationPicker.dataSource = self;
    [prodNameView.view addSubview:SpecializationPicker];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:prodNameView];
    popoverController.cornerRadius = 0;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= YES;
    [popoverController showPopoverWithTouch:event];
}

- (void)getSpecializationList{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetSpclst"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtCountry.text forKey:@"strCountry"];
    [request setPostValue:txtCity.text forKey:@"strStateCity"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        SBJsonParser *jsonParser = [SBJsonParser new];
        arrayItemsSpecialization = [[NSMutableArray alloc] init];
        arrayItemsSpecialization = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
    }
    [SpecializationPicker reloadAllComponents];
}

-(void)showCountry:(id)sender forEvent:(UIEvent*)event
{
    btnCity.hidden = NO;
    btnSpecialization.hidden = NO;
    
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


-(void)showCity:(id)sender forEvent:(UIEvent*)event
{
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Loading State/City";
    [HUB showWhileExecuting:@selector(getCityList) onTarget:self withObject:nil animated:YES];

    UIViewController *prodNameView = [[UIViewController alloc]init];
    prodNameView.view.frame = CGRectMake(0,0, 280, 162);
    cityPicker = [[UIPickerView alloc] init];
    cityPicker.frame  = CGRectMake(0,0, 280, 162);
    cityPicker.showsSelectionIndicator = YES;
    cityPicker.delegate = self;
    cityPicker.dataSource = self;
    [prodNameView.view addSubview:cityPicker];
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:prodNameView];
    popoverController.cornerRadius = 0;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= YES;
    [popoverController showPopoverWithTouch:event];
}

- (void) getCityList {
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetStateCity"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:txtCountry.text forKey:@"strCountry"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        SBJsonParser *jsonParser = [SBJsonParser new];
        arrayItemsCity = [[NSMutableArray alloc] init];
        arrayItemsCity = (NSMutableArray *) [jsonParser objectWithString:responseData error:nil];
    }
    [cityPicker reloadAllComponents];
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

- (IBAction)btnClear:(id)sender {
    txtCountry.text = @"";
    txtCity.text = @"";
    txtSpecialization.text = @"";
    btnCity.hidden = YES;
    btnSpecialization.hidden = YES;
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
    [request setPostValue:txtSpecialization.text forKey:@"strSpecialist"];
    NSArray* arrStateCity = [txtCity.text componentsSeparatedByString: @"/"];
    if ([arrStateCity count] > 1) {
        NSString *strState = [arrStateCity objectAtIndex: 0];
        NSString *strCity = [arrStateCity objectAtIndex: 1];
        [request setPostValue:strCity forKey:@"strCity"];
        [request setPostValue:strState forKey:@"strState"];
    }
    else{
        [request setPostValue:@"" forKey:@"strCity"];
        [request setPostValue:@"" forKey:@"strState"];
    }
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        //NSLog(@"responseData: %@",responseData);
        SBJsonParser *jsonParser = [SBJsonParser new];
        //NSMutableArray * arrayData = [[NSMutableArray alloc] init];
        NSMutableArray * arrayData = nil;
        arrayData = [jsonParser objectWithString:responseData error:nil];
        if ([arrayData count] > 0) {
            ProviderListViewController *plvc = [[ProviderListViewController alloc] initWithNibName:@"ProviderListViewController" bundle:[NSBundle mainBundle]];
            plvc.responseData = responseData;
            [self.navigationController setNavigationBarHidden:YES];
            [self.navigationController pushViewController:plvc animated:YES];
        }
        else{
            [self alertStatus:@"Not found" :@""];
        }
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


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
	return 1;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    if (thePickerView == countryPicker) {
        return [arrayItemsCountry count];
    }
    if (thePickerView == cityPicker) {
        return [arrayItemsCity count];
    }
    if (thePickerView == SpecializationPicker) {
        return [arrayItemsSpecialization count];
    }
    return [arrayItemsCountry count];
}

//- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//    if (thePickerView == countryPicker) {
//        NSString* countryName = [arrayItemsCountry objectAtIndex:row];
//        return countryName;
//    }
//    if (thePickerView == cityPicker) {
//        NSMutableDictionary* dictCityName = [arrayItemsCity objectAtIndex:row];
//        NSString *cityName = [NSString stringWithFormat:@"%@",[dictCityName objectForKey:@"strStateCity"]];
//        return cityName;
//    }
//    
//    NSString* countryName = [arrayItemsCountry objectAtIndex:row];
//    return countryName;
//}

- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (thePickerView == countryPicker) {
        NSString* countryName = [arrayItemsCountry objectAtIndex:row];
        if ((![countryName  isEqual: @"Select Country"]) || !countryName) {
            [txtCountry setText:countryName];
        }
    }
    if (thePickerView == cityPicker) {
        NSMutableDictionary* dictCityName = [arrayItemsCity objectAtIndex:row];
        NSString *cityName = [NSString stringWithFormat:@"%@",[dictCityName objectForKey:@"strStateCity"]];
        if (![cityName  isEqual: @"Select State/State"]) {
            [txtCity setText:cityName];
        }
    }
    if (thePickerView == SpecializationPicker) {
        NSMutableDictionary* dictSpecName = [arrayItemsSpecialization objectAtIndex:row];
        NSString *strSpclst = [NSString stringWithFormat:@"%@",[dictSpecName objectForKey:@"strSpclst"]];
        if (![strSpclst  isEqual: @"Select Specialization"]) {
            [txtSpecialization setText:strSpclst];
        }
    }
}

- (UIView *)pickerView:(UIPickerView *)thePickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel* tView = (UILabel*)view;
    if (!tView){
        tView = [[UILabel alloc] init];
        [tView setTextAlignment:NSTextAlignmentCenter];
    }
    if (thePickerView == countryPicker) {
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:24]];
        NSString* countryName = [arrayItemsCountry objectAtIndex:row];
        tView.text=countryName;
    }
    if (thePickerView == cityPicker) {
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        NSMutableDictionary* dictCityName = [arrayItemsCity objectAtIndex:row];
        NSString *cityName = [NSString stringWithFormat:@"%@",[dictCityName objectForKey:@"strStateCity"]];
        tView.text=cityName;
    }
    if (thePickerView == SpecializationPicker) {
        [tView setFont:[UIFont fontWithName:@"Helvetica" size:18]];
        NSMutableDictionary* dictSpecName = [arrayItemsSpecialization objectAtIndex:row];
        NSString *strSpclst = [NSString stringWithFormat:@"%@",[dictSpecName objectForKey:@"strSpclst"]];
        tView.text=strSpclst;
    }
    return tView;
}

@end
