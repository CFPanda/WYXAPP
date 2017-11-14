//
//  FirstTableViewCell.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FirstTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *timeDayLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeHourlabel;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
