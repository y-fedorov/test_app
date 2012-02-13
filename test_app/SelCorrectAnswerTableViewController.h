//
//  SelCorrectAnswerTableViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 12/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answers.h"
@class SelCorrectAnswerTableViewController;

@protocol SelCorrectAnswersDelegate <NSObject>
- (void)selCorrectAnswersViewController:(SelCorrectAnswerTableViewController *)controller didSelectAnswer:(NSString *)answer;
@end

@interface SelCorrectAnswerTableViewController : UITableViewController

@property (nonatomic, weak) id <SelCorrectAnswersDelegate> delegate;

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

//AnswerList Data
@property (strong, nonatomic) NSMutableArray *answerListData;

@end
