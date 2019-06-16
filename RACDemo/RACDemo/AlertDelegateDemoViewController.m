//
//  AlertDelegateDemoViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "AlertDelegateDemoViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>

@interface AlertDelegateDemoViewController ()

@property (weak, nonatomic) IBOutlet UIButton *showBtn;

@end

@implementation AlertDelegateDemoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    //处理循环引用问题，YYKit里也有类似的宏定义;
    @weakify(self);
    [[_showBtn rac_signalForControlEvents:UIControlEventTouchUpInside]
        subscribeNext:^(__kindof UIControl * _Nullable x) {
        @strongify(self);
        [self showAlertView];
    }];
}

- (void)showAlertView{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"RAC" message:@"RAC Delegate TEST" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    //RAC替换代理
    [[self rac_signalForSelector:@selector(alertView:clickedButtonAtIndex:) fromProtocol:@protocol(UIAlertViewDelegate)] subscribeNext:^(RACTuple *tuple) {
        NSLog(@"alert对象为---%@",tuple.first);//代理的第一个参数;
        NSLog(@"点击按钮下标为--%@",tuple.second);//代理的第二个参数;
    }];
    
// // Alertview的额外一个RAC信号;
//    [[alertView rac_buttonClickedSignal] subscribeNext:^(NSNumber * _Nullable x) {
//        NSLog(@"下标为---%@",x);
//        if ([x intValue] == 1) {
//            //Rac通知
//            [[[NSNotificationCenter defaultCenter] rac_addObserverForName:UIApplicationDidEnterBackgroundNotification object:nil] subscribeNext:^(id x) {
//                 NSLog(@"应用程序退到后台了~");
//            }];
//        }
//    }];
    [alertView show];
}

@end
