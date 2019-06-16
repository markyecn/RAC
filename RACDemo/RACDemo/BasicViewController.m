//
//  BasicViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "BasicViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>

@interface BasicViewController ()

@end

@implementation BasicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    //1、创建信号量- 默认是冷信号
    RACSignal *signal = [RACSignal createSignal:^RACDisposable * _Nullable(id<RACSubscriber>  _Nonnull subscriber) {
        NSLog(@"执行创建时的block了");
        //3、发送信号
        [subscriber sendNext:@"发送11111"];
        NSLog(@"发送完成了");
        
        return [RACDisposable disposableWithBlock:^{
            //销毁时的额外处理
            NSLog(@"取消订阅后执行我了~~");
        }];
    }];
    //2、订阅信号量-订阅之后才变成热信号
    RACDisposable *disPosable = [signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"收到的信号值-%@",x);
    }];
    //取消订阅,销毁;
    [disPosable dispose];
    
    
    
    //RACSubject 可以订阅信号,又可以发送信号;
    RACSubject *subject= [RACSubject subject];
    //订阅信号
    [subject subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
    //发送信号
    [subject sendNext:@"88888"];
}

@end
