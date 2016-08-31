//
//  LMBannerView.h
//  LMBannerView
//
//  Created by 刘明 on 16/8/31.
//  Copyright © 2016年 刘明. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    LMBannerViewLoadSourceFromLocation,
    LMBannerViewLoadSourceFromWeb,
} LMBannerViewLoadSourceType;

@class LMBannerView;

@protocol LMBannerViewDelegate <NSObject>


- (void)lmBannerView:(LMBannerView *)bannerView didSelctorItemWithIndex:(NSInteger)index;

@end


@interface LMBannerView : UIView

/**
 滑动间隔
 */
@property (nonatomic, assign) CGFloat timeInterval;
/**
 是否要显示pagecontrol
 */
@property (nonatomic, assign) BOOL showPageControl;
/**
 当前页点的颜色
 */
@property (nonatomic, strong) UIColor *currentPageIndicatorTintColor;
/**
 未选中点的颜色
 */
@property (nonatomic, strong) UIColor *pageIndicatorTintColor;


@property (nonatomic, weak) id<LMBannerViewDelegate> delegate;

- (instancetype)initWithFrame:(CGRect)frame imageArray:(NSArray *)imageArray andLoadSourceWays:(LMBannerViewLoadSourceType)type;


@end
