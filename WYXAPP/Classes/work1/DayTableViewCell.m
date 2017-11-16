//
//  DayTableViewCell.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/21.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "DayTableViewCell.h"

@implementation DayTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
//    self.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
//    self.contentView.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
    
}

- (void)setContent:(NSString *)content {
    _content = content;
    self.contentLabel.text = _content;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
