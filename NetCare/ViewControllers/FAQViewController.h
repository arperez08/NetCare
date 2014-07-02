//
//  FAQViewController.h
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FAQViewController : UIViewController <UITableViewDelegate,UITableViewDataSource>
{
    IBOutlet UITableView *MIMtableView;
    NSMutableArray *sectionArray;
    NSMutableArray *cellArray;
    NSMutableArray *cellCount;
}
@property(nonatomic,retain)IBOutlet UITableView *MIMtableView;

@end
