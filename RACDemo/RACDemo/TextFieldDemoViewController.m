//
//  TextFieldDemoViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "TextFieldDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface TextFieldDemoViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIButton *confirmBtn;

@end

@implementation TextFieldDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    //原生的写法
//   [_textField addTarget:self action:@selector(textChanged:) forControlEvents:UIControlEventEditingChanged];
    
    //订阅输入框文本变化信号的信号
    @weakify(self);
    [[_textField rac_textSignal] subscribeNext:^(NSString * x) {
        NSLog(@"%@",x);
        @strongify(self);
        if (x.length > 0) {
            self.confirmBtn.backgroundColor = [UIColor colorWithRed:27/255.0 green:154/255.0 blue:251/255.0 alpha:1];
        }else{
            self.confirmBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }];
    
//    //高级用法；
//    //map:映射/转换信号对象
//    //filter:过滤信号
//    [[[[_textField rac_textSignal]
//       map:^id(NSString *  value) {
//        return [NSString stringWithFormat:@"Map%@",value];
//    }] filter:^BOOL(NSString * value) {
//        return value.length > 8;
//    }] subscribeNext:^(NSString * x) {
//        NSLog(@"转换---%@",x);
//    }];
    
    //按钮事件~
    //原生写法
//    [_confirmBtn addTarget:self action:@selector(btnClicked:) forControlEvents:UIControlEventTouchUpInside];
    //RAC订阅按钮点击信号
    [[_confirmBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl *  x) {
        NSLog(@"按钮点击了~~~");
    }];
}

-(void)textChanged:(UITextField *)sender{
    NSLog(@"%@",sender.text);
}

-(void)btnClicked:(UIButton *)sender{
    NSLog(@"按钮点击了");
}

@end
