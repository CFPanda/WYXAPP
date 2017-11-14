//
//  FirstViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/18.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "FirstViewController.h"
#import "CategoryViewController.h"
#import "CalendarViewController.h"
#import "WriteViewController.h"
#import "FirstTableViewCell.h"
#import "DayModel.h"
#import "DayDetailViewController.h"
@interface FirstViewController ()<UIPopoverPresentationControllerDelegate,CategoryDelegate,UITableViewDelegate,UITableViewDataSource>
@property (nonatomic ,assign)BOOL isSelected;
@property (nonatomic ,strong) UIButton *centerBtn;
@property (nonatomic ,strong) UILabel *labelSome;
@property (nonatomic ,strong)CategoryViewController *categoryVC;
@property (nonatomic ,strong)NSArray *dataArr;
@property (nonatomic ,strong)UITableView *firstTab;
@property (nonatomic ,strong)NSMutableArray *dataSource;
@property (nonatomic ,assign)int type;
@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.type =0;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
    [self createCenterView];
    [self.view addSubview:self.firstTab];
    
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
    self.labelSome.text = @"All";
    if (self.dataSource.count == 0) {
         [[GlobalTool ShareInstance] showNoDataViewOn:self.firstTab withTitleString:@"Without a record, click the button in the upper right corner to record something you're interested in~"];
    }else {
        [[GlobalTool ShareInstance] removeNoDataViewFrom:self.firstTab];
    }
   
    [self.firstTab reloadData];
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"All",@"Work",@"Study",@"Life",@"Love"];
    }
    
    return _dataArr;
}

- (NSMutableArray*)dataSource {
    if (!_dataSource) {
        _dataSource = [[NSMutableArray alloc] initWithCapacity:0];
    }
    
    return _dataSource;
}

- (UITableView *)firstTab {
    if (!_firstTab) {
        _firstTab = [[UITableView alloc] initWithFrame:self.view.bounds];
        _firstTab.delegate = self;
        _firstTab.dataSource = self;
        _firstTab.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
        _firstTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_firstTab registerNib:[UINib nibWithNibName:@"FirstTableViewCell" bundle:nil] forCellReuseIdentifier:@"firstCell"];
    }
    return _firstTab;
}

- (void)createCenterView {
    
    UIView *viewSome = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    _labelSome = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    _labelSome.text = @"All";
    _labelSome.textColor = [UIColor whiteColor];
    _labelSome.numberOfLines = 0;
    _labelSome.textAlignment = NSTextAlignmentCenter;
    _centerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _centerBtn.frame = CGRectMake(60,7.5,15, 15);
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    [_centerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [viewSome addSubview:_centerBtn];
    [viewSome addSubview:_labelSome];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(chooesCategory:))];
    [viewSome addGestureRecognizer:tap];
    self.navigationItem.titleView = viewSome;
    
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 15, 15);
    [btn1 setImage:[UIImage imageNamed:@"rili"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickRili:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 15, 15);
    [btn2 addTarget:self action:@selector(clickXieZi:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setImage:[UIImage imageNamed:@"xiezi"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = right;
}
//去日历
- (void)clickRili:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    CalendarViewController *calendarVC = [[CalendarViewController alloc]init];
    calendarVC.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:calendarVC animated:YES];
    
}


//去记日记
- (void)clickXieZi:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    WriteViewController *write = [[WriteViewController alloc]init];
    write.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:write animated:YES];
    
}


- (void)chooesCategory:(UITapGestureRecognizer *)tap {
    self.isSelected = !self.isSelected;
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.isSelected) {
        
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantoux"] forState:(UIControlStateNormal)];
        _categoryVC = [[CategoryViewController alloc]init];
        _categoryVC.modalPresentationStyle = UIModalPresentationPopover;
        _categoryVC.view.backgroundColor = [UIColor colorWithHexString:@"#E066FF" alpha:0.5];
        _categoryVC.delegate = self;
        _categoryVC.dataArr = self.dataArr;
        _categoryVC.preferredContentSize = CGSizeMake(200, 300);//设置弹出控制器视图的大小
        _categoryVC.popoverPresentationController.sourceView = _labelSome;
        _categoryVC.popoverPresentationController.sourceRect = _labelSome.bounds;
        _categoryVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        _categoryVC.popoverPresentationController.delegate = self;
        [self presentViewController:_categoryVC animated:YES completion:nil];
        
    }else {
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    }
    
}

- (void)clickBtn:(UIButton *)sender {
    self.isSelected = !self.isSelected;
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.isSelected) {
        
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        [_centerBtn setImage:[UIImage imageNamed:@"jiantoux"] forState:(UIControlStateNormal)];
        _categoryVC = [[CategoryViewController alloc]init];
        _categoryVC.modalPresentationStyle = UIModalPresentationPopover;
        _categoryVC.view.backgroundColor = [UIColor colorWithHexString:@"#E066FF" alpha:0.5];
        _categoryVC.dataArr = self.dataArr;
        _categoryVC.delegate = self;
        _categoryVC.preferredContentSize = CGSizeMake(200, 300);//设置弹出控制器视图的大小
        _categoryVC.popoverPresentationController.sourceView = _labelSome;
        _categoryVC.popoverPresentationController.sourceRect = _labelSome.bounds;
        _categoryVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        _categoryVC.popoverPresentationController.delegate = self;
        [self presentViewController:_categoryVC animated:YES completion:nil];
        
    }else {
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    }
    
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone; //不适配
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    self.isSelected = !self.isSelected;
    CABasicAnimation* rotationAnimation;
    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转角度
    rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
    //每次旋转的时间（单位秒）
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
    rotationAnimation.repeatCount = 0;
    [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    
    return YES;   //点击蒙版popover消失， 默认YES
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCategory:(NSString *)categoryString {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.categoryVC dismissViewControllerAnimated:YES completion:nil];
    [self popoverPresentationControllerShouldDismissPopover:_categoryVC.popoverPresentationController];
    _labelSome.text = categoryString;
    if ([categoryString isEqualToString:@"All"]) {
        self.type = 0;
    }
    if ([categoryString isEqualToString:@"Work"]) {
        self.type = 1;
    }
    
    if ([categoryString isEqualToString:@"Study"]) {
        self.type = 2;
    }
    
    if ([categoryString isEqualToString:@"Life"]) {
        self.type = 3;
    }
    
    if ([categoryString isEqualToString:@"Love"]) {
        self.type = 4;
    }
    
    
    
    switch (self.type) {
        case 0:
            self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
            break;
        case 1:
            self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"work"];
            break;
            
        case 2:
            self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"study"];
            break;
            
        case 3:
            self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"life"];
            break;
            
        case 4:
            self.dataSource = [[GlobalTool ShareInstance] getPlistWithName:@"love"];
            break;
            
        default:
            break;
    }
    
    
    
    [self.firstTab reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FirstTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"firstCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dictModel = self.dataSource[indexPath.row];
    cell.timeDayLabel.text = dictModel[@"timeDayYear"];
    cell.contentLabel.text = dictModel[@"content"];
    cell.timeHourlabel.text = dictModel[@"timeHour"];
    return cell;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 100.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath  {
    AudioServicesPlaySystemSound(SOUNDID);
    NSDictionary *dictModel = self.dataSource[indexPath.row];
    DayDetailViewController *dayDeatil = [[DayDetailViewController alloc] init];
    dayDeatil.hidesBottomBarWhenPushed = YES;
    dayDeatil.type = self.type;
    dayDeatil.dataDic = dictModel;
    [self.navigationController pushViewController:dayDeatil animated:YES];
}
@end
