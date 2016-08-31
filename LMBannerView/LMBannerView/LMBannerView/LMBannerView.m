//
//  LMBannerView.m
//  LMBannerView
//
//  Created by 刘明 on 16/8/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import "LMBannerView.h"
#import "UIImageView+WebCache.h"

@interface LMBannerView ()


@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UIPageControl *pageControl;

@property (nonatomic, strong) NSTimer *timer;


@end

@implementation LMBannerView
{
    CGFloat     kScreenWidth;
    CGFloat     kScreenHeight;
    NSArray     *imgNamesArray;
    NSInteger   currentPage;
    NSTimeInterval  timerInterval;
    LMBannerViewLoadSourceType  bannerSourceType;
}

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray andLoadSourceWays:(LMBannerViewLoadSourceType)type{
    
    if (self = [super initWithFrame:frame]) {
        
        kScreenWidth    = frame.size.width;
        kScreenHeight   = frame.size.height;
        imgNamesArray   = imageArray;
        bannerSourceType= type;
        
        _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _imageView.backgroundColor = [UIColor lightGrayColor];
        [self addSubview:_imageView];
        _imageView.userInteractionEnabled = YES;
        
        if (bannerSourceType == 0) {
            _imageView.image = [UIImage imageNamed:imgNamesArray[currentPage]];
        }else if (bannerSourceType == 1) {
            [ _imageView sd_setImageWithURL:[NSURL URLWithString:imgNamesArray[currentPage]]];
        }
        
        UISwipeGestureRecognizer *fromRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromRight)];
        [fromRightRecognizer setDirection:UISwipeGestureRecognizerDirectionLeft];
        [_imageView addGestureRecognizer:fromRightRecognizer];
        
        UISwipeGestureRecognizer *fromLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFromLeft)];
        [fromLeftRecognizer setDirection:UISwipeGestureRecognizerDirectionRight];
        [_imageView addGestureRecognizer:fromLeftRecognizer];
        
        UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapImgView)];
        [_imageView addGestureRecognizer:tapRecognizer];
        
        [self setTimeInterval:2.0];
        
    }
    
    return self;
}

#pragma mark- Recognizer

- (void)handleSwipeFromLeft{
    currentPage--;
    
    if (currentPage < 0) {
        currentPage = imgNamesArray.count - 1;
    }
    self.pageControl.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        self.imageView.image = [UIImage imageNamed:imgNamesArray[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.imageView sd_setImageWithURL:[NSURL URLWithString:imgNamesArray[currentPage]]];
    }
    
    //转场动画
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";                //立方体翻转
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.5;
    transition.delegate = self;
    [self.imageView.layer addAnimation:transition forKey:nil];

    
}

- (void)handleSwipeFromRight{
    currentPage++;
    
    if (currentPage >= imgNamesArray.count) {
        currentPage = 0;
    }
    self.pageControl.currentPage = currentPage;
    
    if (bannerSourceType == 0) {
        self.imageView.image = [UIImage imageNamed:imgNamesArray[currentPage]];
    }else if (bannerSourceType == 1) {
        [ self.imageView sd_setImageWithURL:[NSURL URLWithString:imgNamesArray[currentPage]]];
    }
    
    //转场动画
    CATransition *transition = [[CATransition alloc] init];
    transition.type = @"cube";                //立方体翻转
    transition.subtype = kCATransitionFromRight;
    transition.duration = 1.5;
    transition.delegate = self;
    [self.imageView.layer addAnimation:transition forKey:nil];

    
}


#pragma mark - SetMethod


- (void)setPageIndicatorTintColor:(UIColor *)pageIndicatorTintColor {
    self.pageControl.pageIndicatorTintColor = pageIndicatorTintColor;
}
- (void)setCurrentPageIndicatorTintColor:(UIColor *)currentPageIndicatorTintColor {
    self.pageControl.currentPageIndicatorTintColor = currentPageIndicatorTintColor;
}

- (void)setShowPageControl:(BOOL)showPageControl {
    if (showPageControl == YES) {
        [self addSubview:self.pageControl];
    }
}

- (void)setTimeInterval:(CGFloat)timeInterval{
    
    timerInterval = fabs(timeInterval);
    
    if (!self.timer) {
        
        [self.timer invalidate];
        
        [self setupTimerWithTimeInterval:timerInterval];
    }
}

- (void)setupTimerWithTimeInterval:(CGFloat)timeInterval{
    
    _timer = [NSTimer timerWithTimeInterval:timeInterval target:self selector:@selector(handleSwipeFromRight) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:_timer forMode:NSDefaultRunLoopMode];
}



- (void)animationDidStart:(CAAnimation *)anim{
    
    if (self.timer) {
        
        [self.timer invalidate];
    }
    
    self.imageView.userInteractionEnabled = NO;
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    
    if (timerInterval > 0) {
        [self setupTimerWithTimeInterval:timerInterval];
    }else {
        [self setupTimerWithTimeInterval:3.0];
    }
    self.imageView.userInteractionEnabled = YES;

}


#pragma mark -代理

- (void)tapImgView{
    
    if ([self.delegate respondsToSelector:@selector(lmBannerView:didSelctorItemWithIndex:)]) {
        [self.delegate lmBannerView:self didSelctorItemWithIndex:currentPage];
    }
}


#pragma mark - lazy

- (UIPageControl *)pageControl{
    
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc] init];
        CGSize size = [_pageControl sizeForNumberOfPages:imgNamesArray.count];
        _pageControl.frame = CGRectMake(0, 0, size.width, size.height);
        _pageControl.center = CGPointMake(self.center.x, kScreenHeight - 8);
        _pageControl.pageIndicatorTintColor = _pageIndicatorTintColor;
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = _currentPageIndicatorTintColor;
        _pageControl.numberOfPages = imgNamesArray.count;
        _pageControl.hidesForSinglePage = YES;

    }
    
    return _pageControl;
}


@end
