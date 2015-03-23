//
//  CAAnimation+Additionals.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 23.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "CAAnimation+Additionals.h"

@implementation CAAnimation (Additionals)

+ (CAAnimation*)arcAnimationForDuration:(NSTimeInterval)duration {
    
    CAKeyframeAnimation *startAngleKeyFrameAnimation = [CAKeyframeAnimation animationWithKeyPath:@"startAngle"];
    startAngleKeyFrameAnimation.duration             = duration;
    startAngleKeyFrameAnimation.values               = @[@0,@(M_PI + M_PI_2),@(M_PI*4)];
    startAngleKeyFrameAnimation.keyTimes             = @[@0,@0.5,@1];
    startAngleKeyFrameAnimation.additive             = YES;

    CAKeyframeAnimation *endAngleKeyFrameAnimation   = [CAKeyframeAnimation animationWithKeyPath:@"endAngle"];
    endAngleKeyFrameAnimation.duration               = duration;
    endAngleKeyFrameAnimation.values                 = @[@0,@(M_PI * 3),@(M_PI*4)];
    endAngleKeyFrameAnimation.keyTimes               = @[@0,@0.5,@1];
    endAngleKeyFrameAnimation.additive               = YES;

    CAAnimationGroup *animationGroup                 = [CAAnimationGroup animation];
    animationGroup.duration                          = duration;
    animationGroup.repeatCount                       = HUGE_VAL;
    animationGroup.animations                        = @[startAngleKeyFrameAnimation,endAngleKeyFrameAnimation];
    
    return animationGroup;
}

+ (CAAnimation *)opacityAnimationForLayer:(CALayer *)layer withDuration:(NSTimeInterval)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue {
    
    CABasicAnimation *opacityAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    opacityAnimation.fromValue         = @(fromValue);
    layer.opacity                      = toValue;
    opacityAnimation.toValue           = @(toValue);
    opacityAnimation.duration          = 0.5;
    
    return opacityAnimation;
}

@end
