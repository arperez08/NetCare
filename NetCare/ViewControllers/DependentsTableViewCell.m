//
//  DependentsTableViewCell.m
//  NetCare
//
//  Created by MacTwo Moylan on 8/8/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "DependentsTableViewCell.h"

@implementation DependentsTableViewCell
@synthesize lblCoverage,lblPlan,lblMemberNum,lblName,lblEffectiveDate;
- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
