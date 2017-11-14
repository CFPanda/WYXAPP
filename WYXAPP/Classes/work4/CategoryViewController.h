//
//  CategoryViewController.h
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CategoryDelegate <NSObject>
- (void)getCategory:(NSString *)categoryString;
@end

@interface CategoryViewController : UIViewController
@property (nonatomic ,strong)NSArray *dataArr;
@property (nonatomic ,assign)id <CategoryDelegate>delegate;
@end
