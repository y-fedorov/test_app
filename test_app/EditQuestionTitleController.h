//
//  EditQuestionTitleController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 04/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "Answers.h"

@interface EditQuestionTitleController : UITableViewController <UINavigationControllerDelegate>

@property (strong, nonatomic) Questions *currentQuestion;
@property (strong, nonatomic) Answers *currentAnswer;



@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *answerTitle;
//@property (strong, nonatomic) IBOutlet UISwitch *AnswerDefaultSwitch;
- (IBAction)editSaveButtonPressed:(id)sender;


@end
