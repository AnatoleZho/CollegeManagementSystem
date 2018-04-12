//
//  CollegeManager.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/4.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "CollegeManager.h"
#import "AppDelegate.h"
#import "MyClass+CoreDataClass.h"
#import "Student+CoreDataClass.h"
#import "Teacher+CoreDataClass.h"
#import "Course+CoreDataClass.h"

static CollegeManager *_sharedManager  = nil;

@interface CollegeManager ()
{
    AppDelegate *appDelegate;
    NSManagedObjectContext *appContext;
}
@end

@implementation CollegeManager

+(CollegeManager *)sharedManager {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        appContext = appDelegate.persistentContainer.viewContext;
    }
    return self;
}

- (void)save {
    [appDelegate saveContext];
}

- (void)deleteEntity:(NSManagedObject *)obj {
    [appContext deleteObject:obj];
    [self save];
}

- (void)initializeData {
    //插入一些班级实体
    //这个Mutable Array是为了方便后面建立实体关系使用
    NSMutableArray *arrMyClasses = [NSMutableArray array];
    NSArray *arrMyClassesName = @[@"99级1班",@"99级2班",@"99级3班"];
    for (NSString *className in arrMyClassesName) {
        MyClass *newMyClass = [NSEntityDescription insertNewObjectForEntityForName:@"MyClass" inManagedObjectContext:appContext];
        newMyClass.name = className;
        [arrMyClasses addObject:newMyClass];
    }
    
    //插入学生实体
    NSMutableArray *arrStudents = [NSMutableArray array];
    NSArray *studnetInfo = @[@{@"name": @"李斌", @"age": @20},
                             @{@"name": @"李鹏", @"age": @19},
                             @{@"name": @"朱文", @"age": @21},
                             @{@"name": @"李强", @"age": @21},
                             @{@"name": @"高嵩", @"age": @18},
                             @{@"name": @"薛大", @"age": @19},
                             @{@"name": @"裘千仞", @"age": @21},
                             @{@"name": @"王波", @"age": @18},
                             @{@"name": @"王鹏", @"age": @19}
                             ];
    for (id info in studnetInfo) {
        NSString *name = [info objectForKey:@"name"];
        NSNumber *age = [info objectForKey:@"age"];
        
        Student *newStudent = [NSEntityDescription insertNewObjectForEntityForName:@"Student" inManagedObjectContext:appContext];
        newStudent.name = name;
        newStudent.age = age;
        [arrStudents addObject:newStudent];
    }
    
    //插入教师实体
    NSMutableArray *arrTeachers = [NSMutableArray array];
    NSArray *arrTeacherName = @[@"王刚", @"谢力", @"徐开义", @"许宏权"];
    for (NSString *teacherName in arrTeacherName) {
        Teacher *newTeacher = [NSEntityDescription insertNewObjectForEntityForName:@"Teacher" inManagedObjectContext:appContext];
        newTeacher.name = teacherName;
        [arrTeachers addObject:newTeacher];
    }
    
    //插入一些课程实体
    NSMutableArray *arrCourses = [NSMutableArray array];
    NSArray *arrCoursesName = @[@"CAD", @"软件工程", @"线性代数", @"微积分", @"大学物理"];
    for (NSString *courseName in arrCoursesName) {
        Course *newCourse = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:appContext];
        newCourse.name = courseName;
        
        [arrCourses addObject:newCourse];
    }
    
    //创建学生和班级的关系
    //向班级1中加入几个学生（方法多种）
    MyClass *classOne = [arrMyClasses objectAtIndex:0];
    [classOne addStudentsObject:[arrStudents objectAtIndex:0]];
    [classOne addStudentsObject:[arrStudents objectAtIndex:1]];
    [[arrStudents objectAtIndex:2] setMyclass:classOne];//可以这样
    
    //向班级2中加入几个学生
    MyClass *classTwo = [arrMyClasses objectAtIndex:1];
    [classTwo  addStudents:[NSSet setWithArray:[arrStudents subarrayWithRange:NSMakeRange(3, 3)]]];
    
    //向班级3中添加几个学生
    MyClass *classThree = [arrMyClasses objectAtIndex:2];
    [classThree setStudents:[NSSet setWithArray:[arrStudents subarrayWithRange:NSMakeRange(6, 3)]]];
    
    
    //给三个班级指派班主任
    Teacher *wanggang = [arrTeachers objectAtIndex:0];
    Teacher *xieli = [arrTeachers objectAtIndex:1];
    Teacher *xukaili = [arrTeachers objectAtIndex:2];
    Teacher *xuhongquan = [arrTeachers objectAtIndex:3];
    
    [classOne setTeacher:wanggang];
    classTwo.teacher = xieli;
    [xukaili setMyclass:classThree];
    
    //创建教师科课程的对应关系
    Course *cad = [arrCourses objectAtIndex:0];
    Course *software = [arrCourses objectAtIndex:1];
    Course *linear = [arrCourses objectAtIndex:2];
    Course *calculus = [arrCourses objectAtIndex:3];
    Course *physics = [arrCourses objectAtIndex:4];
    
    [wanggang setCourse:[NSSet setWithObjects:cad, software, nil]];
    [linear setTeacher:xieli];
    [calculus setTeacher:xuhongquan];
    [physics setTeacher:xukaili];
    
    //设置学生所选的修的课程
    [[arrStudents objectAtIndex:0] setCourse:[NSSet setWithObjects:cad, software, nil]];
    
    [[arrStudents objectAtIndex:1] setCourse:[NSSet setWithObjects:cad, linear, nil]];
    
    [[arrStudents objectAtIndex:2] setCourse:[NSSet setWithObjects:linear, physics, nil]];
    
    [[arrStudents objectAtIndex:3] setCourse:[NSSet setWithObjects:physics, cad, nil]];
    
    [[arrStudents objectAtIndex:4] setCourse:[NSSet setWithObjects:calculus, physics, nil]];
    
    [[arrStudents objectAtIndex:5] setCourse:[NSSet setWithObjects:software, linear, nil]];
    
    [[arrStudents objectAtIndex:6] setCourse:[NSSet setWithObjects:software, physics, nil]];
    
    [[arrStudents objectAtIndex:7] setCourse:[NSSet setWithObjects:linear, software, nil]];
    
    [[arrStudents objectAtIndex:8] setCourse:[NSSet setWithObjects:calculus, software, cad, nil]];
    
    
    //保存
    //如不保存，上面的所有动作都不会写入sqlite
    NSError *error;
    [appContext save:&error];
    if (error) {
        NSLog(@"保存error= = %@", error);
    } else {
        NSLog(@"保存成功！");
        NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSLog(@"documentPath = %@", documentPath);
    }
}

- (void)fetchTest {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:appContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //排序
//    NSSortDescriptor *sorting = [NSSortDescriptor sortDescriptorWithKey:@"age" ascending:YES];
//    [request setSortDescriptors:[NSArray arrayWithObjects:sorting, nil]];
//    
//    //以‘李’字开头的学生
//    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name BEGINSWITH '李'"];
//    [request setPredicate:predicate];
//    
//    //课程为‘大学物理’ 的学生
//    NSPredicate *predicateT = [NSPredicate predicateWithFormat:@"SUBQUERY(coutrse, $course, $course.name == '大学物理').count > 0"];
//    [request setPredicate:predicateT];
    
    //分页
    [request setFetchOffset:3];
    [request setFetchLimit:3];
    
    NSError *error = nil;
    NSArray *arrStudents = [appContext executeFetchRequest:request error:&error];
    
    if (error) {
        NSLog(@"%@",error);
    } else {
        for (Student *stu in arrStudents) {
            NSLog(@"%@ (%@岁)", stu.name, stu.age);
        }
    }
}

- (void)fetchMyClasses {
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"MyClass" inManagedObjectContext:appContext];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:entityDescription];
    
    //预查询
//    [request setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObjects:@"student", nil]];
    
    NSError *error = nil;
    NSArray *arrClasses = [appContext executeFetchRequest:request error:&error];
    if (error) {
        NSLog(@"%@",error);
    } else {
        for (MyClass *myClass in arrClasses) {
            NSLog(@"%@", myClass);
            for (Student *stu in myClass.students) {
                NSLog(@"   %@", stu.name);
            }
        }
    }
}

- (void)updateTest {
    //将“CAD”这门课的名称改为“CAD设计”，并将其授课教师改为“许宏权”
    
    //查出Teacher
    //NSEntityDescription* entityDescription = [NSEntityDescription entityForName:@"Teacher" inManagedObjectContext:appContext];
    //[request setEntity:entityDescription];
    //前面这两步可以换成下面的一步
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
    NSPredicate *filter = [NSPredicate predicateWithFormat:@"name = '许宏权'"];
    [request setPredicate:filter];
    NSError *error = nil;
    NSArray *arrResult = [appContext executeFetchRequest:request error:&error];
    Teacher* xuhongquan = [arrResult objectAtIndex:0];
    
    //查出Course
    request = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    filter = [NSPredicate predicateWithFormat:@"name =[cd] 'cad'"]; //这里的[cd]表示大小写和音标不敏感
    [request setPredicate:filter];
    arrResult = [appContext executeFetchRequest:request error:&error];
    Course* cad = [arrResult objectAtIndex:0];
    
    //修改
    [cad setName:@"CAD设计"];
    [cad setTeacher:xuhongquan];
    
    //保存
    [self save];
}

- (void)deleteTest {
   //删除学生‘王波’
    //查询出‘王波’
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = '王波'"];
    [request setPredicate:predicate];
    NSError *error = nil;
    NSArray *arrResult = [appContext executeFetchRequest:request error:&error];
    Student *wangbo =[arrResult objectAtIndex:0];
    //执行删除
    [self deleteEntity:wangbo];
    //保存
    [self save];
   
    //删除‘99级2班’
    request = [NSFetchRequest fetchRequestWithEntityName:@"MyClass"];
    predicate = [NSPredicate predicateWithFormat:@"name = '99级2班'"];
    [request setPredicate:predicate];
    arrResult = [appContext executeFetchRequest:request error:&error];
    MyClass *myClassTwo = [arrResult objectAtIndex:0];
    //执行删除
    //注意：由于设置了删除规则为Cascade， 所以‘99级2班’的所有学生也会被同时删除
    [self deleteEntity:myClassTwo];
    [self save]; //保存， 可以一起保存
    
    //删除教师 '徐开义'
    request = [NSFetchRequest fetchRequestWithEntityName:@"Teacher"];
    predicate = [NSPredicate predicateWithFormat:@"name = '徐开义'"];
    [request setPredicate:predicate];
    arrResult = [appContext executeFetchRequest:request error:&error];
    Teacher *teacher = [arrResult objectAtIndex:0];
    //执行删除
    //注意： 由于设置了删除规则为Cascade, 所以‘徐开义’的课程也会被删掉
    [self deleteEntity:teacher];
    //保存
    [self save];
}

- (void)countTest {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Course"];
    [request setResultType:NSCountResultType];
    NSError *error = nil;
    id result = [appContext executeFetchRequest:request error:&error];
    NSLog(@"%@", [result objectAtIndex:0]);
    
}

- (void)maxTest  {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    [request setResultType:NSDictionaryResultType];//必须设置为这个类型
    
    //构建用于sum的Expression Description
    NSExpression *theMaxExpression = [NSExpression expressionForFunction:@"max:" arguments:[NSArray arrayWithObject:[NSExpression expressionForKeyPath:@"age"]]];
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"maxAge"];
    [expressionDescription setExpression:theMaxExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    
    //加入request
    [request setPropertiesToFetch:[NSArray arrayWithObjects:expressionDescription   , nil]];
    NSError *error = nil;
    id result = [appContext executeFetchRequest:request error:&error];
    
    //返回的对象是一个字典的数组，取数组中的第一个元素，再用我们前面指定的key(也就是‘maxAge’) 去取我们想要的值
    NSLog(@"The max age is : %@",[[result objectAtIndex:0] objectForKey:@"maxAge"]);
}

- (void)studentNumGroupByAge {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    [request setResultType:NSDictionaryResultType];//必须是这个
    
    NSExpression *theCountExpression = [NSExpression expressionForFunction:@"count:" arguments:[NSArray arrayWithObject: [NSExpression expressionForKeyPath:@"name"]]];
    
    NSExpressionDescription *expressionDescription = [[NSExpressionDescription alloc] init];
    [expressionDescription setName:@"num"];
    [expressionDescription setExpression:theCountExpression];
    [expressionDescription setExpressionResultType:NSInteger32AttributeType];
    
    //构造并加入Group By
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Student" inManagedObjectContext:appContext];
    NSAttributeDescription *adultNumGroupBy = [entity.attributesByName objectForKey:@"age"];
    [request setPropertiesToGroupBy:[NSArray arrayWithObject:adultNumGroupBy]];
    [request setPropertiesToFetch:[NSArray arrayWithObjects:@"age", expressionDescription, nil]];
    
    NSError *error = nil;
    id result = [appContext executeFetchRequest:request error:&error];
    for (id item in result) {
        NSLog(@"Age: %@ Student Num:%@",[item objectForKey:@"age"], [item objectForKey:@"num"]);
    }
}

- (void)studentID {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"Student"];
    NSError *error = nil;
    id result = [appContext executeFetchRequest:request error:&error];
    for (id stu in result) {
        NSLog(@"%@", [stu objectID]);//返回的类型是 NSManagedObjectID
    }
    
    //用ID获取MO的方法
    NSManagedObjectID *firstStudentID = [[result objectAtIndex:0] objectID];
    NSLog(@"%@", [firstStudentID URIRepresentation]);
    Student *firstStudent = (Student *)[appContext existingObjectWithID:firstStudentID error:&error];
    NSLog(@"First student name: %@",firstStudent.name);
    
    //将NSManagedObjectID转为NSURL
    NSURL *urlFirstStudent = [firstStudentID URIRepresentation];
    NSPersistentStoreCoordinator *coordinator = [appContext persistentStoreCoordinator];
    NSManagedObjectID *firstStudentIdConverBack = [coordinator managedObjectIDForURIRepresentation:urlFirstStudent];
    NSLog(@"%@", firstStudentIdConverBack);
}

- (NSFetchedResultsController *)allCourses {
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    //Entity
    NSEntityDescription *entityDescription = [NSEntityDescription entityForName:@"Course" inManagedObjectContext:appContext];
    [request setEntity:entityDescription];
    
    //Sort
    //NSFetchResultController必须要有Sort
    NSSortDescriptor *sort = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    [request setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSFetchedResultsController *controller = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:appContext sectionNameKeyPath:nil cacheName:nil];
    NSError *error = nil;
    [controller performFetch:&error];
    
    return controller;
}

- (void)addCourseWithName: (NSString *)name {
    Course *course = [NSEntityDescription insertNewObjectForEntityForName:@"Course" inManagedObjectContext:appContext];
    course.name = name;
    
    [self save];
}

@end
