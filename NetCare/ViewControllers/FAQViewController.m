//
//  FAQViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "FAQViewController.h"
#import "PKRevealController.h"

@interface FAQViewController ()

@end

@implementation FAQViewController
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
    
    self.title = @"FAQ's";
    
    UIImage *revealImagePortrait = [UIImage imageNamed:@"ico_menu_sm"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
    
    
    sectionArray=[[NSMutableArray alloc]initWithObjects:
                  @"Can I cancel or enroll in a Dental or Vision Plan at any time?",
                  @"Can I cover my parents if they rely on me for support?",
                  @"Do I need a referral for labs, x-rays and annual eye exams?",
                  @"Do I need a referral for medical treatment off-island?",
                  @"Do I need a referral to see a Specialist?",
                  nil];
    
    
    NSMutableArray *cellArrayValue=[[NSMutableArray alloc]initWithObjects:
                                    @"You may enroll in a Dental or Vision Plan during your initial eligibility period (after you pass your company probationary period) or during the annual open enrollment period of your group.  Once enrolled in a Dental or Vision Plan, you may only cancel during the annual open enrollment period of your group or upon termination of employment.",
                                    @"No. Parents are not considered eligible dependents.",
                                    @"No. Referrals are not required for labs, x-rays, annual eye exams performed by an Optometrist (for refraction/eye glasses/contact lenses).",
                                    @"This would depend on the type of Plan you are enrolled under. Please call our customer service department for assistance as some Plans require an approved referral from NetCare before accessing medical providers off-island.",
                                    @"If you are enrolled under the Advantage Plan, you must have a referral to see a Specialist outside of Guam. On Guam you may self-refer to a participating Specialist. \n\nIf you are enrolled under the Continental or Kmart HMO Plan, you must have a referral to see a Specialist both on and outside of Guam.",
                                    nil];
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
    UIView *headerView=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 44)];
    
    //Background Image
    UIImageView *headerBg=[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"background-tablecell"]];
    [headerView addSubview:headerBg];
    
    //Button
    UIButton *button=[UIButton buttonWithType:UIButtonTypeCustom];
    button.frame=CGRectMake(2, 2, 280, 44);
    button.tag=section+1;
    [button addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    //[button setImage:[UIImage imageNamed:@"shrink.png"] forState:UIControlStateNormal];
    [button setImage:[UIImage imageNamed:@"disclosure.png"] forState:UIControlStateSelected];
    if([[cellCount objectAtIndex:section] intValue]==0)
        button.selected=YES;
    else
        button.selected=NO;
    [headerView addSubview:button];
    
    //Label
    UILabel *headerTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 2, 280, 44)];
    //[headerTitle setFont:[UIFont fontWithName:@"DINBDA" size:50]];
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
    UILabel *cellTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 10, 280, 500)];
    [cellTitle setBackgroundColor:[UIColor clearColor]];
    [cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:14]];
    [cellTitle setTextColor:[UIColor blackColor]];
    [cellTitle setText:[[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
    cellTitle.lineBreakMode = NSLineBreakByWordWrapping;
    cellTitle.numberOfLines = 0;
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
        [cellCount replaceObjectAtIndex:_index withObject:[NSNumber numberWithInt:[[cellArray objectAtIndex:_index]count]]];
    [MIMtableView reloadData];
}

-(IBAction)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}




@end
