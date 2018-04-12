//
//  CollegeManager.h
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
@interface CollegeManager : NSObject

+ (CollegeManager *)sharedManager;

- (void)save;

- (void)deleteEntity:(NSManagedObject *)obj;

- (void)initializeData;

- (void)fetchTest;

- (void)fetchMyClasses;

- (void)updateTest;

- (void)deleteTest;

- (void)countTest;

- (void)maxTest;

- (void)studentNumGroupByAge;

- (void)studentID;

- (NSFetchedResultsController *)allCourses;

- (void)addCourseWithName: (NSString *)name;
@end
