//
//  NoDataView.h
//  XXDLoan
//
//  Created by duanchuanfen on 2017/8/4.
//  Copyright © 2017年 李胜书. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NoDataView : UIView

@property (nonatomic ,strong)NSString *titleString;
+(instancetype)noDataViewWithFrame:(CGRect)frame title:(NSString *)titleString;
@end
