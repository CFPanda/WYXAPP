//
//  DDTabbar.m
//  XXDNew
//
//  Created by 李胜书 on 2017/1/11.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "DDTabbar.h"

///帮助快速找到点击的view
static NSInteger tagPlusNumber = 300;
@implementation DDTabbar

- (id)initWithFrame:(CGRect)frame TitleArr:(NSArray *)titleArr DetailArr:(NSArray *)detailArr ShowLine:(BOOL)showLine {
    self = [super initWithFrame:frame];
    if (self) {
        CGFloat width;
        CGFloat height = frame.size.height/2;
        if (titleArr.count > 0) {
            width = frame.size.width/titleArr.count;
            [titleArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                UIView *backView = [[UIView alloc]initWithFrame:CGRectMake(idx*width, 0, width, frame.size.height)];
                backView.backgroundColor = [UIColor clearColor];
                backView.userInteractionEnabled = YES;
                UITapGestureRecognizer *tapView = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapIndexView:)];
                [backView addGestureRecognizer:tapView];
                backView.tag = idx + tagPlusNumber;
                [self addSubview:backView];
                
                self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, height)];
                self.titleLabel.text = obj;
                self.titleLabel.textAlignment = NSTextAlignmentCenter;
//                self.titleLabel.font = FourteenFont;
//                self.titleLabel.textColor = whiteBackColor;
                [backView addSubview:self.titleLabel];
                
//                UILabel *detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom, width, height)];
//                if (detailArr.count > idx) {
//                    detailLabel.text = detailArr[idx];
//                }
//                detailLabel.textAlignment = NSTextAlignmentCenter;
//                detailLabel.font = FourteenFont;
//                detailLabel.textColor = whiteBackColor;
//                detailLabel.tag = idx + 100;
////                detailLabel.numberOfLines = 0 ;
//                
//                [backView addSubview:detailLabel];
                
//                self.detailLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.titleLabel.x, self.titleLabel.bottom, width, height)];
//                if (detailArr.count > idx) {
//                    self.detailLabel.text = detailArr[idx];
//                }
//                self.detailLabel.textAlignment = NSTextAlignmentCenter;
//                self.detailLabel.font = littleWeightFont;
//                self.detailLabel.textColor = whiteBackColor;
//                
//                [backView addSubview:self.detailLabel];
                
                if (showLine) {
                    if (idx < titleArr.count - 1) {
                        self.lineView = [[UIView alloc]initWithFrame:CGRectMake(width - 1, 0, 1, frame.size.height)];
                        self.lineView.backgroundColor = [UIColor whiteColor];
                        [backView addSubview:self.lineView];
                    }
                }
            }];
        }
    }
    return self;
}

- (void)setupMoneyShowOrHidde:(NSArray *)moneyArr {
    
    [moneyArr enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [[self viewWithTag:idx + tagPlusNumber].subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull viewobj, NSUInteger objIdx, BOOL * _Nonnull objstop) {
            if ([viewobj isKindOfClass:[UILabel class]]) {
                if (viewobj.tag == idx + 100) {
                    ((UILabel *)viewobj).text = obj;
                    *objstop = YES;
                }
            }
        }];
//        [self.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull viewobj, NSUInteger idx, BOOL * _Nonnull stop) {
//            
//        }];
    }];
}

#pragma mark - support methods
- (void)tapIndexView:(UITapGestureRecognizer *)sender {
    UIView *tapView = sender.view;
    [_selectIndexDele selectTabbarIndex:tapView Index:tapView.tag - tagPlusNumber];
}

@end
