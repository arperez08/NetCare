//
//  DependentsTableViewCell.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/8/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DependentsTableViewCell : UITableViewCell{
    IBOutlet UILabel *lblName;
    IBOutlet UILabel *lblMemberNum;
    IBOutlet UILabel *lblPlan;
    IBOutlet UILabel *lblCoverage;
}

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblMemberNum;
@property (strong, nonatomic) IBOutlet UILabel *lblPlan;
@property (strong, nonatomic) IBOutlet UILabel *lblCoverage;

@end
