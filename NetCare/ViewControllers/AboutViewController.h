//
//  AboutViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/1/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "Reachability.h"

@interface AboutViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>{
    MBProgressHUD *HUB;
    IBOutlet UITableView *MIMtableView;
    NSMutableArray *sectionArray;
    NSMutableArray *cellArray;
    NSMutableArray *cellCount;
    NSMutableDictionary *userData;
    NSMutableDictionary *userInfo;
}
@property(nonatomic,retain)IBOutlet UITableView *MIMtableView;
- (IBAction)btnShowMenu:(id)sender;
@end
