//
//  CourseDetialViewController.m
//  CollegeManagementSystem
//
//  Created by EastElsoft on 2016/11/7.
//  Copyright © 2016年 EastElsoft. All rights reserved.
//

#import "CourseDetialViewController.h"
#import "CollegeManager.h"

@interface CourseDetialViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation CourseDetialViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.controllerMode == NewOrEditModeNew) {
        self.title = @"新建课程";
    } else if (self.controllerMode == NewOrEditModeEdit) {
       self.title = @"编辑课程";
        self.textField.text = self.moCourse.name;
    }
    [self.textField addTarget:self action:@selector(onTextFieldNameChanged:) forControlEvents:UIControlEventEditingChanged];
    [self checkTextFieldAndMakeDoneButtonState];
}
- (IBAction)onSave:(id)sender {
    CollegeManager *mgr = [CollegeManager sharedManager];
    if (self.controllerMode == NewOrEditModeNew) {
        [mgr addCourseWithName:self.textField.text];
    } else {
        self.moCourse.name = self.textField.text;
        [mgr save];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)onTextFieldNameChanged:(UITextField *)textField{
    [self checkTextFieldAndMakeDoneButtonState];
}

- (void)checkTextFieldAndMakeDoneButtonState {
    if (self.textField.text.length == 0) {
        self.navigationItem.rightBarButtonItem.enabled = NO;
    } else {
        self.navigationItem.rightBarButtonItem.enabled = YES;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
