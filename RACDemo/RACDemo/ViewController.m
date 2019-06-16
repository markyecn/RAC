//
//  ViewController.m
//  RACDemo
//
//  Created by markye on 2019/6/11.
//  Copyright © 2019年 markye. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveObjC/ReactiveObjC.h>
#import <ReactiveObjC/RACEXTScope.h>

#import "BasicViewController.h"
#import "TextFieldDemoViewController.h"
#import "AlertDelegateDemoViewController.h"
#import "OtherDemoViewController.h"
#import "FullDemoViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>


@property (weak, nonatomic) IBOutlet UITableView *demoTableView;

@property (strong, nonatomic) NSMutableArray *demoArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"RACDemo";
    self.demoArray = [NSMutableArray arrayWithArray:@[@"1. 基础信号Demo",
                                                      @"2. 输入框/按钮Demo",
                                                      @"3. 代理/通知Demo",
                                                      @"4. 其他(宏,遍历,定时器     等)Demo",
                                                      @"5. 使用示例Demo"]];
    
    //订阅列表点击信号
    @weakify(self);
    [[self rac_signalForSelector:@selector(tableView:didSelectRowAtIndexPath:) fromProtocol:@protocol(UITableViewDelegate)]
     
    subscribeNext:^(RACTuple * _Nullable x) {
        NSIndexPath *indexPath = x.second;
        @strongify(self);
            if (indexPath.row == 0) {
                BasicViewController *basicVC = [[BasicViewController alloc] init];
                basicVC.navigationItem.title = self.demoArray[indexPath.row];
                [self.navigationController pushViewController:basicVC animated:YES];
            }else if(indexPath.row == 1){
                TextFieldDemoViewController *textDemoVc = [[TextFieldDemoViewController alloc] init];
                textDemoVc.navigationItem.title = self.demoArray[indexPath.row];
                [self.navigationController pushViewController:textDemoVc animated:YES];
            }else if(indexPath.row == 2){
                AlertDelegateDemoViewController *textDemoVc = [[AlertDelegateDemoViewController alloc] init];
                textDemoVc.navigationItem.title = self.demoArray[indexPath.row];
                [self.navigationController pushViewController:textDemoVc animated:YES];
            }else if(indexPath.row == 3){
                OtherDemoViewController *textDemoVc = [[OtherDemoViewController alloc] init];
                textDemoVc.navigationItem.title = self.demoArray[indexPath.row];
                [self.navigationController pushViewController:textDemoVc animated:YES];
            }else if(indexPath.row == 4){
                FullDemoViewController *demoVc = [[FullDemoViewController alloc] init];
                demoVc.navigationItem.title = self.demoArray[indexPath.row];
                [self.navigationController pushViewController:demoVc animated:YES];
            }
    }];
    //设置代理
    self.demoTableView.delegate = self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.demoArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString  *cellId = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
    }
    cell.textLabel.text = _demoArray[indexPath.row];
    return cell;
}

//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    if (indexPath.row == 0) {
//        BasicViewController *basicVC = [[BasicViewController alloc] init];
//        basicVC.navigationItem.title = _demoArray[indexPath.row];
//        [self.navigationController pushViewController:basicVC animated:YES];
//    }else if(indexPath.row == 1){
//        TextFieldDemoViewController *textDemoVc = [[TextFieldDemoViewController alloc] init];
//        textDemoVc.navigationItem.title = _demoArray[indexPath.row];
//        [self.navigationController pushViewController:textDemoVc animated:YES];
//    }else if(indexPath.row == 2){
//        AlertDelegateDemoViewController *textDemoVc = [[AlertDelegateDemoViewController alloc] init];
//        textDemoVc.navigationItem.title = _demoArray[indexPath.row];
//        [self.navigationController pushViewController:textDemoVc animated:YES];
//    }else if(indexPath.row == 3){
//        OtherDemoViewController *textDemoVc = [[OtherDemoViewController alloc] init];
//        textDemoVc.navigationItem.title = _demoArray[indexPath.row];
//        [self.navigationController pushViewController:textDemoVc animated:YES];
//    }else if(indexPath.row == 4){
//        FullDemoViewController *demoVc = [[FullDemoViewController alloc] init];
//        demoVc.navigationItem.title = _demoArray[indexPath.row];
//        [self.navigationController pushViewController:demoVc animated:YES];
//    }
//}


@end
