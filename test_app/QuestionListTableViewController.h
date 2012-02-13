//
//  QuestionListTableViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddQuestionTitleController.h"

@interface QuestionListTableViewController : UITableViewController <AddQuestionTitleDelegate, UIAlertViewDelegate> {
    NSIndexPath *deleteIndexPath;
}

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *questionListData;

- (void)readDataForTable;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
- (IBAction)cancelPressed;
- (void) DeleteQuestion:(NSUInteger)selectedIndex;
@end
