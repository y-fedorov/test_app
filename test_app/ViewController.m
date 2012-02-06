//
//  ViewController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "QuestionListTableViewController.h"
#import "PerformTestTableViewController.h"

@implementation ViewController

@synthesize manageObjectContext;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ManageQestionList"]) 
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        QuestionListTableViewController *qestionListTableViewController = (QuestionListTableViewController *)[[navController viewControllers] lastObject];
        qestionListTableViewController.managedObjectContext = manageObjectContext;
    
    } else if ([[segue identifier] isEqualToString:@"PerformTest"])
    {
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        PerformTestTableViewController *performTestTableViewController = (PerformTestTableViewController *)[[navController viewControllers] lastObject];
        performTestTableViewController.managedObjectContext = manageObjectContext;
        
       /* PerformTestTableViewController *performTestTableViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PerformTestTableViewController"];
        */
       // performTestTableViewController.managedObjectContext = self.manageObjectContext;
        
        
       // [self.navigationController pushViewController:performTestTableViewController animated:YES];
    } else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
