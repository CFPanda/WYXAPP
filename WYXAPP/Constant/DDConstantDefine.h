//
//  DDConstantDefine.h
//  XXDNew
//
//  Created by 李胜书 on 2016/12/29.
//  Copyright © 2016年 Xinxindai. All rights reserved.
//

#ifndef DDConstantDefine_h
#define DDConstantDefine_h
#import <AudioToolbox/AudioToolbox.h>
#import <QuartzCore/QuartzCore.h>
////第三方库
//#import "Masonry.h"
//#import "AFNetworking.h"
//#import <POP/POP.h>
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
//#import "MBProgressHUD.h"
//#import "MJRefresh.h"
//#import "MJExtension.h"
//
////自己的category
#import "UIView+RedPointNumber.h"
#import "UIView+RoundCorner.h"
#import "UINavigationBar+Awesome.h"
#import "UIColor+Hex.h"
#import "UIButton+Ext.h"
#import "UILabel+DeleteFont.h"
#import "NSDictionary+stringToDic.h"
#import "NSArray+Extension.h"
#import "NSObject+Ext.h"
#import "NSString+Ext.h"
#import "UIImage+Ext.h"
#import "UIView+Extension.h"
#import "NSString+XXDWebSigh.h"
#import "UISearchBar+InitUI.h"
#import "NSString+Extension.h"
#import "NSURL+Scheme.h"
////第三方的vender
//#import "WPAttributedStyleAction.h"
//#import "WPHotspotLabel.h"
////第三方的categorys
//#import "NSString+WPAttributedMarkup.h"
////自定义帮助函数
////#import "GlobalUtil.h"
////#import "UtilSupportClass.h"
////#import "NsuserDefaultKeyName.h"
////#import "AFResponseHandle.h"
//#import "HttpCenter.h"
//#import "DataCenter.h"
//#import "DDWriteFileSupport.h"
//#import "BigDataRecordDic.h"
//#import "DDAnimationManager.h"
//#import "AkrHUD.h"
////数据库帮助函数
//#import "DDDBSearchHisManager.h"
////其他宏文件
//#import "DDConstantStr.h"
//#import "UIBarButtonItem+TTRightBarButtonItemBack.h"

//自定义宏

#define  ViewHeight [[UIScreen mainScreen] bounds].size.height
#define  ViewWidth [[UIScreen mainScreen] bounds].size.width
#define themeColor [UIColor colorWithHexString:@"#3671cf"]
#define whiteBackColor [UIColor colorWithHexString:@"#ffffff"]
#define bordColor [UIColor colorWithHexString:@"#f0f7ff"]
#define blackFontColor [UIColor colorWithHexString:@"#4d4d4d"]
#define lightgrayFontColor [UIColor colorWithHexString:@"#cccccc"]
#define grayBackColor [UIColor colorWithHexString:@"#f5f5f5"]
#define grayFontColor [UIColor colorWithHexString:@"#b2b2b2"]
#define blueSelectColor [UIColor colorWithHexString:@"#428af4"]
#define yellowRemindColor [UIColor colorWithHexString:@"#ff9e36"]
#define redProfitColor [UIColor colorWithHexString:@"#fd4545"]
#define blueBtnFontColor [UIColor colorWithHexString:@"#3f9bff"]
#define grayPacketColor [UIColor colorWithHexString:@"4c4c4c"]

#define grayTextColor [UIColor colorWithHexString:@"#cfd7e3"]
#define advanceSearchBtnColor [UIColor colorWithHexString:@"#e6e6e6"]  // 高级搜索里的button 主色

#define headerSeparatorColor [UIColor colorWithHexString:kHeaderViewSeparatorColor]
#define searchBarBackgroundColor [UIColor colorWithHexString:kSearchBarBackgroundColor]

#define RGBA_Color(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define RGB_Color(r, g, b) RGBA_Color((r), (g), (b), 1)

#define RGB_RedColor           RGB_Color(253, 69, 69)
#define RGB_QuitRedColor       RGB_Color(252, 126, 126)
#define RGB_DrakRedColor       RGB_Color(243, 71, 97)
#define RGB_GreenColor         RGB_Color(130, 217, 68)
#define RGB_LightGrayColor     RGB_Color(179, 179, 179)
#define RGB_GrayColor          RGB_Color(128, 128, 128)
#define RGB_MidGrayColor       RGB_Color(100, 100, 100)
#define RGB_DarkGrayColor      RGB_Color(77, 77, 77)
#define RGB_BlueColor          RGB_Color(63, 155, 255)
#define RGB_BlueMaskColor      RGB_Color(79, 163, 255)
#define RGB_LightBlueColor     RGB_Color(178, 214, 255)
#define RGB_FillColor          RGB_Color(250, 252, 255)
#define RGB_OrangeColor        RGB_Color(255, 186, 85)
#define RGB_LineGrayColor      RGB_Color(230, 230, 230)
#define RGB_SystemAlertBgColor RGB_Color(249, 249, 249)

#define SOUNDID  (unsigned int)[[[NSUserDefaults standardUserDefaults] objectForKey:@"soundId"] intValue]


#define APP_URL            @"http://itunes.apple.com/cn/app/id1296711811?mt=8"
///全局验证码长度
#define xxdMaxKeyLenth 4
///全局倒计时长度
#define smsCountTime 60
///全局圆角的数值
#define cornerRadis 3.0
///质保服务协议
#define serviceDetail NSLocalizedString(@"质保服务专款账户由银行托管，合法合规，拥抱监管", @"")
///最小的字体
#define leastSizeFont Font(9)
/// 十号
#define tenSizeFont Font(10)
///微小字体
#define littleSizeFont Font(12)
///微小粗体
#define littleWeightFont FontBlod(12)//[UIFont fontWithName:@".SFUIText-Bold" size:12]

#define FourteenFont Font(14)//[UIFont fontWithName:@".SFUIText-Bold" size:12]
#define FourteenBlodFont FontBlod(14)//[UIFont fontWithName:@".SFUIText-Bold" size:12]

///小字体
#define smallSizeFont Font(15)//[UIFont systemFontOfSize:15.0]
///小粗体
#define smallWeightFont FontBlod(15)//[UIFont fontWithName:@".SFUIText-Bold" size:15]
///中字体
#define middleSizeFont Font(18)
///中粗体
#define middleWeightFont FontBlod(18)//[UIFont fontWithName:@".SFUIText-Bold" size:18]
///大字体
#define bigSizeFont Font(24)
///大粗体
#define bigWeightFont FontBlod(24)//[UIFont fontWithName:@".SFUIText-Bold" size:24]

#define headerBoldFont FontBlod(kHeaderViewTextFont)//[UIFont boldSystemFontOfSize:kHeaderViewTextFont]

#define xxdDepartHeadIcon @"XXDDocHeadIcon.png"

#define DDWS(weakSelf)  __weak __typeof(&*self)weakSelf = self;

//#define xxdWechatID @"wx69a4ea875ce02bd2"



#define WEB_APP_URL         @"http://www.xinxindai.com/m"
#endif /* EHSYDeveloping_pch */

#ifndef DDLog
#if DEBUG
#define DDLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)
#else
#define DDLog(...)
#endif

#ifndef	BLOCK_SAFE
#define BLOCK_SAFE(block)           if(block)block//tim添加


#define CFAPPDELEGATE (AppDelegate *)[[UIApplication sharedApplication] delegate]
#endif

#endif /* DDConstantDefine_h */
