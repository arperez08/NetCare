//
//  ProviderListViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/30/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProviderListViewController.h"
#import "ProviderListTableViewCell.h"
#import "ProviderDetailsViewController.h"

@interface ProviderListViewController ()

@end

@implementation ProviderListViewController
@synthesize responseData, MIMtableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //NSLog(@"%@",responseData);
    arrayData = [[NSMutableArray alloc] init];
    arrayData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableContainers error:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [arrayData count];
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return  1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSDictionary *jsonData = [arrayData objectAtIndex:indexPath.section];
    
    static NSString *simpleTableIdentifier = @"Cell";
    ProviderListTableViewCell *cell = (ProviderListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProviderListTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        else{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ProviderListTableViewCell_iPad" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    }
    cell.lblName.text = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strPrvName"]];
    cell.lblSpecialization.text = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strSpecialist"]];
    
    cell.lblAddress.text = [NSString stringWithFormat:@"%@ %@",[jsonData objectForKey:@"strCity"],[jsonData objectForKey:@"strCountry"]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIView alloc] init];
    //cell.selectedBackgroundView = [[UIView alloc] init];
   
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSMutableDictionary *jsonData = [arrayData objectAtIndex:indexPath.section];
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        ProviderDetailsViewController *pdvc = [[ProviderDetailsViewController alloc] initWithNibName:@"ProviderDetailsViewController" bundle:[NSBundle mainBundle]];
        pdvc.jsonData = jsonData;
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:pdvc animated:YES];
    }
    else{
        
        ProviderDetailsViewController *pdvc = [[ProviderDetailsViewController alloc] initWithNibName:@"ProviderDetailsViewController_iPad" bundle:[NSBundle mainBundle]];
        pdvc.jsonData = jsonData;
        [self.navigationController setNavigationBarHidden:YES];
        [self.navigationController pushViewController:pdvc animated:YES];
    }
    
    


}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return  YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}


- (IBAction)btnBack:(id)sender {
     [self.navigationController popViewControllerAnimated:YES];
}
@end
