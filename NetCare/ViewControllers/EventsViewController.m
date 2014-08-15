//
//  EventsViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "EventsViewController.h"
#import "PKRevealController.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Constants.h"

@interface EventsViewController ()

@end

@implementation EventsViewController
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
    self.title = @"Upcoming Events";
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
    HUB = [[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:HUB];
    [HUB showWhileExecuting:@selector(getEvents) onTarget:self withObject:nil animated:YES];
}

- (void) getEvents{
    NSString * strPortalURL = [NSString stringWithFormat:PORTAL_URL,@"GetNewsEvents"];
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
        NSString *strTopic = [NSString stringWithFormat:@"%@",[json objectForKey:@"strTopic"]];
        NSString *strTopicBody = [NSString stringWithFormat:@"%@",[json objectForKey:@"strTopicBody"]];
        [sectionArray addObject:strTopic];
        [cellArrayValue addObject:strTopicBody];
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
    return  200;
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
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 10, 300, 44)];
    
    //Background Image
    //UIImageView *headerBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background-tablecell"]];
    //[headerView addSubview:headerBg];
    
    //Button
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(2, 2, 300, 44);
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
    UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 300, 44)];
    [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
    [headerTitle setTextColor:[UIColor whiteColor]];
    [headerTitle setBackgroundColor:[UIColor clearColor]];
    [headerTitle setText:[sectionArray objectAtIndex:section]];
    headerTitle.lineBreakMode = NSLineBreakByWordWrapping;
    headerTitle.numberOfLines = 0;
    [headerView addSubview:headerTitle];
    return  headerView;
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
    //UILabel *cellTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 300, 350)];
    
    UITextView *cellTitle=[[UITextView alloc]initWithFrame:CGRectMake(15, 5, 300, 300)];
    cellTitle.scrollEnabled = NO;
    cellTitle.editable = NO;
    cellTitle.selectable = YES;
    cellTitle.dataDetectorTypes = UIDataDetectorTypeLink;
    
    [cellTitle setBackgroundColor:[UIColor clearColor]];
    [cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [cellTitle setTextColor:[UIColor blackColor]];
    [cellTitle setText:[[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    //cellTitle.lineBreakMode = NSLineBreakByWordWrapping;
    //cellTitle.numberOfLines = 0;
    [cellTitle sizeToFit];
    [cell.contentView addSubview:cellTitle];
    return  cell;
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
