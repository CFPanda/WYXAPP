//
//  ModifyViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/21.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "ModifyViewController.h"
#import "CategoryViewController.h"
#import "DayModel.h"
#import "DayDetailViewController.h"
@interface ModifyViewController ()<UIPopoverPresentationControllerDelegate,CategoryDelegate,UITextViewDelegate,UIScrollViewDelegate,UIActionSheetDelegate>
@property (nonatomic ,assign)BOOL isSelected;
@property (nonatomic ,strong) UIButton *centerBtn;
@property (nonatomic ,strong) UILabel *labelSome;
@property (nonatomic ,strong)NSArray *dataArr;
@property (nonatomic ,strong)CategoryViewController *categoryVC;
@property (nonatomic ,strong)UITextView *textView;
@property (nonatomic,strong)DayModel* dayModel;

@end

@implementation ModifyViewController

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
    [btn2 addTarget:self action:@selector(clickXiuGai:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setImage:[UIImage imageNamed:@"baocun"] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = right;
    
    [self createCenterView];
    
    [self creatUI];
    [_textView becomeFirstResponder];
    
    
    self.dayModel = [[DayModel alloc] init];
    self.dayModel.timeDayYear = self.dataDic[@"timeDayYear"];
    self.dayModel.timeHour = self.dataDic[@"timeHour"];
    self.dayModel.content = self.dataDic[@"content"];
    self.dayModel.category = self.dataDic[@"category"];
    self.labelSome.text = self.dayModel.category;
    self.textView.text = self.dayModel.content;
    
    
    
}
- (void)creatUI{
    
    _textView = [[UITextView alloc] initWithFrame:self.view.bounds];
    _textView.delegate = self;
    _textView.font = [UIFont systemFontOfSize:16];
    [self.view addSubview:_textView];
    
}

- (NSArray *)dataArr {
    if (!_dataArr) {
        _dataArr = @[@"All",@"Work",@"Study",@"Life",@"Love"];
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

- (void)clickXiuGai:(UIButton *)btn{
    
    AudioServicesPlaySystemSound(SOUNDID);
    NSMutableArray *dataArr = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
    
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary *alldic = dataArr[i];
        if ([alldic[@"content"] isEqualToString:self.dayModel.content]&&[alldic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[alldic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[alldic[@"category"] isEqualToString:self.dayModel.category]) {
            [dataArr removeObject:alldic];
            NSDictionary *dict = @{@"timeDayYear":self.dayModel.timeDayYear,@"timeHour":self.dayModel.timeHour,@"content":self.textView.text,@"category":self.labelSome.text};
            self.dataDic = dict;
            [dataArr insertObject:dict atIndex:i];
            [[GlobalTool ShareInstance] savePlistWithName:@"all" data:dataArr];
            break;
            
        }
    }
    
    NSMutableArray *catArr;
    NSString *categoryString;
    
    
    if ([self.dayModel.category isEqualToString:@"Work"]) {
        catArr = [[GlobalTool ShareInstance] getPlistWithName:@"work"];
        categoryString = @"work";
    }
    
    if ([self.dayModel.category isEqualToString:@"Study"]) {
        catArr = [[GlobalTool ShareInstance] getPlistWithName:@"study"];
        categoryString = @"study";
    }
    
    if ([self.dayModel.category isEqualToString:@"Life"]) {
        catArr = [[GlobalTool ShareInstance] getPlistWithName:@"life"];
        categoryString = @"life";
    }
    
    if ([self.dayModel.category isEqualToString:@"Love"]) {
        catArr = [[GlobalTool ShareInstance] getPlistWithName:@"love"];
        categoryString = @"love";
    }
    
    
    
    for (int i = 0; i < dataArr.count; i++) {
        NSDictionary *catdic = dataArr[i];
        if ([catdic[@"content"] isEqualToString:self.dayModel.content]&&[catdic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[catdic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[catdic[@"category"] isEqualToString:self.dayModel.category]) {
            [catArr removeObject:catdic];
            NSDictionary *dict = @{@"timeDayYear":self.dayModel.timeDayYear,@"timeHour":self.dayModel.timeHour,@"content":self.textView.text,@"category":self.labelSome.text};
            self.dataDic = dict;
            [catArr insertObject:dict atIndex:i];
            [[GlobalTool ShareInstance] savePlistWithName:categoryString data:catArr];
            break;
        }
        
        
    }
    
    NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
    for (int i = 0; i < viewControllers.count; i++) {
        
        if ([viewControllers[i] isKindOfClass:[DayDetailViewController class]]) {
            DayDetailViewController * VC = (DayDetailViewController *)viewControllers[i];
            VC.type = 100;
            VC.dataDic = self.dataDic;
            
        }
    }
    [[GlobalTool ShareInstance] showAlertWith:@"Modify successfully!"];
    [self.navigationController popViewControllerAnimated:YES];
    
    
}


- (void)clickBack:(UIButton *)btn {
    AudioServicesPlaySystemSound(SOUNDID);
    if (![self.textView.text isEqualToString:self.dayModel.content]||![self.labelSome.text isEqualToString:self.dayModel.category]) {
        //创建actionSheet对象
        UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"你有修改内容未提交" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"保存修改" otherButtonTitles:@"放弃保存", nil,nil];
        //actionSheet样式
        sheet.actionSheetStyle = UIActionSheetStyleDefault;
        //显示
        [sheet showInView:self.view];
    }else {
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        for (int i = 0; i < viewControllers.count; i++) {
            
            if ([viewControllers[i] isKindOfClass:[DayDetailViewController class]]) {
            DayDetailViewController * VC = (DayDetailViewController *)viewControllers[i];
                VC.dataDic = self.dataDic;
            
            }
        }

      [self.navigationController popViewControllerAnimated:YES];
    }
    
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



- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 0) {
      
        
        NSMutableArray *dataArr = [[GlobalTool ShareInstance] getPlistWithName:@"all"];
        
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary *alldic = dataArr[i];
            if ([alldic[@"content"] isEqualToString:self.dayModel.content]&&[alldic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[alldic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[alldic[@"category"] isEqualToString:self.dayModel.category]) {
                [dataArr removeObject:alldic];
                NSDictionary *dict = @{@"timeDayYear":self.dayModel.timeDayYear,@"timeHour":self.dayModel.timeHour,@"content":self.textView.text,@"category":self.labelSome.text};
                self.dataDic = dict;
                [dataArr insertObject:dict atIndex:i];
                [[GlobalTool ShareInstance] savePlistWithName:@"all" data:dataArr];
                break;
                
            }
        }
        
        NSMutableArray *catArr;
        NSString *categoryString;
        
        
        if ([self.dayModel.category isEqualToString:@"Work"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"work"];
            categoryString = @"work";
        }
        
        if ([self.dayModel.category isEqualToString:@"Study"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"study"];
            categoryString = @"study";
        }
        
        if ([self.dayModel.category isEqualToString:@"Life"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"life"];
            categoryString = @"life";
        }
        
        if ([self.dayModel.category isEqualToString:@"Love"]) {
            catArr = [[GlobalTool ShareInstance] getPlistWithName:@"love"];
            categoryString = @"love";
        }
        
        
        
        for (int i = 0; i < dataArr.count; i++) {
            NSDictionary *catdic = dataArr[i];
            if ([catdic[@"content"] isEqualToString:self.dayModel.content]&&[catdic[@"timeDayYear"] isEqualToString:self.dayModel.timeDayYear]&&[catdic[@"timeHour"] isEqualToString:self.dayModel.timeHour]&&[catdic[@"category"] isEqualToString:self.dayModel.category]) {
                [catArr removeObject:catdic];
                NSDictionary *dict = @{@"timeDayYear":self.dayModel.timeDayYear,@"timeHour":self.dayModel.timeHour,@"content":self.textView.text,@"category":self.labelSome.text};
                self.dataDic = dict;
                [catArr insertObject:dict atIndex:i];
                [[GlobalTool ShareInstance] savePlistWithName:categoryString data:catArr];
                break;
            }
            
            
        }
        [[GlobalTool ShareInstance] showAlertWith:@"Modify successfully!"];
        
        NSMutableArray *viewControllers = [self.navigationController.viewControllers mutableCopy];
        for (int i = 0; i < viewControllers.count; i++) {
            
            if ([viewControllers[i] isKindOfClass:[DayDetailViewController class]]) {
                DayDetailViewController * VC = (DayDetailViewController *)viewControllers[i];
                VC.dataDic = self.dataDic;
                
            }
        }
        [self.navigationController popViewControllerAnimated:YES];
        
        
        
        
    }else if(buttonIndex == 1){
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}
@end
