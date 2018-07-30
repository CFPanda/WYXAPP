//
//  DDNumberLabel.m
//  XXDNew
//
//  Created by 李胜书 on 2017/5/10.
//  Copyright © 2017年 Xinxindai. All rights reserved.
//

#import "DDNumberLabel.h"

@interface DDNumberLabel ()

{
    DDNumberClickBlock ddClickBlock;
}

@end

@implementation DDNumberLabel

- (instancetype)initWithFrame:(CGRect)frame RemindText:(NSString *)remindText ClickText:(NSString *)clickText ClickBlock:(DDNumberClickBlock)clickBlock {
    if (self = [super initWithFrame:frame]) {
        ddClickBlock = clickBlock;
        //dewieiohfoierhfoerferfr
//        CGSize firstPartSize = [[UtilSupportClass ShareInstance]CountFontSize:remindText FontSize:13.0];
//        CGFloat width = firstPartSize.width < frame.size.width ? firstPartSize.width : frame.size.width;
//        UILabel *remindLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, width, frame.size.height)];
//        remindLabel.textColor = grayFontColor;
//        remindLabel.font = [UIFont fontWithName:@"FZLTHK--GBK1-0" size:13.0];
//        remindLabel.text = remindText;
//        [self addSubview:remindLabel];
//        UIButton *clickBtn = [[UIButton alloc]initWithFrame:CGRectMake(remindLabel.right + 5, 0, frame.size.width - remindLabel.width - 5 , frame.size.height)];
//        [clickBtn setTitle:clickText forState:UIControlStateNormal];
//        [clickBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
//        [clickBtn setTitleColor:blueSelectColor forState:UIControlStateNormal];
//        [clickBtn addTarget:self action:@selector(click:) forControlEvents:UIControlEventTouchUpInside];
//        clickBtn.titleLabel.font = [UIFont fontWithName:@"FZLTHK--GBK1-0" size:13.0];
//        [self addSubview:clickBtn];
    }
    return self;
}

- (void)click:(UIButton *)sender {
    if (ddClickBlock) {
        ddClickBlock();
    }
}

@end
