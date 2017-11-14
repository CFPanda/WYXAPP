//
//  SecondTableViewCell.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/25.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SecondModel.h"
@class SecondTableViewCell;
@protocol SecondCellDelegate <NSObject>
- (void)clickBtnOnCell:(UIButton *)button with:(SecondTableViewCell *)secondCell;
@end
@interface SecondTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *titleImage;
@property (weak, nonatomic) IBOutlet UIView *btnBackView;
@property (weak, nonatomic) IBOutlet UIButton *firstBtn;
@property (weak, nonatomic) IBOutlet UIButton *secondBtn;
@property (weak, nonatomic) IBOutlet UIButton *threeBtn;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleImageHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHight;

@property (nonatomic ,strong)SecondSmallModel *model;
@property (nonatomic ,weak)id<SecondCellDelegate>delegate;

@property (nonatomic ,strong)NSString *type;
- (void)cellShowDataWithModel:(SecondSmallModel *)model;
@end
