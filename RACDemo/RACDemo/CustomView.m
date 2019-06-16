//
//  CustomView.m
//  RACDemo
//
//  Created by markye on 2019/6/16.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "CustomView.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>
#import <Masonry.h>

@interface CustomView()

@end

@implementation CustomView

- (instancetype)init{
    self = [super init];
    if (self) {
        [self initUI];
    }
    return self;
}

-(void)initUI{
    UIButton *btn = [[UIButton alloc] init];
    [btn setTitle:@"子视图按钮" forState:UIControlStateNormal];
    btn.backgroundColor = [UIColor redColor];
    [self addSubview:btn];
    
    [btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.equalTo(self);
        make.width.mas_equalTo(200);
        make.height.mas_equalTo(50);
    }];
    //按钮点击
    [[btn rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(__kindof UIControl * _Nullable x) {
        [self doSomething];
    }];
}

- (void)doSomething{
    NSLog(@"子视图--doSomething");
}

@end
