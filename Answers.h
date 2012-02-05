//
//  Answers.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Questions;

@interface Answers : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic) BOOL correct;
@property (nonatomic, retain) Questions *question;

@end
