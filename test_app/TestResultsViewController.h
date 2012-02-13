//
//  TestResultsViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 05/02/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TestResultsViewController : UIViewController <UINavigationControllerDelegate>


@property (nonatomic, retain) IBOutlet UILabel *unansweredQuestions;
@property (nonatomic, retain) IBOutlet UILabel *uncorrectAnswers;
@property (nonatomic, retain) IBOutlet UILabel *correctAnswers;
@property (nonatomic, retain) IBOutlet UILabel *testingTime;
-(IBAction)cancelPressed;
@end
