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

/*
//delegate to return amount entered by the user
@protocol EnterAnswerTitleDelegate <NSObject>

-(void)answerTitleEntered:(NSString *)answer_title answer_n:(NSInteger)answer_n;

@end
*/
@interface EditQuestionTitleController : UITableViewController <UINavigationControllerDelegate>{
  //  id<EnterAnswerTitleDelegate> delegate;
    
}

//@property (nonatomic, strong) id delegate;


@property (strong, nonatomic) Questions *currentQuestion;
@property (strong, nonatomic) Answers *currentAnswer;


@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) IBOutlet UITextField *answerTitle;
//@property (strong, nonatomic) IBOutlet UISwitch *AnswerDefaultSwitch;
- (IBAction)editSaveButtonPressed:(id)sender;

//-(IBAction)cancelPressed;
//-(IBAction)savePressed;

@end
