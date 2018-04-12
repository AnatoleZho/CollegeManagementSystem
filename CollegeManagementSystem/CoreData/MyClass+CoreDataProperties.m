//
//  MyClass+CoreDataProperties.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "MyClass+CoreDataProperties.h"

@implementation MyClass (CoreDataProperties)

+ (NSFetchRequest<MyClass *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"MyClass"];
}

@dynamic name;
@dynamic students;
@dynamic teacher;

@end
