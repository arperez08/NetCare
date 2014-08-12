//
//  ClaimsListTableViewCell.h
//  NetCare
//
//  Created by MacTwo Moylan on 8/12/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ClaimsListTableViewCell : UITableViewCell
{
    IBOutlet UILabel *lblProvider;
    IBOutlet UILabel *lblAmount;
    IBOutlet UILabel *lblDate;
}
@property (strong, nonatomic) IBOutlet UILabel *lblProvider;
@property (strong, nonatomic) IBOutlet UILabel *lblAmount;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;

@end
