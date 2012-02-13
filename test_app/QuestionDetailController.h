//
//  QuestionDetailController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 03/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "Answers.h"
#import "EditQuestionTitleController.h"
#import "SelCorrectAnswerTableViewController.h"

@interface QuestionDetailController : UITableViewController <UINavigationControllerDelegate, UITableViewDelegate, UITextFieldDelegate, SelCorrectAnswersDelegate, UIAlertViewDelegate /*EnterAnswerTitleDelegate*/>{
    NSIndexPath *deleteIndexPath;
}

@property (strong, nonatomic) Questions *currentQuestion;

//AnswerList Data
@property (strong, nonatomic) NSMutableArray *answerListData;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *questionTitle;
- (IBAction)editSaveButtonPressed:(id)sender;
- (void)readDataForAnswersTable;
- (void)SaveCurrentQuestion;
- (void)DeleteAnswer: (NSUInteger)answerIndex;
//-(void)EnterAnswerTitleDelegate:(NSString*)answer;


@end
