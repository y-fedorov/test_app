//
//  ViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questions.h"

@interface ViewController : UIViewController <UIAlertViewDelegate>

@property (strong, nonatomic) NSManagedObjectContext *manageObjectContext;
@property (nonatomic, retain) IBOutlet UIButton *performtest;
- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender;

@end
