//
//  ViewController.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong, nonatomic) NSManagedObjectContext *manageObjectContext;

- (void)prepareForSegue:(UIStoryboardSegue*)segue sender:(id)sender;

@end
