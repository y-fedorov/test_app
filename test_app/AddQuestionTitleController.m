//
//  AddQuestionTitleController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 12/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AddQuestionTitleController.h"


@implementation AddQuestionTitleController

@synthesize managedObjectContext, questionTitle, currentQuestion, delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [questionTitle becomeFirstResponder];
     
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
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark -
- (IBAction)cancelButtonPressed {
    [self dismissModalViewControllerAnimated:YES];
    [self.delegate addQuestionTitleDidCancel:self];
}
- (IBAction)editSaveButtonPressed:(id)sender
{
    Questions *newQuestion = (Questions *)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:self.managedObjectContext];
    
    newQuestion.name = questionTitle.text;
    currentQuestion = newQuestion;
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add new question item with error: %@",[error domain]);
    
    [self.delegate addQuestionTitleDidSave:self selQuestion:currentQuestion];
 //  [self performSegueWithIdentifier:@"EditAnswerSegue" sender:nil];
   
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
/*    
    if ([[segue identifier] isEqualToString:@"EditQuestionItem"]){
        QuestionDetailController *qdc = (QuestionDetailController *)[segue destinationViewController];
        qdc.managedObjectContext = managedObjectContext;
        qdc.currentQuestion = currentQuestion;
     //   [self presentModalViewController:controller animated:YES]; 
    }
 */
}


@end
