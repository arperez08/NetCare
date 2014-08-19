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
    [self.navigationController setNavigationBarHidden:YES animated:YES];
      
    
    sectionArray=[[NSMutableArray alloc]initWithObjects:
                  @"Can I cancel or enroll in a Dental or Vision Plan at any time?",
                  @"Can I cover my parents if they rely on me for support?",
                  @"Do I need a referral for labs, x-rays and annual eye exams?",
                  @"Do I need a referral for medical treatment off-island?",
                  @"Do I need a referral to see a Specialist?",
                  @"Do I need to notify NetCare if I am going off-island?",
                  @"How can I determine if a doctor or hospital is a participating provider?",
                  @"How can I file a request for reimbursement?",
                  @"I received a statement in the mail. How do I know if NetCare paid my claim(s)",
                  @"Up to what age may I cover my dependent children?",
                  @"What do I do if I have a baby and would like to add the baby to my health insurance?",
                  @"What do I do if I have an emergency (on or off-island)?",
                  @"What do I do if my name or address changes?",
                  @"What if my Membership I.D. Card is lost or stolen?",
                  @"What is a pre-certification and when is one required?",
                  @"When will I receive my Membership I.D. Card?",
                  @"Will NetCare pay for my airfare for off-island medical treatment?",
                  @"Do I need to choose a Primary Care Physician (PCP)?",
                  nil];
    
    
    NSMutableArray *cellArrayValue=[[NSMutableArray alloc]initWithObjects:
                                    @"You may enroll in a Dental or Vision Plan during your initial eligibility period (after you pass your company probationary period) or during the annual open enrollment period of your group.  Once enrolled in a Dental or Vision Plan, you may only cancel during the annual open enrollment period of your group or upon termination of employment.",
                                    @"No. Parents are not considered eligible dependents.",
                                    @"No. Referrals are not required for labs, x-rays, annual eye exams performed by an Optometrist (for refraction/eye glasses/contact lenses).",
                                    @"This would depend on the type of Plan you are enrolled under. Please call our customer service department for assistance as some Plans require an approved referral from NetCare before accessing medical providers off-island.",
                                    @"If you are enrolled under the Advantage Plan, you must have a referral to see a Specialist outside of Guam. On Guam you may self-refer to a participating Specialist. \n\nIf you are enrolled under the Continental or Kmart HMO Plan, you must have a referral to see a Specialist both on and outside of Guam.",
                                    @"NetCare’s residency requirement stipulates that members must reside within the service area for a minimum of 9 months out of the contract period. If you are moving outside of your service area, you can not continue to be covered under the policy. If you are off-island for medical treatment, your treatment will be covered for a maximum of 90 days.\n\nIf you elect COBRA coverage and you are moving off-island, you will be covered for a maximum of 90 days.",
                                    @"You may request a copy of our printed Participating Healthcare Provider Directory, or you may view our list of participating providers on this website. To locate a participating provider in Micronesia, Philippines, Asia, Hawaii and the Continental United States, please:\n\nCall our customer service department at (671) 472-3610\nLog on to www.firsthealth.com to locate participating medical providers in the Continental United States (does not apply to providers in Hawaii)\nLog on to www.prescriptionsolutions.com to view participating pharmacy providers in the Continental United States and Hawaii.",
                                    @"You must complete a request for reimbursement form and submit all supporting documents including a claim form completed by your physician’s office and original receipts showing proof of payment. All non-English claims must be translated into English (detailed, indicating all services rendered). Requests for reimbursement for prescription drugs must include the label issued by the pharmacy and medical notes.\n\nDental claims must include a claim form (or detailed medical notes and tooth chart if services were rendered in the Philippines). Claims must be submitted to the NetCare office within 90 days of the date of service with all required documents. NetCare will not request documents for members. Reimbursements will be paid within 45 business days.",
                                    @"You can view your paid claims on the NetCare website. Click on'Member', 'Member' again, then you will be asked to enter or create your ‘User Name’ and ‘Password’. Once in your eligibility screen you can view your paid claims.",
                                    @" \u2022Eligible children may be covered up to age 25.\n \u2022Eligible children ages 19 - 25 who reside outside the service area for secondary schooling may be covered up to the attainment of age 25. A Student Verification must be submitted every semester to maintain coverage outside the service area.\n \u2022If you have been granted legal guardianship of a minor child, that child may be covered up to the attainment of age 18.\n \u2022Eligible children who have been certified as disabled by a physician may be covered past the age of 19.",
                                    @"A newborn baby is NOT automatically added to your policy. You will need to submit a Change of Status Form along with a copy of the Birth Certificate (from the hospital or from Public Health) to your Human Resources office as soon as possible, but no later than 30 days from the baby’s date of birth. ",
                                    @"Please proceed to the nearest hospital emergency room or urgent care center. Bonafied emergencies (the sudden and unexpected onset of a severe medical condition, which if not treated immediately would be life threatening or result in permanent disability) are covered at any medical facility (subject to the emergency co-payment and limitations of your Plan). ",
                                    @"You will need to submit a Change of Status From (and supporting documentation for name changes such as a Marriage Certificate) to your Human Resources Office. Once NetCare has received a copy of the Change of Status Form we will update your information in our system. It is very important to keep NetCare informed of any address changes as periodically we mail important information to members about their health benefits.",
                                    @"Please call the NetCare customer service department to request replacement cards. You will be charged $2.00 per card.",
                                    @"Pre-certification is the review and approval process by NetCare for certain procedures. The following procedures require pre-certification from NetCare:\n \u2022Inpatient confinements\n \u2022Skilled Nursing Admissions\n \u2022Outpatient elective surgery, including circumcision and sterilization procedures\n \u2022Major Diagnostic Procedures such as MRI, CT Scan, Ultrasound, Cardiac Catheterization, Cardiac Angioplasty, Cardiac Stress Test, Biopsy, Bone Scan, etc.\n \u2022Home Health Care\n \u2022Durable Medical Equipment",
                                    @"You should receive your NetCare Membership I.D. card within 10 working days from the date your Enrollment or Change of Status Form was submitted. If you have not received your card, please call the NetCare customer service department at 472-3610. ",
                                    @"ou may qualify for the NetCare airfare benefit if you meet the following criteria:\n \u2022You must have a written referral from a participating physician and subsequent approval from NetCare\n \u2022The referral must be for a procedure meeting the criteria as set forth by NetCare. Procedures that may qualify for airfare include: Cardiac Surgery, Cardiac Catheterization, Cardiac Angioplasty, Cancer Surgery, Neurosurgery, Gamma Knife Surgery and Radiation Therapy. (Subject to Plan review).\n \u2022Treatment/services are rendered at a designated NetCare Center of Care, including: St. Luke's Medical Center, Makati Medical Center, Philippine Heart Center and The Medical City Medical Center in the Philippines, or Anaheim Memorial Medical Center, Good Samaritan Hospital or White Memorial Medical Center in Los Angeles, California.\n \u2022Group Premium payments must be current",
                                    @"This would depend on the type of Plan you are enrolled under. If you are enrolled under the Advantage Plan, Continental HMO Plan or Kmart HMO Plan, you are required to choose a primary care physician for each family member enrolled in the Plan. You may change your PCP by calling the NetCare customer service department at (671) 472-3610. You may also email your request to tvillagomez@netcarelifeandhealth.com or vfarnum@netcarelifeandhealth.com. (Please include your daytime contact number in the email.",
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
        [headerTitle setFont:[UIFont fontWithName:@"Helvetica-Bold" size:14]];
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
        UILabel *cellTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 280, 350)];
        [cellTitle setBackgroundColor:[UIColor clearColor]];
        [cellTitle setFont:[UIFont fontWithName:@"Helvetica" size:12]];
        [cellTitle setTextColor:[UIColor blackColor]];
        [cellTitle setText:[[cellArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row]];
        cellTitle.lineBreakMode = NSLineBreakByWordWrapping;
        cellTitle.numberOfLines = 0;
        [cellTitle sizeToFit];
        [cell.contentView addSubview:cellTitle];
        return  cell;
    }
    else{
        UILabel *cellTitle=[[UILabel alloc]initWithFrame:CGRectMake(15, 5, 700, 350)];
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

-(IBAction)btnBack:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnShowMenu:(id)sender {
    [self showLeftView:sender];
}


@end
