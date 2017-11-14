//
//  WebViewController.m
//  CFAPP
//
//  Created by duanchuanfen on 2017/8/16.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "WebViewController.h"
#import "FirstViewController.h"
#import "SecondViewController.h"
#import "ThreeViewController.h"
#import "LoginViewController.h"
@interface WebViewController ()<UIWebViewDelegate>
@property (nonatomic ,strong)UIWebView *webView;
@end

@implementation WebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webView];
    // Do any additional setup after loading the view.
    [self startToListenNow];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (UIWebView *)webView {
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
        _webView.backgroundColor = [UIColor whiteColor];
        _webView.delegate = self;
      
     }
    return _webView;
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    NSURL *url =request.URL;
    NSString *urString = url.absoluteString;
    if ([urString hasSuffix:@"mt=8"]) {
        [[UIApplication sharedApplication] openURL:url];
    }
    
    return YES;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    if (error.code  == -101) {
        return;
    }
}

//网络监听
-(void)startToListenNow
{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
            {
                [self tryToLoad];
            }
                break;
            default:
                break;
        }
    }];
    //开始监听
    [manager startMonitoring];
}



-(void)tryToLoad {
    NSURL *url1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://appmgr.jwoquxoc.com/frontApi/getAboutUs"]];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url1];
    request.timeoutInterval = 5.0;
    request.HTTPMethod = @"post";
    
    NSString *param = [NSString stringWithFormat:@"appid=%@",@"c66app296"];
    request.HTTPBody = [param dataUsingEncoding:NSUTF8StringEncoding];
    NSURLResponse *response;
    NSError *error;
    NSData *backData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    if (error) {
        //[self setupContentVC];
        self.urlString = @"";
        //        [self createHtmlViewControl];
    }else{
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:backData options:NSJSONReadingMutableContainers error:nil];
        
        NSLog(@"dic======%@",dic);
        if ([[dic objectForKey:@"status"] intValue]== 1) {
            NSLog(@"获取数据成功%@%@",[dic objectForKey:@"desc"],[dic objectForKey:@"appname"]);//
            self.urlString =  ([[dic objectForKey:@"isshowwap"] intValue]) == 1?[dic objectForKey:@"wapurl"] : @"";
            
            if ([self.urlString isEqualToString:@""]) {
                
                self.urlString = @"";
                
            }else{
                NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:_urlString]];
                [_webView loadRequest:request];
            }
        }else if ([[dic objectForKey:@"status"] intValue]== 2) {
            NSLog(@"获取数据失败");
            
            self.urlString = @"";
            
        }else{
            
            self.urlString = @"";
        }
    }
    
   
    if (self.urlString.length == 0) {
        [self loadCtr];
    }
}


- (void)loadCtr {
    
   
  
        FirstViewController *first = [[FirstViewController alloc]init];
        first.tabBarItem.title = @"Record";
        
        first.tabBarItem.image=[[UIImage imageNamed:@"day"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        first.tabBarItem.selectedImage = [[UIImage imageNamed:@"daySelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *firstNav = [[UINavigationController alloc] initWithRootViewController:first];
        
        
        SecondViewController *second = [[SecondViewController alloc]init];
        second.tabBarItem.title = @"Rhesis";
        second.tabBarItem.image=[[UIImage imageNamed:@"look"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        second.tabBarItem.selectedImage = [[UIImage imageNamed:@"lookSelect"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *secondNav = [[UINavigationController alloc] initWithRootViewController:second];
        
        ThreeViewController *three = [[ThreeViewController alloc]init];
        three.tabBarItem.title = @"My";
        three.tabBarItem.image=[[UIImage imageNamed:@"user1"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        three.tabBarItem.selectedImage = [[UIImage imageNamed:@"user1Select"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *threeNav = [[UINavigationController alloc] initWithRootViewController:three];
        
        
        UITabBarController *tabCtr = [[UITabBarController alloc]init];
        tabCtr.viewControllers = @[firstNav,secondNav,threeNav];
        [UIApplication sharedApplication].keyWindow.rootViewController = tabCtr;
        
        NSString *isLogin = [[NSUserDefaults standardUserDefaults] objectForKey:@"isLogin"];
        
        if (isLogin.length == 0 ){
            //未登录 去登录页面
            LoginViewController *login = [[LoginViewController alloc]init];
            [[UIApplication sharedApplication].keyWindow.rootViewController  presentViewController:login animated:YES completion:^{
                
                
            }];
            
        }
        
    }


@end
