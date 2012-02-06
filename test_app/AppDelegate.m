//
//  AppDelegate.m
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"
#import "QuestionListTableViewController.h"
#import "ViewController.h"

@implementation AppDelegate

@synthesize window = _window;


@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize d1;



- (NSManagedObjectContext *)managedObjectContext {
    if (__managedObjectContext != nil)
    {
        return __managedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

- (NSManagedObjectModel *)managedObjectModel {
    if (__managedObjectModel != nil){
        return __managedObjectModel;
    }
    __managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    return __managedObjectModel;
}
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (__persistentStoreCoordinator != nil) {
        return __persistentStoreCoordinator;
    }
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *basePath = ([paths count] > 0) ? [paths objectAtIndex:0]:nil;
    NSURL *storeUrl = [NSURL fileURLWithPath: [basePath stringByAppendingPathComponent:@"test_app.sqlite"]];
    NSError *error;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if(![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeUrl options:nil error: &error]){
        NSLog(@"Error loading persistant store...");
        abort();
    }
    return __persistentStoreCoordinator;
}

-(void) UploadData {
  /*  Questions* _question1 = (Questions*)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:self.managedObjectContext];
    _question1.name = @"What is the result of 1 + 2 = ?";
   */
     NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    Questions* _question2 = (Questions*)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:managedObjectContext];
    _question2.name = @"What is the result of 2 + 8 = ?";
    Questions* _question3 = (Questions*)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:managedObjectContext];
    _question3.name = @"What is the result of 2 - 2 = ?";
    Questions* _question4 = (Questions*)[NSEntityDescription insertNewObjectForEntityForName:@"Questions" inManagedObjectContext:managedObjectContext];
    _question4.name = @"What is the result of 4 * 3 = ?";
    
    Answers* _answer2_1 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer2_1.name = @"ten";
    _answer2_1.correct = true;
    Answers* _answer2_2 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer2_2.name = @"nine";
    Answers* _answer2_3 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer2_3.name = @"twelve";
    Answers* _answer2_4 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer2_4.name = @"eleven";
    
    Answers* _answer3_1 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer3_1.name = @"zero";
    _answer3_1.correct = true;
    Answers* _answer3_2 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer3_2.name = @"five";
    Answers* _answer3_3 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer3_3.name = @"minus one";
    Answers* _answer3_4 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer3_4.name = @"minus three";
    
    Answers* _answer4_1 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer4_1.name = @"one";
   
    Answers* _answer4_2 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer4_2.name = @"five";
    Answers* _answer4_3 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer4_3.name = @"twelve";
     _answer4_3.correct = true;
    Answers* _answer4_4 = (Answers*)[NSEntityDescription insertNewObjectForEntityForName:@"Answers" inManagedObjectContext:self.managedObjectContext];
    _answer4_4.name = @"seven";
    
    NSError *error = nil;
    
    [_question2 addAnswerObject:_answer2_1];
    [_question2 addAnswerObject:_answer2_2];
    [_question2 addAnswerObject:_answer2_3];
    [_question2 addAnswerObject:_answer2_4];
    
    [_question3 addAnswerObject:_answer3_1];
    [_question3 addAnswerObject:_answer3_2];
    [_question3 addAnswerObject:_answer3_3];
    [_question3 addAnswerObject:_answer3_4];
    
    [_question4 addAnswerObject:_answer4_1];
    [_question4 addAnswerObject:_answer4_2];
    [_question4 addAnswerObject:_answer4_3];
    [_question4 addAnswerObject:_answer4_4];
    
    
    if ([self.managedObjectContext hasChanges]){
        [self.managedObjectContext save:&error];
        if (error){
            NSLog(@"Error on save data %@",[error localizedDescription]);
        }
    }
    
}
-(void) ConsoleOutput {
    NSFetchRequest* _fetchReq = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Questions" inManagedObjectContext:self.managedObjectContext];
    [_fetchReq setEntity:entity];
    NSArray* _questions = [self.managedObjectContext executeFetchRequest:_fetchReq error: nil];
    for (int i = 0; i < [_questions count]; i++)
    {
        Questions* _question = (Questions*)[_questions objectAtIndex:i];
        NSLog(@"_question.name : %@",_question.name);
        
        NSArray* _answers = [_question.answer allObjects];
        for (int j = 0; j < [_answers count];j++){
            Answers* _answer = (Answers*)[_answers objectAtIndex:j];
            NSLog(@"\t_answer.name : %@ correct: %@", _answer.name,(_answer.correct ? @"YES" : @"NO"));
        }
        
    }
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  //  [self UploadData];
    [self ConsoleOutput];
    NSLog(@"LOG0: %@",self.managedObjectContext);
       
   // self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    
    ViewController *rootView = (ViewController *)self.window.rootViewController;
    rootView.manageObjectContext = self.managedObjectContext;
    
    d1 = [[NSMutableDictionary alloc] init];
    [d1 setObject:[NSString stringWithFormat:@"%d", 55] forKey:@"test"];
    
   // self.window.backgroundColor = [UIColor whiteColor];
   // [self.window makeKeyAndVisible];
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    NSError *error = nil;
    if (__managedObjectContext != nil){
        if ([__managedObjectContext hasChanges] && ![__managedObjectContext save:&error]){
            /*
			 Replace this implementation with code to handle the error appropriately.
			 
			 abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
			 */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
