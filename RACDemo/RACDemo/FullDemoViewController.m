//
//  FullDemoViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "FullDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>
#import <Masonry.h>
#import "CustomView.h"

@interface FullDemoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;

@end

@implementation FullDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //当2个输入框都有值时,按钮变成可点击并改变颜色;
    
    //合并两个输入框的文本信号
    //并合并成一个信号变量;
    RACSignal *conbinedSignal = [RACSignal combineLatest:@[_nameField.rac_textSignal,_passwordField.rac_textSignal]
        reduce:^id (NSString *name, NSString *password){
        if (![name isEqualToString:@""] && ![password isEqualToString:@""]) {
            return @(YES);
        }else{
            return @(NO);
        }
    }];
    //订阅信号
    @weakify(self);
    [conbinedSignal subscribeNext:^(id x) {
        @strongify(self);
        if ([x boolValue]) {
            self.loginBtn.enabled = YES;
            self.loginBtn.backgroundColor = [UIColor colorWithRed:27/255.0 green:154/255.0 blue:251/255.0 alpha:1];
        }else{
            self.loginBtn.enabled = NO;
            self.loginBtn.backgroundColor = [UIColor lightGrayColor];
        }
    }];
    
    [[_loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        NSLog(@"点击登录了~~~");
        @strongify(self);
        //发送请求
        [[self doLoginWithName:self.nameField.text password:self.passwordField.text] subscribeNext:^(id  _Nullable x) {
            if (x) {
                NSLog(@"登录成功~~~~");
                NSLog(@"返回的数据---%@",x);
            }
        } error:^(NSError * _Nullable error) {
            NSLog(@"error----");
        }];
    }];
    
//    RACSignal *colorConbinedSignal = [RACSignal combineLatest:@[_nameField.rac_textSignal,_passwordField.rac_textSignal] reduce:^id (NSString *name, NSString *password){
//        if (![name isEqualToString:@""] && ![password isEqualToString:@""]) {
//            return [UIColor colorWithRed:27/255.0 green:154/255.0 blue:251/255.0 alpha:1];
//        }else{
//            return [UIColor lightGrayColor];
//        }
//    }];
    //宏
//    RAC(self.loginBtn,enabled) = conbinedSignal;
//    RAC(self.loginBtn,backgroundColor) = colorConbinedSignal;
    
    CustomView *customView = [[CustomView alloc] init];
    customView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:customView];
    [customView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.loginBtn.mas_bottom).offset(30);
        make.height.mas_equalTo(100);
    }];
    
    //订阅子视图指定方法的信号;
//    [[customView rac_signalForSelector:@selector(doSomething)] subscribeNext:^(RACTuple * _Nullable x) {
//        NSLog(@"控制器--doSomething");
//    }];
    
    [customView.eventSignal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
}

//RACCommand
//简易的封装 -- 一般额外还有一层RACCommand进行封装
- (RACSignal *)doLoginWithName:(NSString *)name password:(NSString *)pwd{
    RACSignal *loginSignal =  [RACSignal createSignal:^RACDisposable * (id<RACSubscriber>  subscriber) {
        
        //TODO
        //发送AFNetworking 请求------
        //模拟请求发送
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            //模拟返回数据
            BOOL success = YES;
            NSDictionary *dic = @{
                                  @"userId":@"222222222",
                                  @"phoneNo":@"13888888888"
                                  };
            //处理
            if (success) {
                [subscriber sendNext:dic];
                [subscriber sendCompleted];
            }else{
                //出现错误
                [subscriber sendError:nil];
            }
        });
        return [RACDisposable disposableWithBlock:^{
            //TODO other things;
        }];
    }];

    return loginSignal;
}

@end
