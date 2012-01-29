//
//  AppDelegate.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Answers.h"
#import "Questions.h"
#import "QuestionListTableViewController.h"

@class QuestionListTableViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>
{
    NSManagedObjectModel *managedObjectModel;
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
    NSManagedObjectContext *managedObjectContext;
    
    QuestionListTableViewController *questionListTableViewController;
    
    UIWindow *window; 
    UINavigationController *navigationController; 
}

@property (nonatomic, retain) IBOutlet QuestionListTableViewController *questionListTableViewController;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigationController;  

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

-(void) UploadData;
-(void) ConsoleOutput;

@end
