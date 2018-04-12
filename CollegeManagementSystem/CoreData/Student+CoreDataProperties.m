//
//  Student+CoreDataProperties.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "Student+CoreDataProperties.h"

@implementation Student (CoreDataProperties)

+ (NSFetchRequest<Student *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Student"];
}

@dynamic name;
@dynamic age;
@dynamic myclass;
@dynamic course;

@end
