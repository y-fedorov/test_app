//
//  QuestionDetailController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "QuestionDetailController.h"
#import "CoreDataHelper.h"
#import "EditQuestionTitleController.h"
#import "SelCorrectAnswerTableViewController.h"

@implementation QuestionDetailController

@synthesize managedObjectContext, currentQuestion, questionTitle, answerListData;

#define QUESTION_TITLE 0
#define ANSWERS_SECTION 1
#define CORRECT_SELECTION 2

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView
{
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    questionTitle.placeholder = @"Type your question text here...";
    if (currentQuestion){
        [questionTitle setText:[currentQuestion name]];
    }
    
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
    [self readDataForAnswersTable];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)editSaveButtonPressed:(id)sender {
    [self SaveCurrentQuestion];
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (void)SaveCurrentQuestion{
    if (!currentQuestion)
        self.currentQuestion = (Questions *)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:self.managedObjectContext];
    [self.currentQuestion setName:[questionTitle text]];
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to add new question item with error: %@",[error domain]);
}
- (void)DeleteAnswer: (NSUInteger)answerIndex{
    //Get reference for the answer
    Answers *answerToDelete = [self.answerListData objectAtIndex:answerIndex];
    
    //Remove from db
    [self.managedObjectContext deleteObject:answerToDelete];
    
    //Remove from data array 
    [answerListData removeObjectAtIndex:answerIndex];
    
    if (answerToDelete.correct){
        if ([answerListData count] > 0){
            [[answerListData objectAtIndex:0] setCorrect:YES];
        }
    }
    
    
    NSError *error = nil;
    if (![self.managedObjectContext save:&error])
        NSLog(@"Failed to remove answer item with error: %@", [error domain]);

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    [textField setUserInteractionEnabled:YES];
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)textFieldDidEndEditing:(UITextField *)textField{
	[self SaveCurrentQuestion];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 0;
    
    
    // The number of rows depends on the section.
    // In the case of ingredients, if editing, add a row in editing mode to present an "Add //Ingredient" cell.
	 
    switch (section) {
        case QUESTION_TITLE:
            rows = 1;
            break;
        case ANSWERS_SECTION:
            rows = [currentQuestion.answer count];
            
            // Add ones more for "Add answer row"
            rows++;
            break;
        case CORRECT_SELECTION:
            rows = 1;
            break;
		default:
            break;
    }
    return rows;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = nil;
    
    // For the Answers section, if necessary create a new cell and configure it with an additional label for the amount.  Give the cell a different identifier from that used for cells in other sections so that it can be dequeued separately.
    if (indexPath.section == ANSWERS_SECTION) {
		NSUInteger answersCount = [currentQuestion.answer count];
        NSInteger row = indexPath.row;
		
        if (indexPath.row < answersCount) {
            // If the row is within the range of the number of answers for the current recipe, then configure the cell to show the ingredient name and amount.
			static NSString *AnswersCellIdentifier = @"AnswersCell";
			
			cell = [tableView dequeueReusableCellWithIdentifier:AnswersCellIdentifier];
			
			if (cell == nil) {
                // Create a cell to display an answer.
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AnswersCellIdentifier];
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
			
           // Answers *currAnswer = [answerListData objectAtIndex:row];
            cell.textLabel.text = [[answerListData objectAtIndex:row] name];
           // cell.textLabel.text = currAnswer.name;
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            cell.editingAccessoryType = UITableViewCellAccessoryNone;
            if ([[answerListData objectAtIndex:row] correct] == YES){
                cell.accessoryType = UITableViewCellAccessoryCheckmark;
                cell.editingAccessoryType = UITableViewCellAccessoryCheckmark; 
            }

        } else {
            // If the row is outside the range, it's the row that was added to allow insertion (see tableView:numberOfRowsInSection:) so give it an appropriate label.
			static NSString *AddAnswerCellIdentifier = @"AddAnswerCell";
			
			cell = [tableView dequeueReusableCellWithIdentifier:AddAnswerCellIdentifier];
			if (cell == nil) {
                // Create a cell to display "Add Answer".
				cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AddAnswerCellIdentifier];
				cell.accessoryType = UITableViewCellAccessoryNone;
			}
            
            cell.textLabel.text = @"Add Answer";
        }
    } else if (indexPath.section == QUESTION_TITLE) {
        
        static NSString *CellIdentifier = @"QestionTitleCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
            
            questionTitle = [[UITextField alloc] initWithFrame:CGRectMake(5, 10, 254, 34)];
            questionTitle.tag = 1;
            [cell.contentView addSubview:questionTitle];
        } 
        questionTitle.delegate = self;
    //    theTextField.keyboardType = UIKeyboardTypeDefault;
     //   theTextField.returnKeyType = UIReturnKeyDone;
        
        questionTitle.returnKeyType = UIReturnKeyDone;
        questionTitle = (UITextField *)[cell viewWithTag:1];
        questionTitle.text = [currentQuestion valueForKey:@"name"];
        questionTitle.borderStyle = UITextBorderStyleNone;
        
        
    } else if (indexPath.section == CORRECT_SELECTION){
        static NSString *CellIdentifier = @"CorrectSelectionCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
          //  cell.accessoryType = UITableViewCellAccessoryNone;
        }
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.editingAccessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        for (int i = 0; i < [answerListData count]; i++) {
            if ([[answerListData objectAtIndex:i] correct])
            {
                cell.textLabel.text = [[answerListData objectAtIndex:i] name];
                break;
            }
        }
        
        
    } else {
        static NSString *CellIdentifier = @"GenericCell";
        
        cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            cell.accessoryType = UITableViewCellAccessoryNone;
        }
    
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        if ([[answerListData objectAtIndex:indexPath.row] correct] == YES){
            deleteIndexPath = indexPath;
            
            UIAlertView *alert = [[UIAlertView alloc] 
                                  initWithTitle: @"Delete current Answer" 
                                  message:  [NSString stringWithFormat:@"Do you really want to delete correct answer: “%@”, ?", [[answerListData objectAtIndex:indexPath.row] name]]
                                  delegate: self
                                  cancelButtonTitle: @"Delete"
                                  
                                  otherButtonTitles: @"Cancel", nil];
            [alert show];
        } else {
            [self DeleteAnswer:indexPath.row];
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];

        }
       // [tableView reloadData];
    }
    if (editingStyle == UITableViewCellEditingStyleInsert) {
        [self performSegueWithIdentifier:@"EditAnswerSegue" sender:nil];
    }
    
}


- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCellEditingStyle style = UITableViewCellEditingStyleNone;
    // Only allow editing in the ingredients section.
    // In the ingredients section, the last row (row number equal to the count of ingredients) is added automatically (see tableView:cellForRowAtIndexPath:) to provide an insertion cell, so configure that cell for insertion; the other cells are configured for deletion.
    if (indexPath.section == ANSWERS_SECTION) {
        // If this is the last item, it's the insertion row.
        if (indexPath.row == [currentQuestion.answer count]) {
            style = UITableViewCellEditingStyleInsert;
        }
        else {
            style = UITableViewCellEditingStyleDelete;
        }
    }
    
    return style;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *title = nil;
    // Return a title or nil as appropriate for the section.
    switch (section) {
        case QUESTION_TITLE:
            title = @"Qestion title:";
            break;
        case ANSWERS_SECTION:
            title = @"Answers:";
            break;
        case CORRECT_SELECTION:
            title = @"Correct answer:";
        default:
            break;
    }
    return title;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSInteger section = indexPath.section;

    switch (section) {
        case QUESTION_TITLE:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
                        
            break;
			
        case ANSWERS_SECTION:
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            if (indexPath.row < [currentQuestion.answer count]){
                [self performSegueWithIdentifier:@"EditAnswerSegue" sender:[self.answerListData objectAtIndex:indexPath.row]];
            } else {
                [self performSegueWithIdentifier:@"EditAnswerSegue" sender:nil];
            }
            
            break;
        case CORRECT_SELECTION:
                [self performSegueWithIdentifier:@"ChooseCorrectAnswerSegue" sender:nil];
            break;
            
        default:
            break;
    }      
}

#pragma mark - Alert View message
- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    // the user clicked one of the OK/Cancel buttons
    if (buttonIndex == 1)
    {
        // do nothing
    }
    else
    {
        [self DeleteAnswer:deleteIndexPath.row];
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:deleteIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        [self.tableView reloadData];
    }
}

#pragma mark -


- (void) readDataForAnswersTable {

    //filling array of answers
    self.answerListData = [[NSMutableArray alloc] initWithArray:[currentQuestion.answer allObjects]];
    
    //Table refresh
    [self.tableView reloadData];
}

- (void)selCorrectAnswersViewController:(SelCorrectAnswerTableViewController *)controller didSelectAnswer:(NSString *)answer {
   // delegate for selected correct question
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"EditAnswerSegue"]){
        EditQuestionTitleController *controller = (EditQuestionTitleController *)[segue destinationViewController];
        controller.managedObjectContext = managedObjectContext;
        controller.currentQuestion = self.currentQuestion;
        controller.currentAnswer = sender;
    }
    if ([[segue identifier] isEqualToString:@"ChooseCorrectAnswerSegue"]){
        SelCorrectAnswerTableViewController *controller = (SelCorrectAnswerTableViewController *)[segue destinationViewController];
        controller.managedObjectContext = managedObjectContext;
        controller.answerListData = answerListData;
        controller.delegate = self;
    }
}

@end
