//
//  ProviderListViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/30/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProviderListViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    NSString *responseData;
    NSMutableArray *arrayData;
}
@property (strong, nonatomic) NSString *responseData;
@property(nonatomic,retain)IBOutlet UITableView *MIMtableView;
- (IBAction)btnBack:(id)sender;
@end
