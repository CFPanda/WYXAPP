//
//  DayTableViewCell.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/21.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DayTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (nonatomic ,strong)NSString *content;

@end
