//
//  AppDelegate.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "Questions.h"
#import "Answers.h"

#import "ViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate> {
    NSMutableDictionary *d1;
}


@property (strong, nonatomic) UIWindow *window;

@property (readonly, nonatomic, strong) NSManagedObjectModel *managedObjectModel;
@property (readonly, nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (readonly, nonatomic, strong) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (retain, nonatomic) NSMutableDictionary *d1;

-(void) UploadData;
-(void) ConsoleOutput;

@end
