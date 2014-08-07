//
//  ProviderDetailsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/31/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProviderDetailsViewController.h"
#import "LocationViewController.h"
@interface ProviderDetailsViewController ()

@end

@implementation ProviderDetailsViewController
@synthesize jsonData, lblAddress,lblSpecialization,lblName,lblContact,lblSchedule;

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
    
    NSString *address = [NSString stringWithFormat:@"%@ %@ %@ %@",[jsonData objectForKey:@"strAdd1"],[jsonData objectForKey:@"strAdd2"],[jsonData objectForKey:@"strCity"],[jsonData objectForKey:@"strCountry"]];
    
    lblAddress.text = address;
    lblName.text = [jsonData objectForKey:@"strPrvName"];
    lblSpecialization.text =[jsonData objectForKey:@"strSpecialist"];
    lblContact.text = @"";
    lblSchedule.text = @"";
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnMap:(id)sender {
    
    NSString *strXYLoc = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strXYLoc"]];
    
    if (![strXYLoc isEqual:@"<null>"]) {
        LocationViewController *lvc = [[LocationViewController alloc] initWithNibName:@"LocationViewController" bundle:[NSBundle mainBundle]];
        lvc.jsonData = jsonData;
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:lvc animated:YES];
    }
    else{
        [self alertStatus:@"Not Found" :@"Notification"];
    }
}
@end
