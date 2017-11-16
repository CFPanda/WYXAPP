//
//  SetAlertViewController.m
//  CFAPP
//
//  Created by duanchuanfen on 2017/8/31.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "SetAlertViewController.h"

@interface SetAlertViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic)  UITableView *setTabView;
@property (strong, nonatomic)  UIDatePicker*datePicker;
@property (strong, nonatomic)  UIView*buttonView;
@property (nonatomic,strong)NSMutableArray *dataArr;
@end

@implementation SetAlertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 30, 30);
    [btn2 addTarget:self action:@selector(clickTianjia:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setImage:[UIImage imageNamed:@"tianjia"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = right;
    
    self.dataArr = [[[NSUserDefaults standardUserDefaults]objectForKey:@"Tip"] mutableCopy];
    if (!self.dataArr) {
        self.dataArr = [[NSMutableArray alloc]initWithCapacity:0];
    }
    [self.view addSubview:self.setTabView];
    [self createDatePick];
}


// 返回
- (void)clickBack:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.navigationController popViewControllerAnimated:YES];
    
}


//添加
- (void)clickTianjia:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    self.datePicker.hidden = NO;
    self.buttonView.hidden = NO;
    
}

- (void)createDatePick{
    _buttonView = [[UIView alloc]initWithFrame:CGRectMake(0,self.view.frame.size.height - 216 -40 , self.view.frame.size.width, 40)];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 80, 40);
    [btn1 addTarget:self action:@selector(clickCancel:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 addTarget:self action:@selector(clickSure:) forControlEvents:(UIControlEventTouchUpInside)];
    btn2.frame = CGRectMake(self.view.frame.size.width - 80,0 , 80, 40);
    btn3.frame = CGRectMake(0,0 , 80, 40);
    btn3.center = _buttonView.center;
    
    
    [btn1 setTitle:@"cancel" forState:(UIControlStateNormal)];
    [btn1 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [btn2 setTitle:@"Sure" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];;
    [btn3 setTitle:@"Everyday" forState:(UIControlStateNormal)];
    [btn3 setTitleColor:[UIColor blueColor] forState:(UIControlStateNormal)];
    [_buttonView addSubview:btn3];
    [_buttonView addSubview:btn1];
    [_buttonView addSubview:btn2];
    [self.view addSubview:_buttonView];
    self.buttonView.hidden = YES;
    
    self.datePicker = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, self.view.frame.size.height - 216, self.view.frame.size.width, 216)];
    self.datePicker.userInteractionEnabled = YES;
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
    //默认根据手机本地设置显示为中文还是其他语言
    NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"English"];//设置为中文显示
    self.datePicker.locale = locale;
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    self.datePicker.hidden = YES;
    [self.view addSubview:self.datePicker];
    
}

- (void)clickCancel:(UIButton*)sender {
    AudioServicesPlaySystemSound(SOUNDID);
    self.datePicker.hidden = YES;
    self.buttonView.hidden = YES;
}

- (void)clickSure:(UIButton*)sender {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.dataArr addObject:[self stringWithDate:self.datePicker.date]];
    if ([self compareDate:[self stringWithDate:self.datePicker.date] withDate:[self stringWithDate:[NSDate date]]] >0) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please set a time larger than the current time!"];
        self.datePicker.hidden = YES;
        self.buttonView.hidden = YES;
        return;
    }
    [self setUpLocalNotificationWithModel:[self stringWithDate:self.datePicker.date]];
    [[NSUserDefaults standardUserDefaults] setObject:self.dataArr forKey:@"Tip"];
    
     NSIndexPath *index;
    if (self.dataArr.count > 0) {
        index = [NSIndexPath indexPathForRow:self.dataArr.count - 1 inSection:0];
    }else {
        index = [NSIndexPath indexPathForRow:0 inSection:0];
    }
   
    [self.setTabView beginUpdates];
    [self.setTabView insertRowsAtIndexPaths:@[index] withRowAnimation:(UITableViewRowAnimationNone)];
    [self.setTabView endUpdates];
    self.datePicker.hidden = YES;
    self.buttonView.hidden = YES;
}

-(void)dateChanged:(UIDatePicker *)sender{
    AudioServicesPlaySystemSound(SOUNDID);
    NSLog(@"%@",self.datePicker.date);
}
- (UITableView *)setTabView{
    if (!_setTabView) {
        _setTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20)];
        _setTabView.delegate = self;
        _setTabView.dataSource = self;
//        _setTabView.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
        _setTabView.separatorStyle = UITableViewCellSelectionStyleNone;
        _setTabView.showsVerticalScrollIndicator = NO;
        
        
    }
    return _setTabView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.dataArr.count;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:@"cell"];
    }
//    cell.backgroundColor = [UIColor colorWithHexString:@"#F0FFF0"];
    cell.textLabel.text = @"Reminder time";
    
    
    UIView *viewSome = [[UIView alloc]initWithFrame:CGRectMake(0, 49, self.view.frame.size.width, 1)];
    viewSome.backgroundColor = [UIColor lightGrayColor];
    viewSome.alpha = 0.5;
    [cell addSubview:viewSome];
    if (self.dataArr.count > 0) {
        cell.detailTextLabel.text = self.dataArr[indexPath.row];
    }
    
    
    return cell;
}
-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath {
    return @"Delete";
}
-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}
- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        AudioServicesPlaySystemSound(SOUNDID);
        [self.dataArr removeObjectAtIndex:indexPath.row];
        [[NSUserDefaults standardUserDefaults] setObject:self.dataArr forKey:@"Tip"];
        [self.setTabView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.setTabView reloadData];
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    self.datePicker.hidden = YES;
    self.buttonView.hidden = YES;
}


- (NSString *)stringWithDate:(NSDate *)date {
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *nowdate = date;
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday |
    NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday | NSCalendarUnitWeekOfMonth | NSCalendarUnitWeekOfYear;
    comps = [calendar components:unitFlags fromDate:nowdate];
    
    NSLog(@"%ld年",(long)[comps year]);
    NSLog(@"%ld月",(long)[comps month]);
    NSLog(@"%ld日",(long)[comps day]);
    NSLog(@"%ld时",(long)[comps hour]);
    NSLog(@"%ld分",(long)[comps minute]);
    NSLog(@"%ld秒",(long)[comps second]);
    NSString *timeString = [NSString stringWithFormat:@"%ld-%ld-%ld %ld:%ld",(long)[comps year],(long)[comps month],(long)[comps day],(long)[comps hour],(long)[comps minute]];
    return timeString;
}


- (void)setUpLocalNotificationWithModel:(NSString *)dateString{
    
      UILocalNotification *noti = [[UILocalNotification alloc] init];
        if (noti == nil) {
            return;
        }
        
        [noti setTimeZone:[NSTimeZone defaultTimeZone]];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
        NSDate *testDate = [formatter dateFromString:dateString];
        //to set the fire date
        noti.fireDate = testDate;
        noti.alertBody = [NSString stringWithFormat:@"Time is up. Keep track of your mood at the moment!"];
        NSLog(@"tip: %@", noti.alertBody);
        noti.alertAction = @"View";
        noti.soundName = UILocalNotificationDefaultSoundName;
        noti.applicationIconBadgeNumber += 1;
       [[UIApplication sharedApplication] scheduleLocalNotification:noti];
    
}

- (NSInteger)compareDate:(NSString*)aDate withDate:(NSString*)bDate
{
    NSInteger aa = 0;
    NSDateFormatter *dateformater = [[NSDateFormatter alloc] init];
    [dateformater setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSDate *dta = [[NSDate alloc] init];
    NSDate *dtb = [[NSDate alloc] init];
    
    dta = [dateformater dateFromString:aDate];
    dtb = [dateformater dateFromString:bDate];
    NSComparisonResult result = [dta compare:dtb];
    if (result==NSOrderedSame)
    {
        //        相等  aa=0
    }else if (result==NSOrderedAscending)
    {
        //bDate比aDate大
        aa=1;
    }else if (result==NSOrderedDescending)
    {
        //bDate比aDate小
        aa=-1;
        
    }
    
    return aa;
}



@end
