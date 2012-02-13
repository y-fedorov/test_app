//
//  PerformTestTableViewController.m
//  test_app
//
//  Created by Yaroslav Fedorov on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PerformTestTableViewController.h"
#import "CoreDataHelper.h"
#import "TestResultsViewController.h"
#import "AppDelegate.h"

@implementation PerformTestTableViewController

@synthesize managedObjectContext, questionListData, answerListData, currentQuestion;

#define QUESTION_TITLE 0
#define ANSWERS_SECTION 1

- (void)updateTitle {
    [self.navigationItem setTitle:[NSString stringWithFormat:@"( %d / %d )",currentQuestionIndex+1,[questionListData count]]];
}

- (void)nextQuestion {
    currentQuestionIndex++;
    currentQuestion = [questionListData objectAtIndex:currentQuestionIndex];
    [self readDataForAnswersTable];
    [self.tableView reloadData];
    [self updateTitle];
}

- (void)finishTest {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSMutableDictionary *dic = (NSMutableDictionary *)appDelegate.d1;
    

    NSTimeInterval todaysDiff = -[startTime timeIntervalSinceNow];

    div_t h = div(todaysDiff, 3600);
    int hours = h.quot;
    
    div_t m = div(h.rem, 60);
    int minutes = m.quot;
    int seconds = m.rem;
    NSLog(@"%d:%d:%d", hours, minutes, seconds);
    NSString *string = [NSString stringWithFormat:@"%02li:%02li:%02li",hours,minutes,seconds];
    
    [dic setObject:[NSString stringWithFormat:@"%d", unansweredQuestions] forKey:@"unansweredQuestions"];
    [dic setObject:[NSString stringWithFormat:@"%d", uncorrectAnswers] forKey:@"uncorrectAnswers"];
    [dic setObject:[NSString stringWithFormat:@"%d", correctAnwers] forKey:@"correctAnwers"];
    [dic setObject:[NSString stringWithFormat:@"%@", string] forKey:@"testingTime"];

     
    testresults = [self.storyboard instantiateViewControllerWithIdentifier:@"TestResultsController"];
    [self.navigationController pushViewController:testresults animated:YES];

}

- (void)startTest {
    correctAnwers = 0;
    unansweredQuestions = 0;
    uncorrectAnswers = 0;
    
    currentQuestionIndex = 0;
    [self readDataForTable];
    currentQuestion = [questionListData objectAtIndex:currentQuestionIndex];
    [self readDataForAnswersTable];
    [self updateTitle];
    startTime = [NSDate date];
    [self.tableView reloadData];
}

- (void)skipQuestion {
    unansweredQuestions++;
    if (currentQuestionIndex < ([questionListData count]-1)){
        [self nextQuestion];
    } else {
        [self finishTest];
    }
}
- (IBAction)skipQuestionBtn:(id)sender {
    [self skipQuestion];
}

- (IBAction)finishTestBtn:(id)sender {
    [self finishTest]; 
}
- (IBAction)restartTestBtn:(id)sender {
    [self startTest];
    [self.tableView reloadData];
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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
   // [self.navigationItem setLeftItemsSupplementBackButton:YES];
    
    
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
    
    
    [self startTest]; 
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger rows = 0;
    
    switch (section) {
        case QUESTION_TITLE:
            rows = 1;
            break;
        case ANSWERS_SECTION:
            rows = [currentQuestion.answer count];
            break;
        default:
            break;
    }

    
    // Return the number of rows in the section.
    return rows;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    if (indexPath.section == QUESTION_TITLE){
        cell.textLabel.text = [currentQuestion name];
    } else if (indexPath.section == ANSWERS_SECTION){
      
        Answers *currAnswer = [answerListData objectAtIndex:indexPath.row];
        cell.textLabel.text = currAnswer.name;
    } else {
        
    }
    
    // Configure the cell...
    
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

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

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

#pragma mark - Work with data

- (void)readDataForTable {
    questionListData = [CoreDataHelper getObjectsForEntity:@"Questions" withSortKey:nil andSortAscending:YES andContext:self.managedObjectContext];
    
}




- (void)readDataForAnswersTable {
    answerListData = [[NSMutableArray alloc] initWithArray:[currentQuestion.answer allObjects]];
    
   // [self.tableView reloadData];
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    switch (indexPath.section) {
        case ANSWERS_SECTION:
            if (currentQuestionIndex < ([questionListData count]-1)){
                    
                Answers *currAnswer = [answerListData objectAtIndex:indexPath.row];
                //WARN! Error!
                if (currAnswer.correct == YES){
                    correctAnwers++;
                } else {
                    uncorrectAnswers++;
                }
                [self nextQuestion];
                
            } else {
                [self finishTest];
            }
            break;
            
        default:
            break;
    }
    
}

-(IBAction)cancelPressed {
    [self dismissModalViewControllerAnimated:YES];
}

@end
