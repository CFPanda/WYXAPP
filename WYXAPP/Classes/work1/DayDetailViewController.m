//
//  DayDetailViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/21.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "DayDetailViewController.h"
#import "DayTableViewCell.h"
#import "ModifyViewController.h"
#import "DayModel.h"

@interface DayDetailViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (nonatomic, strong)UITableView *detailTab;
@property (nonatomic, strong)DayModel *dayModel;
@property (nonatomic, strong)UILabel *timeDayYearLabel;
@property (nonatomic, strong)UILabel *timeHourLabel;
@end

@implementation DayDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self creatNavItem];
    self.view.backgroundColor = [UIColor whiteColor];
       [self.view addSubview:self.detailTab];
   
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.dayModel = [[DayModel alloc] init];
    self.dayModel.timeDayYear = self.dataDic[@"timeDayYear"];
    self.dayModel.timeHour = self.dataDic[@"timeHour"];
    self.dayModel.content = self.dataDic[@"content"];
    self.dayModel.category = self.dataDic[@"category"];
    // Do any additional setup after loading the view.
    self.title = self.dayModel.category;
    self.detailTab.tableHeaderView = [self tableViewHeadView];
    [self.detailTab reloadData];

    
}
- (void)creatNavItem {
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 25, 25);
    [btn1 setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 40, 30);
    [btn2 addTarget:self action:@selector(clickDelete:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setImage:[UIImage imageNamed:@"lajitong"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right1 = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(0, 0, 30, 30);
    [btn3 addTarget:self action:@selector(clickEditing:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn3 setImage:[UIImage imageNamed:@"bianji"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right2 = [[UIBarButtonItem alloc]initWithCustomView:btn3];
    
    self.navigationItem.rightBarButtonItems = @[right2,right1];
}

- (void)clickBack:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)clickDelete:(UIButton *)btn{
    AudioServicesPlaySystemSound(SOUNDID);
    //创建actionSheet对象
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Sure delete?" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"confirm" otherButtonTitles:nil, nil,nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
        NSMutableArray *dataArr = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
        
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary *alldic = dataArr[i];
            if ([alldic[@"content"] isEqualToString:self.dayModel.content]&&[alldic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[alldic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[alldic[@"category"] isEqualToString:self.dayModel.category]) {
                [dataArr removeObject:alldic];
                [[GlobalTool ShareInstance] savePlistWithName:@"all" data:dataArr];
                break;
                
            }
        }
        
        NSMutableArray *catArr;
        NSString *categoryString;
        
        
        if ([self.dayModel.category isEqualToString:@"Work"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"work"];
            categoryString = @"work";
        }
        
        if ([self.dayModel.category isEqualToString:@"Study"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"study"];
            categoryString = @"study";
        }
        
        if ([self.dayModel.category isEqualToString:@"Life"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"life"];
            categoryString = @"life";
        }
        
        if ([self.dayModel.category isEqualToString:@"Love"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"love"];
            categoryString = @"love";
        }
        
        
        
        for (int i = 0; i < catArr.count; i++) {
            NSDictionary *catdic = catArr[i];
            if ([catdic[@"content"] isEqualToString:self.dayModel.content]&&[catdic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[catdic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[catdic[@"category"] isEqualToString:self.dayModel.category]) {
                [catArr removeObject:catdic];
                [[GlobalTool ShareInstance] savePlistWithName:categoryString data:catArr];
                break;
            }
            
            
        }
        [[GlobalTool ShareInstance] showAlertWith:@"Delete successfully"];
        [self.navigationController popViewControllerAnimated:YES];
    }
    
    
    
}

- (void)clickEditing:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    ModifyViewController *modifyVc = [[ModifyViewController alloc] init];
    modifyVc.dataDic = self.dataDic;
    modifyVc.type = self.type;
    [self.navigationController pushViewController:modifyVc animated:YES];
}

- (UITableView *)detailTab {
    if (!_detailTab) {
        _detailTab = [[UITableView alloc] initWithFrame:self.view.frame];
        _detailTab.delegate = self;
        _detailTab.dataSource = self;
        _detailTab.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _detailTab.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
        [_detailTab registerNib:[UINib nibWithNibName:@"DayTableViewCell" bundle:nil] forCellReuseIdentifier:@"dayCell"];
        
    }
    
    return _detailTab;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.dayModel.cellHeight;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    DayTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dayCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.content = self.dataDic[@"content"];
    return cell;
}

- (UIView *)tableViewHeadView {
    UIView *head = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 35)];
    _timeDayYearLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 100, 30)];
    _timeDayYearLabel.text = self.dayModel.timeDayYear;
    _timeDayYearLabel.textColor = [UIColor grayColor];
    _timeDayYearLabel.font = [UIFont systemFontOfSize:15];
    _timeHourLabel = [[UILabel alloc] initWithFrame:CGRectMake(140, 0, 50, 30)];
    _timeHourLabel.text = self.dayModel.timeHour;
    _timeHourLabel.textColor = [UIColor lightGrayColor];
    _timeHourLabel.font = [UIFont systemFontOfSize:12];
    
    UIView *linView = [[UIView alloc] initWithFrame:CGRectMake(0, 34, self.view.frame.size.width, 1)];
    linView.backgroundColor = [UIColor lightGrayColor];
    [head addSubview:linView];
    [head addSubview:self.timeDayYearLabel];
    [head addSubview:self.timeHourLabel];
    
    return head;
}

@end
