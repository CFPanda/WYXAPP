//
//  SecondTableViewCell.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/25.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "SecondTableViewCell.h"

@implementation SecondTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
   
    //给bgView边框设置阴影
    self.backView.layer.shadowOffset = CGSizeMake(0,0);
    self.backView.layer.shadowOpacity = 0.3;
    self.backView.layer.cornerRadius = 3;
    self.backView.layer.shadowColor = [UIColor blackColor].CGColor;
    self.backView.layer.cornerRadius = 5;
    self.btnBackView.layer.cornerRadius = 3;
    self.btnBackView.layer.borderWidth = 1;
    self.btnBackView.layer.borderColor = [UIColor whiteColor].CGColor;
   
}

- (void)cellShowDataWithModel:(SecondSmallModel *)model{
    _model = model;
    
   
        [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.image_url] placeholderImage:[UIImage imageNamed:@"placehold.png"]];
        self.titleHight.constant = [model.content_english boundingRectWithSize:CGSizeMake(ViewWidth - 40, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:16]} context:nil].size.height;
        if (![self includeChinese:model.content_english]) {
            self.titleLabel.text = model.content_english;
        }else if (![self includeChinese:model.content_chinese]){
            self.titleLabel.text = model.content_chinese;
            if (model.content_chinese.length == 0) {
                self.titleLabel.text  = @"Tomorrow is better!";
            }
        }else {
            self.titleLabel.text  = @"Tomorrow is better!";
        }
   
   
    
    
    if (model.isShouCang) {
        [self.secondBtn setTitleColor:[UIColor grayColor] forState:(UIControlStateNormal)];
        [self.secondBtn setEnabled:NO];
        [self.secondBtn setTitle:@"shoucang" forState:(UIControlStateNormal)];
    }
    
    
}
- (IBAction)clickBtn:(UIButton *)sender {

    if (self.delegate&&[self.delegate respondsToSelector:@selector(clickBtnOnCell:with:)]) {
        [self.delegate clickBtnOnCell:sender with:self];
    }
}


- (BOOL)isChinese:(NSString *)string
{
    NSString *match = @"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:string];
}

- (BOOL)includeChinese:(NSString *)string
{
    for(int i=0; i< [string length];i++)
    {
        int a =[string characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}


@end
