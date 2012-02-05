//
//  Questions.h
//  test_app
//
//  Created by Yaroslav Fedorov on 29/01/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Answers;

@interface Questions : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *answer;
@end

@interface Questions (CoreDataGeneratedAccessors)

- (void)addAnswerObject:(Answers *)value;
- (void)removeAnswerObject:(Answers *)value;
- (void)addAnswer:(NSSet *)values;
- (void)removeAnswer:(NSSet *)values;

@end
