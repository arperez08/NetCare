//
//  ProductListingViewController.m
//  NetCare
//
//  Created by MacTwo Moylan on 7/2/14.
//  Copyright (c) 2014 NetCare. All rights reserved.
//

#import "ProductListingViewController.h"
#import "PKRevealController.h"

@interface ProductListingViewController () <UIDocumentInteractionControllerDelegate>

@end

@implementation ProductListingViewController
@synthesize controller;

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
    
    UIImage *revealImagePortrait = [UIImage imageNamed:@"ico_menu_sm"];
    if (self.navigationController.revealController.type & PKRevealControllerTypeLeft)
    {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:revealImagePortrait landscapeImagePhone:nil style:UIBarButtonItemStylePlain target:self action:@selector(showLeftView:)];
    }
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) openPDFbyURL:(NSString *)pdfURL {

    
}

- (IBAction)openPDF:(id)sender {
    NSURL *URL = [[NSBundle mainBundle] URLForResource:@"MobileHIG" withExtension:@"pdf"];
    if (URL) {
        self.controller = [UIDocumentInteractionController interactionControllerWithURL:URL];
        self.controller.delegate = self;
        
        // Present "Open In Menu"
        [self.controller presentOpenInMenuFromRect:[sender frame] inView:self.view animated:YES];
    }
}

@end
