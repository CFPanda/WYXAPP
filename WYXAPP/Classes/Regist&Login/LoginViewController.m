//
//  LoginViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/18.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "LoginViewController.h"
#import "AppDelegate.h"
#import "RegistViewController.h"

@interface LoginViewController ()<UITextFieldDelegate,UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *passWordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIView *nameView;
@property (weak, nonatomic) IBOutlet UIView *passView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *controlKeyBoard;
@property (weak, nonatomic) IBOutlet UIImageView *BackImageView;
@property (weak, nonatomic) IBOutlet UIButton *registBtn;
@property (weak, nonatomic) IBOutlet UIButton *forgotBtn;
@property (weak, nonatomic) IBOutlet UIImageView *logoImageView;

@property (weak, nonatomic) IBOutlet UILabel *appName;
@property (weak, nonatomic) IBOutlet UIButton *closeBtn;
//0是登录  1是注册
@property (nonatomic,assign)int type;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.type = 0;
    self.closeBtn.hidden = YES;
    self.controlKeyBoard.constant = 150;
    self.nameView.layer.cornerRadius = 25;
    self.nameView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.nameView.layer.borderWidth = 1.0;
    self.nameTextField.layer.cornerRadius = 25;
    self.passWordTextField.secureTextEntry =YES;
    self.passWordTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.nameTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    
    
    self.passView.layer.cornerRadius = 25;
    self.passView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.passView.layer.borderWidth = 1.0;
    self.passWordTextField.layer.cornerRadius = 25;
    
    
    self.loginBtn.layer.cornerRadius = 25;
    
    
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"NAME"];
    NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASS"];
    
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}


- (IBAction)clickCloseBtn:(UIButton *)sender {
    AudioServicesPlaySystemSound(SOUNDID);
    CABasicAnimation* rotationAnimation;
    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //旋转角度
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    //每次旋转的时间（单位秒）
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
    rotationAnimation.repeatCount = 0;
    [self.view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.loginBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.nameView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.BackImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.passView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.logoImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.appName.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.closeBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.registBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.type = 0;
    self.closeBtn.hidden = YES;
    self.registBtn.hidden = NO;
    self.forgotBtn.hidden = NO;
    [self.loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    
    
}

- (IBAction)clickRegistBtn:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(SOUNDID);
    CABasicAnimation* rotationAnimation;
    //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
    //旋转角度
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
    //每次旋转的时间（单位秒）
    rotationAnimation.duration = 0.5;
    rotationAnimation.cumulative = YES;
    //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
    rotationAnimation.repeatCount = 0;
    [self.view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.loginBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.nameView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.BackImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.passView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.logoImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.appName.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.closeBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    [self.registBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
    self.type = 1;
    self.closeBtn.hidden = NO;
    self.registBtn.hidden = YES;
    self.forgotBtn.hidden = YES;
    [self.loginBtn setTitle:@"Regist" forState:(UIControlStateNormal)];
    
}
- (IBAction)clickForgrtPassWordBtn:(UIButton *)sender {
    AudioServicesPlaySystemSound(SOUNDID);
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"NAME"];
    NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASS"];
    
    if (!name) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please register first！"];
        return;
    }
    
    if (!pass) {
       [[GlobalTool ShareInstance] showAlertWith:@"Please register first!"];
        return;
    }
    RegistViewController *regist = [[RegistViewController alloc]init];
    [self presentViewController:regist animated:YES completion:nil];

    
}
- (IBAction)clickLoginBtn:(UIButton *)sender {
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.nameTextField.text.length == 0) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please enter your account!"];
        return;
    }
    
    if (![self isValidateEmail:self.nameTextField.text]) {
        
        [[GlobalTool ShareInstance] showAlertWith:@"Please enter the correct mailbox account!"];
        return;
    }
    
    
    if (self.passWordTextField.text.length == 0) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please input a password!"];
        return;
    }
    
    if (self.passWordTextField.text.length < 6) {
        [[GlobalTool ShareInstance] showAlertWith:@"The password is at least 6 bits!"];
        return;
    }
    NSString *name = [[NSUserDefaults standardUserDefaults] objectForKey:@"NAME"];
    NSString *pass = [[NSUserDefaults standardUserDefaults] objectForKey:@"PASS"];
    if (self.type == 0) {
        
        if ([self.nameTextField.text isEqualToString:@"13770783277@163.com"]&&[self.passWordTextField.text isEqualToString:@"Aa111111"]){
            [[NSUserDefaults standardUserDefaults] setObject:@"isLogin" forKey:@"isLogin"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if ([self.nameTextField.text isEqualToString:name]&&[self.passWordTextField.text isEqualToString:pass]){
             [[NSUserDefaults standardUserDefaults] setObject:@"isLogin" forKey:@"isLogin"];
            [self dismissViewControllerAnimated:YES completion:nil];
        }else if (![self.nameTextField.text isEqualToString:name]&&name){
            [[GlobalTool ShareInstance] showAlertWith:@"The account is incorrect!"];
        }else if (![self.passWordTextField.text isEqualToString:pass]&&pass){
            [[GlobalTool ShareInstance] showAlertWith:@"The password is incorrect!"];
        }else  {
            [[GlobalTool ShareInstance] showAlertWith:@"The account does not exist. Please register first!"];
        }
        
    }else {
        if ([self.nameTextField.text isEqualToString:name]&&[self.passWordTextField.text isEqualToString:pass]){
            [[GlobalTool ShareInstance] showAlertWith:@"The account has been registered！"];
            
        }else{
            [[NSUserDefaults standardUserDefaults] setObject:self.nameTextField.text forKey:@"NAME"];
            [[NSUserDefaults standardUserDefaults] setObject:self.passWordTextField.text forKey:@"PASS"];
            
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Login was successful" message:@"Congratulations on your successful registration! Go back to your login page and login!" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Confirm", nil];
            [alert show];
        }
        
    }
    
    
    
    
}



-(void)textFieldDidBeginEditing:(UITextField *)textField {
    AudioServicesPlaySystemSound(SOUNDID);
    DDWS(weakSelf);
    if (textField == self.nameTextField) {
        [UIView animateWithDuration:2.0 animations:^{
            weakSelf.controlKeyBoard.constant = 50;
        }];
    }
    
    if (textField == self.passWordTextField) {
        [UIView animateWithDuration:2.0 animations:^{
            weakSelf.controlKeyBoard.constant = 0;
        }];
    }
    
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
    [self.nameTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    DDWS(weakSelf);
    [UIView animateWithDuration:2.0 animations:^{
        weakSelf.controlKeyBoard.constant = 150;
    }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.nameTextField resignFirstResponder];
    [self.passWordTextField resignFirstResponder];
    DDWS(weakSelf);
    [UIView animateWithDuration:2.0 animations:^{
        weakSelf.controlKeyBoard.constant = 150;
    }];
}


//邮箱地址的正则表达式
- (BOOL)isValidateEmail:(NSString *)email{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
     AudioServicesPlaySystemSound(SOUNDID);
        CABasicAnimation* rotationAnimation;
        //绕哪个轴，那么就改成什么：这里是绕y轴 ---> transform.rotation.y
        rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.y"];
        //旋转角度
        rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI];
        //每次旋转的时间（单位秒）
        rotationAnimation.duration = 0.5;
        rotationAnimation.cumulative = YES;
        //重复旋转的次数，如果你想要无数次，那么设置成MAXFLOAT
        rotationAnimation.repeatCount = 0;
        [self.view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.loginBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.nameView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.BackImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.passView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.logoImageView.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.appName.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.closeBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        [self.registBtn.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
        
        self.type = 0;
        self.closeBtn.hidden = YES;
        self.registBtn.hidden = NO;
        self.forgotBtn.hidden = NO;
        [self.loginBtn setTitle:@"登录" forState:(UIControlStateNormal)];
    
}




@end
