//
//  YYAlertView.h
//  imitate-UIAlertView
//
//  Created by 钱范儿-Developer on 16/6/15.
//  Copyright © 2016年 yinyong. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YYAlertView;

@protocol YYAlertViewDelegate <NSObject>

@optional

// Called when a button is clicked. The view will be automatically dismissed after this call returns
- (void)YYAlertView:(nullable YYAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;

- (void)willPresentAlertView:(nullable YYAlertView *)alertView;  // before animation and showing view

- (void)didPresentAlertView:(nullable YYAlertView *)alertView;  // after animation

- (void)alertView:(nullable YYAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; // before animation and hiding view

- (void)alertView:(nullable YYAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;  // after animation

@end

@interface YYAlertView : UIView

- (nullable instancetype)initWithTitle:(nullable NSString *)title message:(nullable NSString *)message delegate:(nullable id /*<UIAlertViewDelegate>*/)delegate cancelButtonTitle:(nullable NSString *)cancelButtonTitle otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

//- (nonnull instancetype)initWithFrame:(CGRect)frame;

@property (nonatomic, assign) CGRect containerFrame;

@property(nullable,nonatomic,weak) id <YYAlertViewDelegate> delegate;

@property(nullable,nonatomic,copy) NSString *title;

@property(nullable,nonatomic,copy) NSString *message;   // secondary explanation text

/**
 * set customView, you need to set its frame, which you don't need to care about its origin; certainly you should add method hiddenAlertView in your event which you handle the event you want to hidden this alertView;
 * 设置自定义视图，需要设置它的frame，你不需要考虑它的原点；当然，你使用了自定义视图时，你需要使用hiddenAlertView来隐藏这个alertView；
 */

@property (nullable, nonatomic, strong) UIView *customView;

/**
 * hidden this alertView : 隐藏这个视图
 */
- (void)hiddenAlertView;

// shows popup alert animated.
- (void)show;



@end
