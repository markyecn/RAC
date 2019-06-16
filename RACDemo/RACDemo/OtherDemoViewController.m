//
//  OtherDemoViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "OtherDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>

@interface OtherDemoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (strong,nonatomic) RACDisposable* timerDisposable;

@end

@implementation OtherDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //遍历数组
    NSArray *array = @[@"11111",@"22222",@"33333",@"44444",@"55555"];
    //获取sequence信号,然后订阅
    [[array rac_sequence].signal subscribeNext:^(id  _Nullable x) {
        NSLog(@"%@",x);
    }];
//    //遍历字符串
//    NSString *str = @"abcdefgh";
//    [[str rac_sequence].signal subscribeNext:^(NSString * _Nullable x) {
//        NSLog(@"%@",x);
//    }];
    
//    //遍历字典
//    NSDictionary *dic = @{
//                          @"key1":@"value1",
//                          @"key2":@"value2",
//                          @"key3":@"value3",
//                          };
//    //获取sequence信号,然后订阅
//    [[dic rac_sequence].signal subscribeNext:^(RACTuple*  _Nullable x) {
//        NSLog(@"%@--%@",x.first,x.second);
//    }];
    //遍历key值数组, value数组
//    [dic rac_keySequence]
//    [dic rac_valueSequence]

    //宏
    //将输入框的值 赋值到label
    //self:需要设置的对象, textLabel.text 对象的属性;
    RAC(self.textLabel,text) = [_textField rac_textSignal];
    
    //观察者-KVO
    [RACObserve(self.textLabel, text) subscribeNext:^(id  _Nullable x) {
        NSLog(@"observer--%@",x);
    }];
    
    //RAC定时器
    static int time = 0;
    @weakify(self);
    _timerDisposable = [[RACSignal interval:1 onScheduler:[RACScheduler mainThreadScheduler]] subscribeNext:^(NSDate * _Nullable x) {
        @strongify(self);
        NSLog(@"%@",x);
        time ++;
        self.timeLabel.text = [NSString stringWithFormat:@"定时器---%d",time];
    }];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if (_timerDisposable) {
         [_timerDisposable dispose];
    }
}

@end
