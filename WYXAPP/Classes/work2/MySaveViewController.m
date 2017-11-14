//
//  MySaveViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/26.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "MySaveViewController.h"
#import "SecondTableViewCell.h"
#import "SecondModel.h"
@interface MySaveViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic ,strong)UITableView *secondTab;
@property(nonatomic ,strong)NSMutableArray *dataArr;
@property (nonatomic ,strong)NSMutableArray *dicDataArr;
@property (nonatomic ,strong)NSMutableArray *saveArr;

@end

@implementation MySaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"My collection";
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 25, 25);
    [btn1 setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    
    // Do any additional setup after loading the view.
    [self.view addSubview:self.secondTab];
    self.saveArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.saveArr = [[GlobalTool ShareInstance] getPlistWithName:@"shou"];
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    for (int i = 0; i < self.saveArr.count; i++) {
        SecondSmallModel *model = [[SecondSmallModel alloc]init];
        model.image_url = self.saveArr[i][@"imageUrl"];
        model.content_english = self.saveArr[i][@"content"];
        [self.dataArr addObject:model];
    }
}

- (void)clickBack:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)secondTab {
    if(!_secondTab){
        _secondTab = [[UITableView alloc] initWithFrame:self.view.bounds];
        _secondTab.delegate = self;
        _secondTab.dataSource = self;
        _secondTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_secondTab registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"secondCell"];
    }
    
    return _secondTab;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.btnBackView.hidden = YES;
    SecondSmallModel *model = self.dataArr[indexPath.row];
    [cell cellShowDataWithModel:model];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondSmallModel *model = self.dataArr[indexPath.row];
    return model.cellHeight - 40;
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
