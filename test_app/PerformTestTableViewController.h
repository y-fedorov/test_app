//
//  PerformTestTableViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "Answers.h"
#import "TestResultsViewController.h"

@interface PerformTestTableViewController : UITableViewController <UINavigationControllerDelegate>  {
    @private
        NSDate* startTime;
    
        NSInteger currentQuestionIndex;
        NSInteger correctAnwers;
        NSInteger unansweredQuestions;
        NSInteger uncorrectAnswers;
        TestResultsViewController *testresults;
    
}
@property (strong, nonatomic) Questions *currentQuestion;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *questionListData;
@property (strong, nonatomic) NSMutableArray *answerListData;

- (void)readDataForTable;
- (void)nextQuestion;
- (void)finishTest;
- (void)startTest;
- (void)readDataForAnswersTable;
- (void)skipQuestion;
- (IBAction)skipQuestionBtn:(id)sender;
- (IBAction)finishTestBtn:(id)sender;
- (IBAction)restartTestBtn:(id)sender;
- (IBAction)cancelPressed;


@end
