//
//  AddQuestionTitleController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 12/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"
#import "QuestionDetailController.h"

@class AddQuestionTitleController;

@protocol AddQuestionTitleDelegate <NSObject>

- (void)addQuestionTitleDidCancel:(AddQuestionTitleController *)controller;
- (void)addQuestionTitleDidSave:(AddQuestionTitleController *)controller selQuestion:(Questions *) selQuestion;

@end

@interface AddQuestionTitleController : UITableViewController
@property (strong, nonatomic) Questions *currentQuestion;

@property (strong, nonatomic) IBOutlet UITextField *questionTitle;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@property(nonatomic, weak) id <AddQuestionTitleDelegate> delegate;

//Methods and Actions 
- (IBAction)editSaveButtonPressed:(id)sender;
- (IBAction)cancelButtonPressed;

@end
