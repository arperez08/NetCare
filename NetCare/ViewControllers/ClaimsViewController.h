//
//  ClaimsViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ClaimsViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *MIMtableView;
    MBProgressHUD *HUB;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
    
    IBOutlet UITextField *txtFromDate;
    IBOutlet UITextField *txtToDate;
    NSMutableArray *arrayData;
    
    IBOutlet UIButton *btnFrom;
    UIDatePicker *fromPicker;
    
    IBOutlet UIButton *btnTo;
    UIDatePicker *toPicker;
    
    
    
}
@property(nonatomic,retain)IBOutlet UITableView *MIMtableView;
@property (strong, nonatomic) IBOutlet UITextField *txtFromDate;
@property (strong, nonatomic) IBOutlet UITextField *txtToDate;
@property (strong, nonatomic) IBOutlet UIButton *btnFrom;
@property (strong, nonatomic) IBOutlet UIButton *btnTo;

- (IBAction)btnShowMenu:(id)sender;
- (IBAction)btnSubmit:(id)sender;
- (IBAction)btnFrom:(id)sender;
- (IBAction)btnTo:(id)sender;


@end
