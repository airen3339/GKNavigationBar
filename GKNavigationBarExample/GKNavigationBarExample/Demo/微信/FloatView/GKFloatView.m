//
//  GKFloatView.m
//  GKNavigationBarViewControllerDemo
//
//  Created by QuintGao on 2020/10/17.
//

#import "GKFloatView.h"
#import "GKFloatTransition.h"
#import "GKWXDetailViewController.h"
#import "UIViewController+GKGestureHandle.h"

#define GKFloatScreenW [UIScreen mainScreen].bounds.size.width
#define GKFloatScreenH [UIScreen mainScreen].bounds.size.height

#define GKFloatWH 60

static GKFloatView *_floatView;

@interface GKFloatView()

@property (nonatomic, strong) UIImageView *imgView;

@property (nonatomic, weak) UIViewController *fromVC;
@property (nonatomic, weak) UIViewController *toVC;

@end

@implementation GKFloatView

+ (void)create {
    if (_floatView) return;
    
    GKFloatView *floatView = [GKFloatView new];
    floatView.frame = CGRectMake(GKFloatScreenW - 10 - GKFloatWH, GK_STATUSBAR_NAVBAR_HEIGHT + 20, GKFloatWH, GKFloatWH);
    _floatView = floatView;
    
    [[UIApplication sharedApplication].delegate.window addSubview:floatView];
}

+ (void)destory {
    if (_floatView) {
        [_floatView removeFromSuperview];
        _floatView = nil;
    }
}

+ (GKFloatView *)floatView {
    return _floatView;
}

+ (void)show {
    if (_floatView) {
        [_floatView show];
        _floatView.hidden = NO;
    }
}

+ (void)hide {
    if (_floatView) {
        [_floatView hide];
        _floatView.hidden = YES;
    }
}

+ (void)dismissVC {
    if (_floatView) {
        [_floatView dismissVC];
    }
}

- (instancetype)init {
    if (self = [super init]) {
        [self addSubview:self.imgView];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(imgClick)];
        [self.imgView addGestureRecognizer:tap];
        
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panAction:)];
        [self.imgView addGestureRecognizer:pan];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.imgView.frame = self.bounds;
}

- (void)show {
    self.fromVC.gk_pushTransition = nil;
    self.toVC.gk_popTransition = nil;
}

- (void)hide {
    self.toVC.gk_popTransition = [GKFloatTransition transitionWithType:GKFloatTransitionTypePop];
}

- (void)dismissVC {
    [GKFloatView show];
    
    if (!self.toVC) {
        self.toVC = GKConfigure.visibleViewController;
    }
    
    self.toVC.gk_popTransition = [GKFloatTransition transitionWithType:GKFloatTransitionTypePop];
    [self.toVC.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    self.fromVC.gk_pushTransition = nil;
    self.toVC.gk_popTransition = nil;
}

#pragma mark - Action
- (void)imgClick {
    UIViewController *visibleVC = GKConfigure.visibleViewController;
    visibleVC.gk_pushTransition = [GKFloatTransition transitionWithType:GKFloatTransitionTypePush];
    self.fromVC = visibleVC;
    
    GKWXDetailViewController *detailVC = [GKWXDetailViewController new];
    detailVC.hidesBottomBarWhenPushed = YES;
    detailVC.gk_popTransition = [GKFloatTransition transitionWithType:GKFloatTransitionTypePop];
    self.toVC = detailVC;
    [visibleVC.navigationController pushViewController:detailVC animated:YES];
    [GKFloatView hide];
}

- (void)panAction:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan locationInView:self.superview];
    switch (pan.state) {
        case UIGestureRecognizerStateChanged: {
            self.center = point;
        }
            break;
        case UIGestureRecognizerStateEnded:
        case UIGestureRecognizerStateCancelled: {
            [self panEnd:point];
        }
            break;
        default:
            break;
    }
}

- (void)panEnd:(CGPoint)point {
    CGRect frame = self.frame;
    
    if (point.x <= GKFloatScreenW / 2) {
        frame.origin.x = 10;
    }else {
        frame.origin.x = GKFloatScreenW - GKFloatWH - 10;
    }
    
    if (frame.origin.y > GKFloatScreenH - frame.size.height - 10) {
        frame.origin.y = GKFloatScreenH - frame.size.height - 10;
    }else if (frame.origin.y < 20) {
        frame.origin.y = 20;
    }
    
    [UIView animateWithDuration:0.3 animations:^{
        self.frame = frame;
    }];
}

#pragma mark - ?????????
- (UIImageView *)imgView {
    if (!_imgView) {
        _imgView = [[UIImageView alloc] init];
        _imgView.image = [UIImage imageNamed:@"weixin"];
        _imgView.userInteractionEnabled = YES;
        _imgView.layer.cornerRadius = GKFloatWH / 2;
        _imgView.layer.masksToBounds = YES;
    }
    return _imgView;
}

@end
