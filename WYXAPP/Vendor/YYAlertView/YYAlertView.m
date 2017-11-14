//
//  YYAlertView.m
//  imitate-UIAlertView
//
//  Created by 钱范儿-Developer on 16/6/15.
//  Copyright © 2016年 yinyong. All rights reserved.
//

#import "YYAlertView.h"

#define kWidth [UIScreen mainScreen].bounds.size.width * 0.6
#define kHeight [UIScreen mainScreen].bounds.size.height * 0.5

//the Title TopMargin plus the Message bottomMargin
#define kTitleMargin 20

//#define kMainWindow [UIApplication sharedApplication].windows.lastObject
#define kMainWindow [UIApplication sharedApplication].keyWindow


#define kTextColor [UIColor colorWithRed:35/255.0 green:137/255.0 blue:240/255.0 alpha:1]

@interface YYAlertView (){
    NSMutableArray      *_btnTitleArray;
    NSString            *_cancelBtnTitle;
    UIView              *_containerView;
}

@end

@implementation YYAlertView

#pragma mark - init Method : 初始化方法

- (instancetype)initWithTitle:(NSString *)title message:(NSString *)message delegate:(id)delegate cancelButtonTitle:(NSString *)cancelButtonTitle otherButtonTitles:(NSString *)otherButtonTitles, ...{
    
    YYAlertView *alertView = [self initWithFrame:CGRectZero];
    
    _title = title;
    _message = message;
    _delegate = delegate;

    _cancelBtnTitle = cancelButtonTitle;
    _btnTitleArray = [NSMutableArray array];
    if (otherButtonTitles) {
        [_btnTitleArray addObject:otherButtonTitles];
    }
    
    //get the all title : 拿到每一个title
    va_list args;
    va_start(args, otherButtonTitles);
    NSString *t;
    while ((t = va_arg(args, NSString*))) {
        [_btnTitleArray addObject:t];
    }
    
    return alertView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:kMainWindow.bounds];
    if (self) {
        
        CALayer *layer = [[CALayer alloc] init];
        layer.bounds = self.bounds;
        layer.position = CGPointMake(self.bounds.size.width * 0.5, self.bounds.size.height * 0.5);
        [self.layer addSublayer:layer];
//        self.backgroundColor = [kBlackColor colorWithAlphaComponent:0.2];
        self.hidden = YES;
        [kMainWindow addSubview:self];
    }
    return self;
}

- (instancetype)init{
    return [self initWithFrame:CGRectZero];
}

#pragma mark - show Method : 显示方法
- (void)show {
    
    if ([self.delegate respondsToSelector:@selector(willPresentAlertView:)]) {
        [self.delegate willPresentAlertView:self];
    }
    
    self.hidden = NO;
    
    if ([NSThread isMainThread]) {
        [self configSubView];
        [self showOnMainThread];
    }else{
        [self performSelectorOnMainThread:@selector(configSubView) withObject:nil waitUntilDone:NO];
        [self performSelectorOnMainThread:@selector(showOnMainThread) withObject:nil waitUntilDone:NO];
    }
    
    if ([self.delegate respondsToSelector:@selector(didPresentAlertView:)]) {
        [self.delegate didPresentAlertView:self];
    }
    
}

#pragma mark - set customView : 设置customView
- (void)setCustomView:(UIView *)customView {
    _customView = customView;
    _containerFrame = customView.frame;
}

#pragma mark - show The alertView : show方法
- (void)showOnMainThread {
    
//    self.backgroundColor = [kBlackColor colorWithAlphaComponent:0];
//    self.alpha = 0;
    
    CALayer *layer = self.layer.sublayers[0];
//    layer.backgroundColor = [kBlackColor colorWithAlphaComponent:0.2].CGColor;
    
    
    CAKeyframeAnimation *keyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
    
   // NSValue *key1 = [NSNumber numberWithFloat:1.0];
    NSValue *key2 = [NSNumber numberWithFloat:1.2];
    NSValue *key3 = [NSNumber numberWithFloat:1.0];
    
    NSArray *values = @[ key2, key3];
    keyFrameAnimation.values = values;
    
    keyFrameAnimation.duration = 0.1;
    keyFrameAnimation.beginTime = CACurrentMediaTime();
    
    [_containerView.layer addAnimation:keyFrameAnimation forKey:@"kcakeyFrameAnimation"];
    
}

#pragma mark - hide and remove alertView : 隐藏并移除容器视图
- (void)hiddenAndRemoveContainView {
    
    CALayer *layer = self.layer.sublayers[0];
//    layer.backgroundColor = [kBlackColor colorWithAlphaComponent:0.0].CGColor;
    
    [UIView animateWithDuration:0.1 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
//        self.backgroundColor = [kBlackColor colorWithAlphaComponent:0];
        _containerView.transform = CGAffineTransformScale(_containerView.transform, 0.8, 0.8);
        _containerView.alpha = 0.5;
    } completion:^(BOOL finished) {
        [_containerView removeFromSuperview];
        self.hidden = YES;
        
    }];

}

#pragma mark - hide Method : 隐藏方法
- (void)hiddenAlertView {
    if (![NSThread isMainThread]) {
        [self performSelectorOnMainThread:@selector(hiddenAndRemoveContainView) withObject:nil waitUntilDone:NO];
    }else {
        [self hiddenAndRemoveContainView];
    }
    
}

#pragma mark - setup subView : 配置子视图
- (void)configSubView {
    
    CGFloat lastViewMaxY = 0;
    
    //if you not set customView, you will get the Default alertView; 默认警告视图
    if (!_customView) {
        _containerView = [[UIView alloc] init];
        //    _containerView.backgroundColor = [kBlackColor colorWithAlphaComponent:0.0];
        _containerView.backgroundColor = [UIColor whiteColor];
        
        lastViewMaxY = [self setUpDefaultBtn];
    //else you just tell us you give us a containerView : 赋值容器视图
    }else{
        _containerView = _customView;
    }
    
    _containerView.layer.cornerRadius = 10;
    [self addSubview:_containerView];
    
    if (_containerFrame.size.width == 0 || _containerFrame.size.height == 0) {
        _containerView.frame = CGRectMake(0, 0, kWidth, lastViewMaxY);
    }else{
        _containerView.frame = self.containerFrame;
    }
    _containerView.center = kMainWindow.center;
    
    if (_customView) {
        
    }
    
    [self setNeedsLayout];
    [self setNeedsDisplay];
}

#pragma mark - setUp the btn : 配置button，默认是以initwithtitle初始化
- (CGFloat)setUpDefaultBtn {
    
    CGFloat lastViewMaxY = 0;
    CGFloat width;
    if (self.containerFrame.size.width == 0 || self.containerFrame.size.height == 0) {
        width = kWidth;
    }else{
        width = self.containerFrame.size.width;
    }
    
    if ([self isValidString:_title] || [self isValidString:_message]) {
        lastViewMaxY = kTitleMargin * 0.5;
    }
    
    //--------------title----------------
    if ([self isValidString:_title]) {
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, lastViewMaxY, width, 30)];
        titleLabel.text = _title;
        titleLabel.tag = 101;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [_containerView addSubview:titleLabel];
        lastViewMaxY = CGRectGetMaxY(titleLabel.frame);
        
    }
    
    //---------------message----------------
    if ([self isValidString:_message]) {
        UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.1, lastViewMaxY, width * 0.8, [self calcuateHeightFromMessage:_message])];
        detailLabel.text = _message;
        detailLabel.tag = 102;
        detailLabel.numberOfLines = 3;
        detailLabel.textAlignment = NSTextAlignmentCenter;
        detailLabel.font = [UIFont systemFontOfSize:14];
        [_containerView addSubview:detailLabel];
        lastViewMaxY = CGRectGetMaxY(detailLabel.frame);
        
    }
    
    if ([self isValidString:_title] || [self isValidString:_message]) {
        lastViewMaxY += kTitleMargin * 0.5;
    }
    
    if ([self isValidString:_cancelBtnTitle]) {
        
        UIButton *cancelBtn = [self createBtn];
        cancelBtn.tag = -1;
        [cancelBtn setTitle:_cancelBtnTitle forState:UIControlStateNormal];
        
        if (_btnTitleArray.count == 1) {
            cancelBtn.frame = CGRectMake(0, lastViewMaxY, width * 0.5, [self calcuateHeightForBtns]);
            
            //只有一个buttn
            UIButton *oneBtn = [self createBtn];
            oneBtn.tag = 1;
            oneBtn.frame = CGRectMake(width * 0.5, lastViewMaxY, width * 0.5, [self calcuateHeightForBtns]);
            [oneBtn setTitle:_btnTitleArray.firstObject forState:UIControlStateNormal];
            
            UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.5, lastViewMaxY + 8, 1, [self calcuateHeightForBtns] - 16)];
            line.backgroundColor = [UIColor lightGrayColor];
            [_containerView addSubview:line];
            
            [self addLineToContainer:lastViewMaxY];
            lastViewMaxY = CGRectGetMaxY(cancelBtn.frame);
        }
        
        else {
            cancelBtn.frame = CGRectMake(0, lastViewMaxY, width, [self calcuateHeightForBtns]);
            
            [self addLineToContainer:lastViewMaxY];
            lastViewMaxY = CGRectGetMaxY(cancelBtn.frame);
            
            int i = 1;
            if (_btnTitleArray.count > 1) {
                for (NSString *btnTitle in _btnTitleArray) {
                    UIButton *arrayBtn = [self createBtn];
                    arrayBtn.tag = i;
                    [arrayBtn setTitle:btnTitle forState:UIControlStateNormal];
                    arrayBtn.frame = CGRectMake(0, lastViewMaxY, width, [self calcuateHeightForBtns]);
                    
                    i ++;
                    [self addLineToContainer:lastViewMaxY];
                    lastViewMaxY = CGRectGetMaxY(arrayBtn.frame);
                }
            }
        }
        
        
    }
    
    else{
        
        int i = 1;
        if (_btnTitleArray.count > 0) {
            for (NSString *btnTitle in _btnTitleArray) {
                UIButton *arrayBtn = [self createBtn];
                arrayBtn.tag = i;
                [arrayBtn setTitle:btnTitle forState:UIControlStateNormal];
                arrayBtn.frame = CGRectMake(0, lastViewMaxY, width, [self calcuateHeightForBtns]);
                
                i ++;
                [self addLineToContainer:lastViewMaxY];
                lastViewMaxY = CGRectGetMaxY(arrayBtn.frame);
            }
        }
        
    }
    
    return lastViewMaxY;
}

#pragma mark - 配置label头

#pragma mark - creat specified button : 创建一个通用的按钮，并且已经加到容器中
- (UIButton*)createBtn{
    UIButton *btn = [[UIButton  alloc] init];
    [btn setTitleColor:kTextColor forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [_containerView addSubview:btn];
    return btn;
}

#pragma mark - creat the line : 创建一条线
- (void)addLineToContainer:(CGFloat)origanY{
    
    CGFloat width;
    if (self.containerFrame.size.width == 0 || self.containerFrame.size.height == 0) {
        width = kWidth;
    }else{
        width = self.containerFrame.size.width;
    }
    
    UILabel *line = [[UILabel alloc] initWithFrame:CGRectMake(width * 0.1, origanY, width * 0.8, 1)];
    line.backgroundColor = [UIColor lightGrayColor];
    [_containerView addSubview:line];
}

#pragma mark - calcuate the message'height with specified attributes : 计算给定的message的高度
- (CGFloat)calcuateHeightFromMessage:(NSString*)message{
    
    CGSize size;
    if (self.containerFrame.size.height == 0) {
        size = CGSizeMake(kWidth * 0.8, kHeight);
    }else{
        size = self.containerFrame.size;
    }
    
    if (![self isValidString:message]) {
        return 0;
    }
    
    return [message boundingRectWithSize:size options:NSStringDrawingUsesFontLeading |  NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
}

#pragma mark - calcuate the height of the button : 计算每个按钮的高度
- (CGFloat)calcuateHeightForBtns{
    if (self.containerFrame.size.height == 0 && self.containerFrame.size.width == 0) {
        return 40;
    }else{
        
        if ([self isValidString:_cancelBtnTitle]) {
            if ((_btnTitleArray == nil) || (_btnTitleArray.count < 2)) {
                //如果有一个按钮，取消按钮在内
                return (self.containerFrame.size.height - [self calcuateHeightForTitleHeader]);
            }else{
                return (self.containerFrame.size.height - [self calcuateHeightForTitleHeader]) / (_btnTitleArray.count + 1.0);
            }
        }
        
        else{
            if (_btnTitleArray == nil) {
                return 0;
            }
            else{
                 return (self.containerFrame.size.height - [self calcuateHeightForTitleHeader]) / (_btnTitleArray.count * 1.0);
            }
        }
    }
}

#pragma mark - get the height of the title header and the messge header : 获取头部title和message的高度
- (CGFloat)calcuateHeightForTitleHeader{
    if ([self isValidString:_title]) {
        return 30 + [self calcuateHeightFromMessage:_message] + kTitleMargin;
    }else{
        if ([self isValidString:_message]) {
            return [self calcuateHeightFromMessage:_message] + kTitleMargin;
        }
        return [self calcuateHeightFromMessage:_message];
    }
}

#pragma mark - judege the valibale of the string : 判断字符串是否有效（排除都是空格的情况)
- (BOOL)isValidString:(NSString*)string{
    if (!string || string.length == 0) {
        return NO;
    }
    if ([string rangeOfString:@" "].length > 0) {
        NSString *str = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
        if (str.length == 0) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - click the button event : 点击按钮后触发的方法
- (void)clickBtn:(UIButton*)sender {
    NSLog(@"点击了哦%@",sender);
    
    if ([self.delegate respondsToSelector:@selector(alertView:willDismissWithButtonIndex:)]) {
        [self.delegate alertView:self willDismissWithButtonIndex:sender.tag];
    }
    
    if ([self.delegate respondsToSelector:@selector(YYAlertView:clickedButtonAtIndex:)]) {
        [self.delegate YYAlertView:self clickedButtonAtIndex:sender.tag];
    }
    
    [self hiddenAlertView];
    
    if ([self.delegate respondsToSelector:@selector(alertView:didDismissWithButtonIndex:)]) {
        [self.delegate alertView:self didDismissWithButtonIndex:sender.tag];
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
