//
//  ProductListingViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface ProductListingViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *HUB;
    IBOutlet UITableView *MIMtableView;
    NSMutableArray *sectionArray;
    NSMutableArray *cellArray;
    NSMutableArray *cellCount;
}
@property(nonatomic,retain)IBOutlet UITableView *MIMtableView;
- (IBAction)btnShowMenu:(id)sender;
@end
