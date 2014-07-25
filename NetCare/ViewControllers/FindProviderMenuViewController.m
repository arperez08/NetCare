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

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.navigationController setNavigationBarHidden:YES];
    
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
