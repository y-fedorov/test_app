//
//  QuestionListTableViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 02/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuestionListTableViewController : UITableViewController

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSMutableArray *questionListData;

- (void)readDataForTable;
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender;
@end
