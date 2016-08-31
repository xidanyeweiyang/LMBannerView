//
//  ViewController.m
//  LMBannerView
//
//  Created by 刘明 on 16/8/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "ViewController.h"
#import "LMBannerView.h"

#define screenWidth [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<LMBannerViewDelegate>

@property (nonatomic, strong) LMBannerView *bannerView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    NSArray *imgNames = @[@"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/0B/05/ChMkJlcgdH2IVmv2AAYP2zcB7GQAAQr3gJjQtUABg_z016.jpg",
                          @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/0A/05/ChMkJ1cfEcmIZ2VvAAZMqeez-6YAAQn7wAeXgoABkzB552.jpg",
                          @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/00/01/ChMkJlZKi8eIRSR6ABB3m9XoGWcAAE_tgNqq6oAEHez310.jpg",
                          @"http://desk.fd.zol-img.com.cn/t_s208x130c5/g5/M00/01/00/ChMkJ1XNTGqISyLMAAJSFa0tK8sAAAEJACsrcwAAlIt345.jpg"];
    
    _bannerView = [[LMBannerView alloc] initWithFrame:CGRectMake(0, 64,[UIScreen mainScreen].bounds.size.width, 200) imageArray:imgNames andLoadSourceWays:LMBannerViewLoadSourceFromWeb];
    //设置代理
    _bannerView.delegate = self;
    
    [self.view addSubview:_bannerView];
   //设置属性
    
    _bannerView.showPageControl = YES;
    _bannerView.currentPageIndicatorTintColor = [UIColor orangeColor];
    _bannerView.pageIndicatorTintColor = [UIColor lightGrayColor];
    _bannerView.timeInterval = 1;
    
    //设置一些介绍性质label
    [self setupIntroduceLabel];

}


- (void)lmBannerView:(LMBannerView *)bannerView didSelctorItemWithIndex:(NSInteger)index{
    
    NSLog(@"点击了第 %zd 张图",index);
}


- (void)setupIntroduceLabel {
    UILabel *tittleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 300, screenWidth, 40)];
    tittleLabel.text = @"LMBannerView 使用步骤";
    tittleLabel.font = [UIFont systemFontOfSize:20];
    tittleLabel.textColor = [UIColor redColor];
    tittleLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:tittleLabel];
    
    UILabel *stepOneLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 350, screenWidth, 40)];
    stepOneLabel.text = @"stpe 1: 初始化LMBannerView";
    stepOneLabel.font = [UIFont systemFontOfSize:18];
    stepOneLabel.textColor = [UIColor orangeColor];
    stepOneLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:stepOneLabel];
    
    UILabel *stepTwoLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 400, screenWidth, 40)];
    stepTwoLabel.text = @"stpe 2: 设置LMBannerView对象的一些属性";
    stepTwoLabel.font = [UIFont systemFontOfSize:18];
    stepTwoLabel.textColor = [UIColor orangeColor];
    stepTwoLabel.textAlignment = NSTextAlignmentLeft;
    [self.view addSubview:stepTwoLabel];

    
}





@end
