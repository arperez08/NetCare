//
//  ClaimsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ClaimsViewController.h"
#import "ClaimsListTableViewCell.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"
#import "TSPopoverController.h"
#import "TSActionSheet.h"

@interface ClaimsViewController ()

@end

@implementation ClaimsViewController
@synthesize txtFromDate,txtToDate;
@synthesize MIMtableView;
@synthesize btnFrom,btnTo;

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
    
    self.title = @"Claims Update";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    NSUserDefaults *userLogin = [NSUserDefaults standardUserDefaults];
    userData = [[NSMutableDictionary alloc] init];
    userData = [userLogin objectForKey:@"userData"];
    userInfo = [[NSMutableDictionary alloc] init];
    userInfo = [userLogin objectForKey:@"userInfo"];
    
    [btnFrom addTarget:self action:@selector(showFromDate:forEvent:) forControlEvents:UIControlEventTouchUpInside];
    [btnTo addTarget:self action:@selector(showToDate:forEvent:) forControlEvents:UIControlEventTouchUpInside];
}


-(void)showToDate:(id)sender forEvent:(UIEvent*)event{
    UIViewController *ToNameView = [[UIViewController alloc]init];
    ToNameView.view.frame = CGRectMake(0,0, 300, 150);
    toPicker = [[UIDatePicker alloc] init];
    toPicker.frame  = CGRectMake(0,0, 300, 100);
    toPicker.datePickerMode = UIDatePickerModeDate;
    [ToNameView.view addSubview:toPicker];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    if (![txtToDate.text  isEqual: @""]){
        toPicker.date = [dateFormat dateFromString:txtToDate.text];
        [toPicker addTarget:self action:@selector(updateTextFieldTo:) forControlEvents:UIControlEventValueChanged];
    }
    else{
        [toPicker addTarget:self action:@selector(updateTextFieldTo:) forControlEvents:UIControlEventValueChanged];
    }
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:ToNameView];
    popoverController.cornerRadius = 10;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}


-(void)showFromDate:(id)sender forEvent:(UIEvent*)event{
    UIViewController *FromNameView = [[UIViewController alloc]init];
    FromNameView.view.frame = CGRectMake(0,0, 300, 150);
    fromPicker = [[UIDatePicker alloc] init];
    fromPicker.frame  = CGRectMake(0,0, 300, 100);
    fromPicker.datePickerMode = UIDatePickerModeDate;
    [FromNameView.view addSubview:fromPicker];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    if (![txtFromDate.text  isEqual: @""]){
        fromPicker.date = [dateFormat dateFromString:txtFromDate.text];
        [fromPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    else{
        [fromPicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    }
    TSPopoverController *popoverController = [[TSPopoverController alloc] initWithContentViewController:FromNameView];
    popoverController.cornerRadius = 10;
    popoverController.popoverBaseColor = [UIColor whiteColor];
    popoverController.popoverGradient= NO;
    [popoverController showPopoverWithTouch:event];
}


-(void)updateTextField:(id)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    txtFromDate.text = [dateFormat stringFromDate:fromPicker.date];
}

-(void)updateTextFieldTo:(id)sender{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd-MMM-yyyy"];
    txtToDate.text = [dateFormat stringFromDate:toPicker.date];
}

- (void)getClaimsData {
    NSString *strMemNbr = [userData objectForKey:@"strMemTinNbr"];
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetClaims"];
    NSLog(@"strURL: %@",strPortalURL);
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:strPortalURL]];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    [request setPostValue:strMemNbr forKey:@"strMemNbr"];
    [request setPostValue:txtFromDate.text forKey:@"strServiceDateFrm"];
    [request setPostValue:txtToDate.text forKey:@"strServiceDateTo"];
    [request setPostValue:@"0" forKey:@"intAuthType"];
    [request startSynchronous];
    NSData *urlData = [request responseData];
    NSError *error = [request error];
    if (!error) {
        NSString *responseData = [[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        NSLog(@"Data: %@",responseData);
        arrayData = [[NSMutableArray alloc]init];
        arrayData = [NSJSONSerialization JSONObjectWithData:urlData options:NSJSONReadingMutableContainers error:nil];
        [MIMtableView reloadData];
    }
}

- (void)didReceiveMemoryWarning {
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

- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
}

- (IBAction)btnSubmit:(id)sender {
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    HUB.labelText = @"Retrieving and validating data…";
    [HUB showWhileExecuting:@selector(getClaimsData) onTarget:self withObject:nil animated:YES];
    //[self getClaimsData];
}

- (IBAction)btnFrom:(id)sender {
}

- (IBAction)btnTo:(id)sender {
}

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
    ClaimsListTableViewCell *cell = (ClaimsListTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil){
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClaimsListTableViewCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
        else{
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ClaimsListTableViewCell_iPad" owner:self options:nil];
            cell = [nib objectAtIndex:0];
        }
    }
    
    NSString *ServiceDate = [jsonData objectForKey:@"strServiceDate"];
    NSArray *components = [ServiceDate componentsSeparatedByString:@" "];
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"MM/dd/yyyy"];
    NSDate * dateDOB = [dateFormat dateFromString:components[0]];
    cell.lblDate.text = [dateFormat stringFromDate:dateDOB];
    
    cell.lblProvider.text = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strProvName"]];
    cell.lblAmount.text = [NSString stringWithFormat:@"%@",[jsonData objectForKey:@"strChgAmt"]];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.backgroundView = [[UIView alloc] init];
    cell.selectedBackgroundView = [[UIView alloc] init];
    return  cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    NSMutableDictionary *jsonData = [arrayData objectAtIndex:indexPath.section];
//    ProviderDetailsViewController *pdvc = [[ProviderDetailsViewController alloc] initWithNibName:@"ProviderDetailsViewController" bundle:[NSBundle mainBundle]];
//    pdvc.jsonData = jsonData;
//    [self.navigationController setNavigationBarHidden:YES];
//    [self.navigationController pushViewController:pdvc animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return NO;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return  NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
}

@end
