//
//  QuestionListTableViewController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CoreDataHelper.h"
#import "QuestionListTableViewController.h"
#import "Questions.h"
#import "Answers.h"
#import "QuestionDetailController.h"
#import "EditQuestionTitleController.h"
#import "AddQuestionTitleController.h"

@implementation QuestionListTableViewController

@synthesize managedObjectContext, questionListData;

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
    
    //Set editing mod
    [self.tableView setEditing: YES animated: YES];
    self.tableView.allowsSelectionDuringEditing = YES;
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
    [self readDataForTable];
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
  //  return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [questionListData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    Questions *currentCell = [questionListData objectAtIndex:indexPath.row];
    
    NSUInteger answerCount = [currentCell.answer count];
    
    cell.textLabel.text = [currentCell name];
    cell.detailTextLabel.text = [NSString stringWithFormat: @"Answers: %d", answerCount];
    cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
                                 
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (void) DeleteQuestion:(NSUInteger)selectedIndex {
    //Get reference to the table item in our cache array
    Questions *itemToDelete = [self.questionListData objectAtIndex:selectedIndex];
    
    //Delete selected qestion item from db
    [self.managedObjectContext deleteObject:itemToDelete];
    
    //Delete selected qestion item from cache array 
    [questionListData removeObjectAtIndex:selectedIndex];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to remove qestion item with error: %@",[error domain]);
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        deleteIndexPath = indexPath;
        
        UIAlertView *alert = [[UIAlertView alloc] 
                              initWithTitle: @"Delete Question" 
                              message: @"Do you really want to delete this question ?"
                              delegate: self
                              cancelButtonTitle: @"Delete"
                              otherButtonTitles: @"Cancel", nil];
        [alert show];
        
        //[self DeleteQuestion:indexPath.row];
        
        
    }  
}

#pragma mark - Alert View message
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        //do nothing
    }
    else
    {
        [self DeleteQuestion:deleteIndexPath.row];
        
        // Delete the row from the data source
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        [self.tableView reloadData];
    }
}

#pragma mark -

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

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

- (void)readDataForTable
{
    questionListData = [CoreDataHelper getObjectsForEntity:@"Questions" withSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    
    //Table view refresh
    [self.tableView reloadData];
                        
}

-(IBAction)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark - AddQuestionTitleDelegate
- (void)addQuestionTitleDidCancel:(AddQuestionTitleController *)controller
{
  //  do nothing...
}
- (void)addQuestionTitleDidSave:(AddQuestionTitleController *)controller selQuestion:(Questions *) selQuestion;
{
    [self dismissViewControllerAnimated:YES completion:nil];

    [self performSegueWithIdentifier:@"AddedQuestionItem" sender:selQuestion];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {

    
    if ([[segue identifier] isEqualToString:@"EditQuestionItem"]){
        QuestionDetailController *qdc = (QuestionDetailController *)[segue destinationViewController];
        qdc.managedObjectContext = managedObjectContext;
        NSInteger selectedIndex = [[self.tableView indexPathForSelectedRow] row];
        qdc.currentQuestion = [questionListData objectAtIndex:selectedIndex];

    }
    if ([[segue identifier] isEqualToString:@"AddedQuestionItem"]){
        QuestionDetailController *qdc = (QuestionDetailController *)[segue destinationViewController];
        qdc.managedObjectContext = managedObjectContext;
        qdc.currentQuestion = sender;
    } 
    if ([[segue identifier] isEqualToString:@"AddQuestionItem"]){
        UINavigationController *navController = (UINavigationController *)[segue destinationViewController];
        AddQuestionTitleController *aqtc = (AddQuestionTitleController *)[[navController viewControllers] lastObject];
        aqtc.managedObjectContext = managedObjectContext;
        aqtc.delegate = self;
    }
}

@end
