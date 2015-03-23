//
//  PSZBlurredActivityIndicatorView.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "PSZBlurredActivityIndicatorView.h"
#import "PSZBlurredArcLayer.h"
#import "CAAnimation+Additionals.h"

static NSString * const blurredActivityIndicatorViewArcAnglesAnimationKey  = @"blurredActivityIndicatorViewArcAnglesAnimationKey";
static NSString * const blurredActivityIndicatorViewArcOpacityAnimationKey = @"blurredActivityIndicatorViewArcOpacityAnimationKey";

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

- (void)setArcColor:(UIColor *)arcColor {
    self.arcLayer.arcColor = arcColor;
}

- (UIColor *)arcColor {
    return self.arcLayer.arcColor;
}

- (void)setArcWidth:(CGFloat)arcWidth {
    self.arcLayer.arcWidth = arcWidth;
}

- (CGFloat)arcWidth {
    return self.arcLayer.arcWidth;
}

- (void)setArcBlurRadius:(CGFloat)arcBlurRadius {
    self.arcLayer.blurRadius = arcBlurRadius;
}

- (CGFloat)arcBlurRadius {
    return self.arcLayer.blurRadius;
}

#pragma mark - Setup

- (void)setup {
    self.opaque                   = NO;
    self.arcAnimationDuration     = 3;
    self.opacityAnimationDuration = 0.5;
    self.arcColor                 = [UIColor blackColor];
    self.arcWidth                 = 5.0f;
    self.arcBlurRadius            = 5.0f;

    self.arcLayer.anglesOffset    = -M_PI_2;
    self.arcLayer.opacity         = 0;

}

#pragma mark - Init

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

#pragma mark - Overrides

- (void)drawRect:(CGRect)rect {
    self.arcLayer.frame        = rect;
        [self.layer addSublayer:self.arcLayer];
}

#pragma mark - Animations

- (void)setAnimationActive:(BOOL)active {
    _animationDidStart = active;
    if (active) {
        [self.arcLayer addAnimation:[CAAnimation arcAnimationForDuration:self.arcAnimationDuration] forKey:blurredActivityIndicatorViewArcAnglesAnimationKey];
        [self.arcLayer addAnimation:[CAAnimation opacityAnimationForLayer:self.arcLayer withDuration:self.opacityAnimationDuration fromValue:0 toValue:1] forKey:blurredActivityIndicatorViewArcOpacityAnimationKey];
    } else {
        CAAnimation *opacityAnimation = [CAAnimation opacityAnimationForLayer:self.arcLayer withDuration:self.opacityAnimationDuration fromValue:1 toValue:0];
        opacityAnimation.delegate     = self;
        [self.arcLayer addAnimation:opacityAnimation forKey:blurredActivityIndicatorViewArcOpacityAnimationKey];
    }
}

- (void)startAnimating {
    [self setAnimationActive:YES];
}

- (void)stopAnimation {
    [self setAnimationActive:NO];
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    if (!_animationDidStart) {
        [self.arcLayer removeAllAnimations];
    }
}

@end
