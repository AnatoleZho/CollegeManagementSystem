//
//  Teacher+CoreDataProperties.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "Teacher+CoreDataProperties.h"

@implementation Teacher (CoreDataProperties)

+ (NSFetchRequest<Teacher *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Teacher"];
}

@dynamic name;
@dynamic myclass;
@dynamic course;

@end
