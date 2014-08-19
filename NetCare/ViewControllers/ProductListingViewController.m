//
//  ProductListingViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProductListingViewController.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface ProductListingViewController () <UIDocumentInteractionControllerDelegate>

@end

@implementation ProductListingViewController
@synthesize MIMtableView;

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
    
    self.title = @"Product Listing";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Retrieving and validating data…";
    [HUB showWhileExecuting:@selector(getProductData) onTarget:self withObject:nil animated:YES];
}


-(void) getProductData{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetProducts"];
    NSURL *url = [NSURL URLWithString:strPortalURL];
    NSMutableURLRequest * rurl = [NSMutableURLRequest requestWithURL:url];
    [rurl setHTTPMethod:@"POST"];
    NSURLResponse *response;
    NSError *error;
    NSData *data = [NSURLConnection sendSynchronousRequest:rurl returningResponse:&response error:&error];
    NSMutableArray *arrayData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    
    sectionArray = [[NSMutableArray alloc]init];
    NSMutableArray *cellArrayValue=[[NSMutableArray alloc]init];
    
    for (int i=0; i < [arrayData count]; i++) {
        NSMutableDictionary *json = [arrayData objectAtIndex:i];
        NSString *CountryName = [NSString stringWithFormat:@"%@",[json objectForKey:@"strCountryName"]];
        if (![sectionArray containsObject:CountryName]) {
            [sectionArray addObject:CountryName];
        }
    }
    
    for (int i=0; i < [sectionArray count]; i++) {
        NSString * countryData = @"";
        for (int a=0; a < [arrayData count]; a++) {
            NSString *countryName = [sectionArray objectAtIndex:i];
            NSMutableDictionary *json = [arrayData objectAtIndex:a];
            NSString *strCountryName = [NSString stringWithFormat:@"%@",[json objectForKey:@"strCountryName"]];
            if ([countryName isEqualToString:strCountryName]) {
                NSString *strProdName = [json objectForKey:@"strProdName"];
                NSString *strFileLink = [NSString stringWithFormat:@"%@",[json objectForKey:@"strFileLink"]];
                if ([strFileLink isEqualToString:@"<null>"])
                    countryData = [NSString stringWithFormat:@"%@ \n\u2022 %@",countryData,strProdName];
                else
                    countryData = [NSString stringWithFormat:@"%@ \n\u2022 %@\n  %@",countryData,strProdName,strFileLink];
            }
        }
        [cellArrayValue addObject:countryData];
    }
    
    cellArray=[[NSMutableArray alloc]init];
    cellCount=[[NSMutableArray alloc]init];
    for(int i=0; i < [sectionArray count];i++)
    {
        NSMutableArray *_cellArray=[[NSMutableArray alloc]initWithObjects:[cellArrayValue objectAtIndex:i],nil];
        [cellArray addObject:_cellArray];
        //[cellCount addObject:[NSNumber numberWithInt:[_cellArray count]]];
        [cellCount addObject:[NSNumber numberWithLong:[_cellArray count]]];
        [cellCount replaceObjectAtIndex:i withObject:[NSNumber numberWithInt:0]];
    }
    [MIMtableView reloadData];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions
- (void)showLeftView:(id)sender
{
    if (self.navigationController.revealController.focusedController == self.navigationController.revealController.leftViewController)
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.frontViewController];
    }
    else
    {
        [self.navigationController.revealController showViewController:self.navigationController.revealController.leftViewController];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return  320;
    }
    else{
        return  700;
    }
    return  320;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 46;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleNone;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    //View with the button to expand and shrink and
    //Label to display the Heading.
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 280, 44)];
        
        //Background Image
        //UIImageView *headerBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background-tablecell"]];
        //[headerView addSubview:headerBg];
        //Button
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(2, 2, 280, 44);
        button.tag=section+1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"shirnk.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
        if([[cellCount objectAtIndex:section] intValue]==0)
            button.selected=YES;
        else
            button.selected=NO;
        [headerView addSubview:button];
        
        //Label
        UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 280, 44)];
        [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:12]];
        [headerTitle setTextColor:[UIColor whiteColor]];
        [headerTitle setBackgroundColor:[UIColor clearColor]];
        [headerTitle setText:[sectionArray objectAtIndex:section]];
        headerTitle.lineBreakMode = NSLineBreakByWordWrapping;
        headerTitle.numberOfLines = 0;
        [headerView addSubview:headerTitle];
        return  headerView;
    }
    else{
        UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 700, 44)];
        UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
        button.frame=CGRectMake(2, 2, 700, 44);
        button.tag=section+1;
        [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
        [button setImage:[UIImage imageNamed:@"shirnk.png"] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        if([[cellCount objectAtIndex:section] intValue]==0)
            button.selected=YES;
        else
            button.selected=NO;
        
        [headerView addSubview:button];
        UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 700, 44)];
        [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:18]];
        [headerTitle setTextColor:[UIColor whiteColor]];
        [headerTitle setBackgroundColor:[UIColor clearColor]];
        [headerTitle setText:[sectionArray objectAtIndex:section]];
        headerTitle.lineBreakMode = NSLineBreakByWordWrapping;
        headerTitle.numberOfLines = 0;
        [headerView addSubview:headerTitle];
        return  headerView;
        
    }
    return nil;
}

//datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return [sectionArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [[cellCount objectAtIndex:section] intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[[UITableViewCell alloc]  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
    //Add the Label
    
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        //UILabel *cellTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 280, 350)];
        UITextView *cellTitle=[[UITextView alloc]initWithFrame:CGRectMake(15, 5, 280, 350)];
        [cellTitle setBackgroundColor:[UIColor clearColor]];
        [cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [cellTitle setTextColor:[UIColor blackColor]];
        [cellTitle setText:[[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        //cellTitle.lineBreakMode = NSLineBreakByWordWrapping;
        //cellTitle.numberOfLines = 0;
        cellTitle.scrollEnabled = YES;
        cellTitle.editable = NO;
        cellTitle.selectable = YES;
        cellTitle.dataDetectorTypes = UIDataDetectorTypeLink;
        [cellTitle sizeToFit];
        [cell.contentView addSubview:cellTitle];
        return  cell;
    }
    else{
        UITextView *cellTitle=[[UITextView alloc]initWithFrame:CGRectMake(15, 5, 700, 350)];
        [cellTitle setBackgroundColor:[UIColor clearColor]];
        [cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:14]];
        [cellTitle setTextColor:[UIColor blackColor]];
        [cellTitle setText:[[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        cellTitle.scrollEnabled = YES;
        cellTitle.editable = NO;
        cellTitle.selectable = YES;
        cellTitle.dataDetectorTypes = UIDataDetectorTypeLink;
        [cellTitle sizeToFit];
        [cell.contentView addSubview:cellTitle];
        return  cell;
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

-(IBAction)buttonClicked:(id)sender
{
    UIButton *button=(UIButton *)sender;
    NSInteger _index=[sender tag]-1;
    if(![button isSelected])
        [cellCount replaceObjectAtIndex:_index withObject:[NSNumber numberWithInt:0]];
    else
        [cellCount replaceObjectAtIndex:_index withObject:[NSNumber numberWithLong:[[cellArray objectAtIndex:_index]count]]];
    [MIMtableView reloadData];
}


- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
}

@end
