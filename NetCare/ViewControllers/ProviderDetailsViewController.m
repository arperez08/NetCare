//
//  ProviderDetailsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/31/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProviderDetailsViewController.h"

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
@end
