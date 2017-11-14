//
//  CalendarViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "CalendarViewController.h"
#import "WZYCalendar.h"
@interface CalendarViewController ()

@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    
    [self setupCalendar]; // 初始化日历对象
}

- (void)clickBack:(UIButton *)btn {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)setupCalendar {
    
    CGFloat width = self.view.bounds.size.width - 20.0;
    CGPoint origin = CGPointMake(10.0,80);
    
    // 传入Calendar的origin和width。自动计算控件高度
    WZYCalendarView *calendar = [[WZYCalendarView alloc] initWithFrameOrigin:origin width:width];
    
    NSLog(@"height --- %lf", calendar.frame.size.height);
    
    // 点击某一天的回调
    calendar.didSelectDayHandler = ^(NSInteger year, NSInteger month, NSInteger day) {
   
       
        
    };
    
    [self.view addSubview:calendar];
    
}


@end
