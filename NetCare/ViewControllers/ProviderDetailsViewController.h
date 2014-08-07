//
//  ProviderDetailsViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/31/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderDetailsViewController : UIViewController{
    NSMutableDictionary *jsonData;
}

@property (strong, nonatomic) NSMutableDictionary *jsonData;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSpecialization;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblSchedule;
@property (strong, nonatomic) IBOutlet UILabel *lblContact;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnMap:(id)sender;

@end
