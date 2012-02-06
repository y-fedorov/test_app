//
//  EditQuestionTitleController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 04/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EditQuestionTitleController.h"
#import "CoreDataHelper.h"


@implementation EditQuestionTitleController

@synthesize currentQuestion, currentAnswer, answerTitle, managedObjectContext;


- (IBAction)editSaveButtonPressed:(id)sender {
  
    if (!currentAnswer){
        self.currentAnswer = (Answers *)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
        if ([currentQuestion.answer count] == 0){
            self.currentAnswer.correct = true;
        } else {
            self.currentAnswer.correct = false;
        }
        self.currentAnswer.name = answerTitle.text;
        
        [self.currentQuestion addAnswerObject:currentAnswer];
    } else {
        self.currentAnswer.name = answerTitle.text;
    }
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add new question item with error: %@",[error domain]);
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


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


    self.navigationItem.title = @"Edit Answer"; 
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    self.answerTitle = nil;
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    
    static NSString *AnswerCellIdentifier = @"AnswerCell";
    cell = [tableView dequeueReusableCellWithIdentifier:AnswerCellIdentifier];
    if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswerCellIdentifier]; 
        cell.accessoryType = UITableViewCellAccessoryNone;
        
        answerTitle = [[UITextField alloc] initWithFrame:CGRectMake(5,10,290,34)];
        answerTitle.tag = 1;
        [cell.contentView addSubview:answerTitle];
    }
    answerTitle = (UITextField *)[cell viewWithTag:1];
    answerTitle.text = [currentAnswer name];
    answerTitle.borderStyle = UITextBorderStyleNone;
   
    if ([currentAnswer correct] == YES){
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.editingAccessoryType = UITableViewCellAccessoryCheckmark;
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    //NSString *title = nil;
    // Return a title or nil as appropriate for the section.

    return @"Answer title:";
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
}

@end
