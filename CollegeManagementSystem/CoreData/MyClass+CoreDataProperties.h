//
//  MyClass+CoreDataProperties.h
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "MyClass+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Student *> *students;
@property (nullable, nonatomic, retain) Teacher *teacher;

@end

@interface MyClass (CoreDataGeneratedAccessors)

- (void)addStudentsObject:(Student *)value;
- (void)removeStudentsObject:(Student *)value;
- (void)addStudents:(NSSet<Student *> *)values;
- (void)removeStudents:(NSSet<Student *> *)values;

@end

NS_ASSUME_NONNULL_END
