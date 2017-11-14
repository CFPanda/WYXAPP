//
//  CategoryViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "CategoryViewController.h"
@interface CategoryViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *categoryTab;
@end
@implementation CategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.categoryTab];
    
    
}

- (UITableView *)categoryTab {
    if (!_categoryTab) {
        _categoryTab = [[UITableView alloc]initWithFrame:self.view.bounds];
        _categoryTab.delegate = self;
        _categoryTab.dataSource = self;
        
    }
    
    return _categoryTab;
}

- (void)setDataArr:(NSArray *)dataArr {
    _dataArr = dataArr;
    [self.categoryTab reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _dataArr.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *indentify = @"cellId";
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:indentify];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:(UITableViewCellStyleDefault) reuseIdentifier:indentify];
    }
    cell.textLabel.text = _dataArr[indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (self.delegate &&[self.delegate respondsToSelector:@selector(getCategory:)]) {
        [self.delegate getCategory:_dataArr[indexPath.row]];
    }
    
}
@end
