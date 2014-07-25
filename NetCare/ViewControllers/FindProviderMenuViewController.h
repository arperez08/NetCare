//
//  FindProviderMenuViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/15/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FindProviderMenuViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate>
{
    IBOutlet UIButton *btnCountry;
    NSMutableArray *arrayItemsCountry;
    UIPickerView *countryPicker;

    IBOutlet UIButton *btnCity;
    IBOutlet UIButton *btnSpecialization;
}

@property (strong, nonatomic) IBOutlet UITextField *txtCountry;
@property (strong, nonatomic) IBOutlet UITextField *txtCity;
@property (strong, nonatomic) IBOutlet UITextField *txtSpecialization;

@property (strong, nonatomic) IBOutlet UIButton *btnCountry;
@property (strong, nonatomic) IBOutlet UIButton *btnCity;
@property (strong, nonatomic) IBOutlet UIButton *btnSpecialization;

- (IBAction)btnShowMenu:(id)sender;


@end
