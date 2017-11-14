//
//  SecondViewController.m
//  WYXAPP
//
//  Created by duanchuanfen on 2017/9/18.
//  Copyright © 2017年 DCFStrong. All rights reserved.
//

#import "SecondViewController.h"
#import "SecondTableViewCell.h"
#import "SecondModel.h"
#import "MySaveViewController.h"
#import "Model.h"
@interface SecondViewController ()<UITableViewDelegate,UITableViewDataSource,SecondCellDelegate>
@property(nonatomic ,strong)UITableView *secondTab;
@property(nonatomic ,strong)NSMutableArray *dataArr;
@property(nonatomic ,strong)NSMutableArray *data;
@property (nonatomic ,strong)NSMutableArray *dicDataArr;
@property (nonatomic ,strong)NSMutableArray *saveArr;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.dicDataArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.saveArr = [[NSMutableArray alloc] initWithCapacity:0];
    self.data = [[NSMutableArray alloc] initWithCapacity:0];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.secondTab];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 150, 30);
    [btn2 addTarget:self action:@selector(clickShouCang:) forControlEvents:(UIControlEventTouchUpInside)];
    [btn2 setTitle:@"My collection" forState:(UIControlStateNormal)];
    [btn2 setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    UIBarButtonItem  *right = [[UIBarButtonItem alloc]initWithCustomView:btn2];
    self.navigationItem.rightBarButtonItem = right;
    
    AFHTTPSessionManager  *session =  [AFHTTPSessionManager manager];
    session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects: @"application/json", @"text/json", @"text/javascript",@"text/html", nil];
    session.requestSerializer = [AFHTTPRequestSerializer serializer];
    session.responseSerializer = [AFHTTPResponseSerializer serializer];
    if (self.data.count > 0) {
        [self.data removeAllObjects];
    }
    
    if (self.dataArr.count > 0) {
        [self.dataArr removeAllObjects];
    }
    
    if (self.dicDataArr.count > 0) {
        [self.dicDataArr removeAllObjects];
    }
    [session GET:@"http://api.cctv.f5.works/api/english_school/v1/feed_items" parameters:@{@"limit":@"100"} progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        NSDictionary *dataDict = (NSDictionary *)[NSJSONSerialization JSONObjectWithData:responseObject options:(NSJSONReadingMutableLeaves) error:nil];
        
        
        Model *model = [Model mj_objectWithKeyValues:dataDict];
        for (int i = 0; i <model.data.count; i++) {
            SecondModel *secondModel = [SecondModel mj_objectWithKeyValues:model.data[i]];
            SecondSmallModel *smallModel = [SecondSmallModel mj_objectWithKeyValues:model.data[i][@"attributes"]];
            smallModel.itemId = secondModel.idNo;
            [self.data addObject:secondModel];
            [self.dicDataArr addObject:model.data[i][@"attributes"]];
            [self.dataArr addObject:smallModel];
            
        }
        [self.secondTab reloadData];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
    }];
    
    
    
    
}


- (void)clickShouCang:(UIButton *)btn {
    MySaveViewController *save = [[MySaveViewController alloc] init];
    [self.navigationController pushViewController:save animated:YES];
}

- (UITableView *)secondTab {
    if(!_secondTab){
        _secondTab = [[UITableView alloc] initWithFrame:self.view.bounds];
        _secondTab.delegate = self;
        _secondTab.dataSource = self;
        _secondTab.separatorStyle = UITableViewCellSeparatorStyleNone;
        [_secondTab registerNib:[UINib nibWithNibName:@"SecondTableViewCell" bundle:nil] forCellReuseIdentifier:@"secondCell"];
    }
    
    return _secondTab;
    
    
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"secondCell"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    SecondSmallModel *model;
    if (self.dataArr.count > 0) {
        model = self.dataArr[indexPath.row];
    }
    [cell cellShowDataWithModel:model];
    cell.delegate = self;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    SecondSmallModel *model;
    if (self.dataArr.count  > 0) {
        model = self.dataArr[indexPath.row];
    }
    return model.cellHeight;
}


- (void)clickBtnOnCell:(UIButton *)button with:(SecondTableViewCell *)secondCell{
    NSIndexPath *index = [self.secondTab indexPathForCell:secondCell];
    SecondSmallModel *model = self.dataArr[index.row];
    
    
    
    
    switch (button.tag) {
        case 101:
        {
            UIPasteboard*pasteboard = [UIPasteboard generalPasteboard];
            NSString *copyString = model.content_english;
            pasteboard.string = copyString;
            [[GlobalTool ShareInstance] showAlertWith:@"Text has been copied, hurry to hair status!"];

        }
            break;

        case 102:
        {
            self.saveArr = [[GlobalTool ShareInstance] getPlistWithName:@"shou"];
            if (!self.saveArr) {
                self.saveArr = [[NSMutableArray alloc] initWithCapacity:0];
            }
            NSDictionary *dict = self.dicDataArr[index.row];
            NSString *imageUrl = dict[@"image-url"];
            NSString *content = dict[@"content-english"];
            NSDictionary *dictSave = @{@"imageUrl":imageUrl,@"content":content};
            for (int i = 0; i < self.saveArr.count; i++) {
                NSDictionary *dict1 = self.saveArr[i];
                if ([dict1[@"content"] isEqual:dictSave[@"content"]]) {
                    [[GlobalTool ShareInstance] showAlertWith:@"You have already collected!"];
                    return;
                }

            }

            [self.saveArr addObject:dictSave];
            [[GlobalTool ShareInstance] savePlistWithName:@"shou" data:self.saveArr];
            [[GlobalTool ShareInstance] showAlertWith:@"Successful collection! You can check it in my collection!"];

        }
            break;

        case 103:
        {
            UIImage *share ;
             share = [self createShareImage:[UIImage imageNamed:@"dcf6.jpg"] with:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:model.image_url]]] Context:model.content_english];

            NSArray *images ;
            if (share) {
                images = @[share];
            }else {
                images = @[@"I am using short, come and join me to use it!"];
            }

            UIActivityViewController *activityController=[[UIActivityViewController alloc]initWithActivityItems:images applicationActivities:nil];
            [self.navigationController presentViewController:activityController animated:YES completion:nil];
        }
            break;

        default:
            break;
    }
    
}




// 1.将文字添加到图片上;imageName 图片名字， text 需画的字体
- (UIImage *)createShareImage:(UIImage *)tImage with:(UIImage *)shareImage Context:(NSString *)text
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    CGContextDrawPath(context, kCGPathStroke);
    
    
    NSMutableParagraphStyle *paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
    paragraphStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paragraphStyle.alignment = NSTextAlignmentCenter;
    
   
    
    UIFont  *font = [UIFont boldSystemFontOfSize:30];//定义默认字体
    //计算文字的宽度和高度：支持多行显示
    CGSize sizeText = [text boundingRectWithSize:CGSizeMake(imageSize.width, 100000)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{
                                                   NSFontAttributeName:font,//设置文字的字体
                                                   NSKernAttributeName:@10,//文字之间的字距
                                                   }
                                         context:nil].size;
    
    //为了能够垂直居中，需要计算显示起点坐标x,y
    CGRect rectText = CGRectMake((imageSize.width-sizeText.width)/2, imageSize.height*3/4+30, sizeText.width, sizeText.height);
    
    
    [text drawInRect:rectText withAttributes:@{ NSFontAttributeName :[ UIFont fontWithName : @"Arial-BoldMT" size : 30 ], NSForegroundColorAttributeName :[UIColor blackColor],NSParagraphStyleAttributeName:paragraphStyle} ];
    
    
    

    CGRect rect = CGRectMake( 0,0, imageSize.width, imageSize.height*3/4);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    [shareImage drawInRect:rect];
    
    
    
    
    
    
   
   
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


// 2.在图片上添加图片;imageName 1.底部图片名字imageName， image2 需添加的图片
- (UIImage *)createShareImage:(UIImage *)tImage ContextImage:(UIImage *)image2
{
    UIImage *sourceImage = tImage;
    CGSize imageSize; //画的背景 大小
    imageSize = [sourceImage size];
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.0);
    [sourceImage drawAtPoint:CGPointMake(0, 0)];
    //获得 图形上下文
    CGContextRef context=UIGraphicsGetCurrentContext();
    //画 自己想要画的内容(添加的图片)
    CGContextDrawPath(context, kCGPathStroke);
    
    CGRect rect = CGRectMake( imageSize.width/4,imageSize.height/5, imageSize.width/2, imageSize.height/2);
    CGContextAddEllipseInRect(context, rect);
    CGContextClip(context);
    
    [image2 drawInRect:rect];
    
    //返回绘制的新图形
    
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return newImage;
}


@end
