//
//  PSZBlurredActivityIndicatorView.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "PSZBlurredActivityIndicatorView.h"
#import "PSZBlurredArcLayer.h"

@interface PSZBlurredActivityIndicatorView()
{
    BOOL _animationDidStart;
}
@property (strong, nonatomic) PSZBlurredArcLayer *arcLayer;
@end

@implementation PSZBlurredActivityIndicatorView

#pragma mark - Properties

- (PSZBlurredArcLayer *)arcLayer {
    if(!_arcLayer) {
        _arcLayer = [PSZBlurredArcLayer layer];
    }
    return _arcLayer;
}

#pragma mark - Setup

- (void)setup {
    self.opaque = NO;
}

#pragma mark - Overrides

- (void)awakeFromNib {
    [super awakeFromNib];
    [self setup];
}

- (void)drawRect:(CGRect)rect {
    self.arcLayer.frame               = rect;
    self.arcLayer.arcColor            = [UIColor whiteColor];
    self.arcLayer.arcWidth            = 35;
    self.arcLayer.blurRadius          = 25;
    self.arcLayer.anglesOffset        = -M_PI_2;
    self.arcLayer.opacity = 0;
    [self.layer addSublayer:self.arcLayer];
}

#pragma mark - Animations

- (void)startAnimating {
    _animationDidStart = YES;
    NSTimeInterval duration = 3;
    
//    CABasicAnimation *startAngleAnimation  = [CABasicAnimation animationWithKeyPath:@"startAngle"];
//    [startAngleAnimation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
//    [startAngleAnimation setDuration:duration];
//    [startAngleAnimation setFromValue:[NSNumber numberWithFloat:0]];
//    [startAngleAnimation setToValue:[NSNumber numberWithFloat:M_PI *3]]; // 270
//    //[startAngleAnimation setAutoreverses:YES];
//    [startAngleAnimation setRemovedOnCompletion:NO];
//    
    CAKeyframeAnimation *startAngleKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"startAngle"];
    startAngleKeyFrameAnimation.duration = duration;
    startAngleKeyFrameAnimation.values = @[@0,@(M_PI + M_PI_2),@(M_PI*4)];
    startAngleKeyFrameAnimation.keyTimes = @[@0,@0.5,@1];
    startAngleKeyFrameAnimation.additive = YES;
    
    CAKeyframeAnimation *endAngleKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"endAngle"];
    endAngleKeyFrameAnimation.duration = duration;
    endAngleKeyFrameAnimation.values = @[@0,@(M_PI * 3),@(M_PI*4)];
    endAngleKeyFrameAnimation.keyTimes = @[@0,@0.5,@1];
    endAngleKeyFrameAnimation.additive = YES;
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    [animationGroup setDuration:duration];
    //[animationGroup setBeginTime:CACurrentMediaTime()];
    [animationGroup setRepeatCount:HUGE_VAL];
    [animationGroup setAnimations:[NSArray arrayWithObjects:startAngleKeyFrameAnimation,endAngleKeyFrameAnimation, nil]];
    [self.arcLayer addAnimation:animationGroup forKey:@"arcAnimationKey"];
    

    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(self.arcLayer.opacity);
    self.arcLayer.opacity = 1;
    alphaAnimation.toValue = @(self.arcLayer.opacity);
    alphaAnimation.duration = 0.5;
    [self.arcLayer addAnimation:alphaAnimation forKey:@"alphaAnimationKey"];
}

- (void)stopAnimation {
    _animationDidStart = NO;
    CABasicAnimation *alphaAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    alphaAnimation.fromValue = @(self.arcLayer.opacity);
    self.arcLayer.opacity = 0;
    alphaAnimation.toValue = @(self.arcLayer.opacity);
    alphaAnimation.duration = 0.5;
    alphaAnimation.delegate = self;
    [self.arcLayer addAnimation:alphaAnimation forKey:@"alphaAnimationKey"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!_animationDidStart) {
        [self.arcLayer removeAllAnimations];
    }
}

@end
