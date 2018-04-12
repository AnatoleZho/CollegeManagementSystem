//
//  MainViewController.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/7.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "MainViewController.h"
#import "CollegeManager.h"
@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onInitData:(id)sender {
    [[CollegeManager sharedManager] initializeData];
}

- (IBAction)onFetchAllStudents:(id)sender {
    [[CollegeManager sharedManager] fetchTest];
}

- (IBAction)onFetchAllClasses:(id)sender {
    [[CollegeManager sharedManager] fetchMyClasses];
}

- (IBAction)onUpdateTest:(id)sender {
    [[CollegeManager sharedManager] updateTest];
}

- (IBAction)onDeleteTest:(id)sender {
    [[CollegeManager sharedManager] deleteTest];
}

- (IBAction)onCountTest:(id)sender {
    [[CollegeManager sharedManager] countTest];
}

- (IBAction)onMaxTest:(id)sender {
    [[CollegeManager sharedManager] maxTest];
}

- (IBAction)onCountCourseTest:(id)sender {
    [[CollegeManager sharedManager] studentNumGroupByAge];
}

- (IBAction)onGetID:(id)sender {
    [[CollegeManager sharedManager] studentID];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
