//
//  CourseDetialViewController.h
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/7.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Course+CoreDataClass.h"

typedef enum : NSUInteger {
    NewOrEditModeNew,
    NewOrEditModeEdit
} NewOrEditMode;

@interface CourseDetialViewController : UIViewController
@property (assign, nonatomic) NewOrEditMode controllerMode;
@property (strong, nonatomic) Course *moCourse;

@end
