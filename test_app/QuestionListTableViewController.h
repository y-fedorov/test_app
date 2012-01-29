//
//  QuestionListTableViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Answers.h"
#import "Questions.h"
#import "AppDelegate.h"

@class Questions;
@class Answers;

@interface QuestionListTableViewController : UITableViewController
{
   // @private
        NSFetchedResultsController *fetchedResultsController;
        NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;


@end
