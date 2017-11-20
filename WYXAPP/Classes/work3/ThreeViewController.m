//
//  ThreeViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/18.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "ThreeViewController.h"
#import "SetAlertViewController.h"
#import "LoginViewController.h"
#import "RegistViewController.h"
#import "SafeViewController.h"
@interface ThreeViewController ()<UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate>
@property (strong, nonatomic)  UITableView *setTabView;

@end

@implementation ThreeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
   // Do any additional setup after loading the view.
    [self.view addSubview:self.setTabView];
//    self.view.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
    self.setTabView.scrollEnabled = NO;
    [self.view addSubview:self.setTabView];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"点击" forState:(UIControlStateNormal)];
    [button setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [button addTarget:self action:@selector(clickMe:) forControlEvents:(UIControlEventTouchUpInside)];
    button.frame = CGRectMake(0, 0, 100, 40);
    [self.view addSubview:button];
    
    
    
    
    [self creatLogoutBtn];
}
-(void)clickMe:(UIButton *)button {
    
}




- (void)creatLogoutBtn {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(40, ViewHeight - 150, ViewWidth - 80, 40);
//    btn.backgroundColor = [UIColor colorWithHexString:@"#FA8072"];
    [btn setTitle:@"Log out" forState:(UIControlStateNormal)];
    [btn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [btn addTarget:self action:@selector(clicklogout) forControlEvents:(UIControlEventTouchUpInside)];
    btn.layer.cornerRadius = 10;
    [self.view addSubview:btn];
}

- (void)clicklogout {
    
    
    //创建actionSheet对象
    UIActionSheet *sheet = [[UIActionSheet alloc]initWithTitle:@"Are you sure you want to log out?" delegate:self cancelButtonTitle:@"cancel" destructiveButtonTitle:@"confirm" otherButtonTitles:nil, nil,nil];
    //actionSheet样式
    sheet.actionSheetStyle = UIActionSheetStyleDefault;
    //显示
    [sheet showInView:self.view];
    
}


- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"isLogin"];
        // 去登录页面
        LoginViewController *login = [[LoginViewController alloc]init];
        [self.navigationController presentViewController:login animated:YES completion:nil];
    
    
    
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableView *)setTabView{
    if (!_setTabView) {
        _setTabView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - 20)];
        _setTabView.delegate = self;
        _setTabView.dataSource = self;
        _setTabView.showsVerticalScrollIndicator = NO;
        _setTabView.separatorStyle = UITableViewCellSeparatorStyleNone;
//        _setTabView.backgroundColor = [UIColor colorWithHexString:@"#FFE1FF"];
        _setTabView.scrollEnabled = NO;
        
    }
    return _setTabView;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return 1;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
//    cell.backgroundColor = [UIColor colorWithHexString:@"#F0FFF0"];
    UIImageView *leftimageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    [cell addSubview:leftimageView];
    
    UILabel*titlelabel = [[UILabel alloc]initWithFrame:CGRectMake(50, 15, 250, 20)];
    
    titlelabel.textColor = [UIColor grayColor];
    
    [cell addSubview:titlelabel];
    UIImage *lesfimage;
    switch (indexPath.section) {
        case 0:
        {
            lesfimage = [UIImage imageNamed:@"anquan"];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            titlelabel.text = @"Modify password";
            
        }
            break;
            
        case 1:
        {
            lesfimage = [UIImage imageNamed:@"闹钟"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            titlelabel.text = @"Notification reminder";
        }
            break;
            
        case 2:
        {
            lesfimage = [UIImage imageNamed:@"shenying"];
            UISwitch *sw = [[UISwitch alloc]initWithFrame:CGRectMake(self.view.frame.size.width - 70, 0, 50, 40)];
            sw.on = !([[[NSUserDefaults standardUserDefaults] objectForKey:@"isClose"] boolValue]);
            [sw addTarget:self action:@selector(closeSoundId:) forControlEvents:(UIControlEventValueChanged)];
            sw.center = CGPointMake(sw.center.x, cell.center.y);
            [cell addSubview:sw];
            titlelabel.text = @"Sound switch";
        }
            break;
            
        case 3:
        {
            lesfimage = [UIImage imageNamed:@"fenxiang"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            titlelabel.text = @"Share with friends";
        }
            break;
            
        case 4:
        {
            lesfimage = [UIImage imageNamed:@"haopin"];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; //显示最右边的箭头
            titlelabel.text = @"Praise and encouragement";
        }
            break;
            
            
        case 5:
        {
            lesfimage = [UIImage imageNamed:@"jianji"];
            NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
            // app名称
            NSString *app_Name = [infoDictionary objectForKey:@"CFBundleDisplayName"];
            // app版本
            NSString *app_Version = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
            titlelabel.text = [NSString stringWithFormat:@"About%@",app_Name];
            cell.detailTextLabel.text = [NSString stringWithFormat:@"version:%@",app_Version];
            cell.detailTextLabel.font = [UIFont systemFontOfSize:13];
        }
            break;
            
        case 6:{
            titlelabel.text = @"账户安全";
        }
           break;
        default:
            break;
    }
    
    leftimageView.image = lesfimage;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    AudioServicesPlaySystemSound(SOUNDID);
    switch (indexPath.section) {
        case 0:{
            RegistViewController *regist = [[RegistViewController alloc]init];
            regist.type = @"account";
            [self presentViewController:regist animated:YES completion:nil];
        }
            break;
            
        case 1:
        {
            SetAlertViewController *VC = [[SetAlertViewController alloc]init];
            VC.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:VC animated:YES];
        }
            break;
            
        case 2:
            
            break;
            
        case 3:{
            UIImage *share = [UIImage imageNamed:@"share.jpg"];
            NSArray *images ;
            if (share) {
                images = @[share];
            }else {
                images = @[@"我正在使用简记，快来一起使用吧~"];
            }
            
            UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
            [self.navigationController presentViewController:activityController animated:YES completion:nil];
        }
            break;
        case 4:
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:APP_URL]];
            break;
            
        case 5:
            
            break;
            
        case 6:{
            SafeViewController *safeVC = [[SafeViewController alloc] init];
            [self.navigationController pushViewController:safeVC animated:YES];
        }
            break;
            
        default:
            break;
    }
    
    
}



- (void)closeSoundId:(UISwitch*)sw {
    
    if (sw.on) {
        [[NSUserDefaults standardUserDefaults] setObject:@"0" forKey:@"isClose"];
        [[NSUserDefaults standardUserDefaults]setObject:@"1100" forKey:@"soundId"];
    }else{
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"soundId"];
        [[NSUserDefaults standardUserDefaults] setObject:@"1" forKey:@"isClose"];

    }
}

@end
