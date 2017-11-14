//
//  DDTabbar.h
//  XXDNew
//
//  Created by 李胜书 on 2017/1/11.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//
@protocol SelectTabbarIndex <NSObject>

@required
- (void)selectTabbarIndex:(UIView *)tabbar Index:(NSInteger)index;

@end

#import <UIKit/UIKit.h>

@interface DDTabbar : UIView

/**
 显示标题的label
 */
@property (nonatomic, strong) UILabel *titleLabel;
/**
 显示具体数据的label
 */
@property (nonatomic, strong) UILabel *detailLabel;
/**
 分割线
 */
@property (nonatomic, strong) UIView *lineView;
/**
 选择了第几个的delegate
 */
@property (nonatomic, weak) id<SelectTabbarIndex> selectIndexDele;
/**
 初始化DDTabbar

 @param frame 大小
 @param titleArr 标题数组，注意，标题数组决定显示几项
 @param detailArr 具体数值数组，注意，不能决定显示几项，并且如果少于标题数组，则会显示空，多于标题数组，则不显示
 @param showLine 是否显示分割线
 @return 创建
 */
- (id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr DetailArr:(NSArray *)detailArr ShowLine:(BOOL)showLine;

- (void)setupMoneyShowOrHidde:(NSArray *)moneyArr;

@end
