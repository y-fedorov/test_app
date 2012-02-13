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
#import "CoreDataHelper.h"

@implementation ViewController

@synthesize manageObjectContext, performtest;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (void)checkCountQuestion {
    NSMutableArray *questionListData = (NSMutableArray *)[CoreDataHelper getObjectsForEntity:@"Questions" withSortKey:nil andSortAscending:YES andContext:self.manageObjectContext];
    
    if ([questionListData count] == 0) {
      //  [self.performtest setEnabled:NO];
        [self.performtest setHidden:YES];
    } else {
        ///[self.performtest setEnabled:YES];
        [self.performtest setHidden:NO];
    }
    
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
    [self checkCountQuestion];
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
       

    } else
    {
        [super prepareForSegue:segue sender:sender];
    }
}

@end
