//
//  WriteViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/20.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "WriteViewController.h"
#import "CategoryViewController.h"
#import "DayModel.h"
@interface WriteViewController ()<UIPopoverPresentationControllerDelegate,CategoryDelegate,UITextViewDelegate,UIScrollViewDelegate>
@property (nonatomic ,assign)BOOL isSelected;
@property (nonatomic ,strong) UIButton *centerBtn;
@property (nonatomic ,strong) UILabel *labelSome;
@property (nonatomic ,strong)NSArray *dataArr;
@property (nonatomic ,strong)CategoryViewController *categoryVC;
@property (nonatomic ,strong)UITextView *textView;
@property (nonatomic ,assign)int type;

@end

@implementation WriteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(0, 0, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"fanhui"] forState:(UIControlStateNormal)];
    [btn1 addTarget:self action:@selector(clickBack:) forControlEvents:(UIControlEventTouchUpInside)];
    UIBarButtonItem  *left = [[UIBarButtonItem alloc]initWithCustomView:btn1];
    self.navigationItem.leftBarButtonItem = left;
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 30, 30);
    [btn2 addTarget:self action:@selector(clickBaoCun:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setImage:[UIImage imageNamed:@"baocun"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createCenterView];
    
    [self creatUI];
    [_textView becomeFirstResponder];
    
    

}
- (void)creatUI{
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_textView];
    
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"All",@"Work",@"Study",@"Life",@"Love"];;
    }
    
    return _dataArr;
}

- (void)createCenterView {
    
    UIView *viewSome = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 90, 30)];
    
    _labelSome = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 60, 30)];
    _labelSome.text = @"All";
     self.type = 0;
    _labelSome.textColor = [UIColor whiteColor];
    _labelSome.numberOfLines = 0;
    _labelSome.textAlignment = NSTextAlignmentCenter;
    _centerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    _centerBtn.frame = CGRectMake(60,7.5,15, 15);
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    [_centerBtn addTarget:self action:@selector(clickBtn:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [viewSome addSubview:_centerBtn];
    [viewSome addSubview:_labelSome];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:(@selector(chooesCategory:))];
    [viewSome addGestureRecognizer:tap];
    self.navigationItem.titleView = viewSome;
    
    
   
}

- (void)clickBaoCun:(UIButton *)btn{
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.textView.text.length == 0) {
        [[GlobalTool ShareInstance] showAlertWith:@"You haven't entered the content yet!"];
        return;
    }
    
    
    NSDictionary *dict = @{@"timeDayYear":[[GlobalTool ShareInstance] timeWithYearTimeIntervalString:[NSDate date]],@"timeHour":[[GlobalTool ShareInstance] timeWithHourTimeIntervalString:[NSDate date]],@"content":self.textView.text,@"category":self.labelSome.text};
    
    NSMutableArray *marrAll = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
    if (!marrAll) {
        marrAll = [[NSMutableArray alloc] initWithCapacity:0];
        }
    [marrAll insertObject:dict atIndex:0];
    [[GlobalTool ShareInstance] savePlistWithName:@"all" data:marrAll];
    
    if (![self.labelSome.text isEqualToString:@"All"]) {
        NSMutableArray *marrCat;
        switch (self.type) {
            case 1:
                marrCat = [[GlobalTool ShareInstance] getPlistWithName:@"work"];
                break;
                
            case 2:
                marrCat = [[GlobalTool ShareInstance] getPlistWithName:@"study"];
                break;
                
            case 3:
                marrCat = [[GlobalTool ShareInstance] getPlistWithName:@"life"];
                break;
                
            case 4:
                marrCat = [[GlobalTool ShareInstance] getPlistWithName:@"love"];
               break;
                
            default:
                break;
        }

        
        if (!marrCat) {
            marrCat = [[NSMutableArray alloc] initWithCapacity:0];
        }
        [marrCat insertObject:dict atIndex:0];
        switch (self.type) {
            case 1:
                [[GlobalTool ShareInstance] savePlistWithName:@"work" data:marrCat];
                break;
                
            case 2:
                [[GlobalTool ShareInstance] savePlistWithName:@"study" data:marrCat];
                break;
                
            case 3:
                [[GlobalTool ShareInstance] savePlistWithName:@"life" data:marrCat];
                break;
                
            case 4:
                [[GlobalTool ShareInstance] savePlistWithName:@"love" data:marrCat];
                break;
                
            default:
                break;
        }
        
        
    }
    
    [[GlobalTool ShareInstance] showAlertWith:@"Save successfully!"];
    [self.navigationController popViewControllerAnimated:YES];


}


- (void)clickBack:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)chooesCategory:(UITapGestureRecognizer *)tap {
    self.isSelected = !self.isSelected;
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.isSelected) {
        
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantoux"] forState:(UIControlStateNormal)];
        _categoryVC = [[CategoryViewController alloc]init];
        _categoryVC.modalPresentationStyle = UIModalPresentationPopover;
        _categoryVC.view.backgroundColor = [UIColor colorWithHexString:@"#E066FF" alpha:0.5];
        _categoryVC.delegate = self;
        _categoryVC.dataArr = self.dataArr;
        _categoryVC.preferredContentSize = CGSizeMake(200, 300);//设置弹出控制器视图的大小
        _categoryVC.popoverPresentationController.sourceView = _labelSome;
        _categoryVC.popoverPresentationController.sourceRect = _labelSome.bounds;
        _categoryVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        _categoryVC.popoverPresentationController.delegate = self;
        [self presentViewController:_categoryVC animated:YES completion:nil];
        
    }else {
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    }
    
}

- (void)clickBtn:(UIButton *)sender {
    self.isSelected = !self.isSelected;
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.isSelected) {
        
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        [_centerBtn setImage:[UIImage imageNamed:@"jiantoux"] forState:(UIControlStateNormal)];
        _categoryVC = [[CategoryViewController alloc]init];
        _categoryVC.modalPresentationStyle = UIModalPresentationPopover;
        _categoryVC.view.backgroundColor = [UIColor colorWithHexString:@"#E066FF" alpha:0.5];
        _categoryVC.dataArr = self.dataArr;
        _categoryVC.delegate = self;
        _categoryVC.preferredContentSize = CGSizeMake(200, 300);//设置弹出控制器视图的大小
        _categoryVC.popoverPresentationController.sourceView = _labelSome;
        _categoryVC.popoverPresentationController.sourceRect = _labelSome.bounds;
        _categoryVC.popoverPresentationController.permittedArrowDirections = UIPopoverArrowDirectionUp;
        _categoryVC.popoverPresentationController.delegate = self;
        [self presentViewController:_categoryVC animated:YES completion:nil];
        
    }else {
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.3;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    }
    
}

-(UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller{
    return UIModalPresentationNone; //不适配
}

- (BOOL)popoverPresentationControllerShouldDismissPopover:(UIPopoverPresentationController *)popoverPresentationController{
    self.isSelected = !self.isSelected;
    CABasicAnimation* rotationAnimation;
    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    //旋转角度
    rotationAnimation.toValue = [NSNumber numberWithFloat: 0.5*M_PI];
    //每次旋转的时间（单位秒）
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
    rotationAnimation.repeatCount = 0;
    [_centerBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    [_centerBtn setImage:[UIImage imageNamed:@"jiantous"] forState:(UIControlStateNormal)];
    
    return YES;   //点击蒙版popover消失， 默认YES
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getCategory:(NSString *)categoryString {
    AudioServicesPlaySystemSound(SOUNDID);
    [self.categoryVC dismissViewControllerAnimated:YES completion:nil];
    [self popoverPresentationControllerShouldDismissPopover:_categoryVC.popoverPresentationController];
    _labelSome.text = categoryString;
    if ([categoryString isEqualToString:@"Work"]) {
        self.type = 1;
    }
    
    if ([categoryString isEqualToString:@"Study"]) {
        self.type = 2;
    }
    
    if ([categoryString isEqualToString:@"Life"]) {
        self.type = 3;
    }
    
    if ([categoryString isEqualToString:@"Love"]) {
        self.type = 4;
    }
}

@end
