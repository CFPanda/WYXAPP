//
//  RegistViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/18.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "RegistViewController.h"

@interface RegistViewController ()<UIAlertViewDelegate>
@property (weak, nonatomic) IBOutlet UIButton *sureBtn;

@property (weak, nonatomic) IBOutlet UITextField *passText;

@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property (weak, nonatomic) IBOutlet UITextField *sureNewPass;
@end

@implementation RegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.sureBtn.layer.cornerRadius = 20;
    self.backBtn.layer.cornerRadius = 20;
    
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)clickSureBtn:(UIButton *)sender {
    
    AudioServicesPlaySystemSound(SOUNDID);
    if (self.passText.text.length == 0) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please input a password!"];
        return;
    }
    
    if (self.passText.text.length < 6) {
        [[GlobalTool ShareInstance] showAlertWith:@"The password is at least 6 bits!"];
        return;
    }
    
    if (self.sureNewPass.text.length == 0) {
        [[GlobalTool ShareInstance] showAlertWith:@"Please confirm the password!"];
        return;
    }
    
    
    if (![self.passText.text isEqualToString:self.sureNewPass.text]) {
        [[GlobalTool ShareInstance] showAlertWith:@"The password for the two time is inconsistent!"];
        return;
    }
    
    
    [[NSUserDefaults standardUserDefaults] setObject:self.passText.text forKey:@"PASS"];
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Modify successfully" message:@"Change password successfully, login with new password ~" delegate:self cancelButtonTitle:nil otherButtonTitles:@"Determine", nil];
    [alert show];

}
- (IBAction)clickBackBtn:(UIButton *)sender {
    AudioServicesPlaySystemSound(SOUNDID);
     [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    AudioServicesPlaySystemSound(SOUNDID);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
