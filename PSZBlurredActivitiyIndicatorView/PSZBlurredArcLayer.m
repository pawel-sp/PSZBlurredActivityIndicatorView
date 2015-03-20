//
//  PSZBlurredArcLayer.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "PSZBlurredArcLayer.h"

@interface PSZBlurredArcLayer()
{
    CGFloat _endAngle;
}
@end

@implementation PSZBlurredArcLayer

#pragma mark - Utilities

- (CGFloat)shadowVerticalOffset {
    //arc is moved out of the visible rect, to show only it's shadow
    return self.bounds.size.width;
}

#pragma mark - Overrides

- (void)display {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);
    
    CGContextRef ctx     = UIGraphicsGetCurrentContext();
    CGFloat margin       = M_PI/10;
    CGFloat endAngle     = [[self presentationLayer] endAngle] + self.anglesOffset + margin;
    CGFloat startAngle   = [[self presentationLayer] startAngle] + self.anglesOffset - margin;
    CGRect bounds        = self.bounds;
    CGPoint arcCenter    = CGPointMake(bounds.size.width/2 + [self shadowVerticalOffset], bounds.size.height/2);
    CGFloat radius       = bounds.size.width/2 - 2*self.blurRadius;
    CGPathRef pathRef    = [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:startAngle endAngle:endAngle clockwise:YES].CGPath;
    CGSize  shadowOffset = CGSizeMake (-[self shadowVerticalOffset], 0);

    CGContextSetShadowWithColor(ctx, shadowOffset, self.blurRadius, self.arcColor.CGColor);
    CGContextSetLineWidth(ctx, self.arcWidth);
    CGContextSetStrokeColorWithColor(ctx,[UIColor blackColor].CGColor);
    CGContextAddPath(ctx, pathRef);
    CGContextStrokePath(ctx);
    self.contents = (id)UIGraphicsGetImageFromCurrentImageContext().CGImage;
    UIGraphicsEndImageContext();
}

+ (BOOL)needsDisplayForKey:(NSString *)key{
    if ([@"endAngle" isEqualToString:key]) {
        return YES;
    } else if ([@"startAngle" isEqualToString:key]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

#pragma mark - Properties

- (void)setStartAngle:(CGFloat)startAngle {
    _startAngle = startAngle;
    [self setNeedsDisplay];
}

- (void)setEndAngle:(CGFloat)endAngle {
    _endAngle = endAngle;
    [self setNeedsDisplay];
}

- (void)setBlurRadius:(CGFloat)blurRadius {
    _blurRadius = blurRadius;
    [self setNeedsDisplay];
}

- (void)setArcColor:(UIColor *)arcColor {
    _arcColor = arcColor;
    [self setNeedsDisplay];
}

- (void)setArcWidth:(CGFloat)arcWidth {
    _arcWidth = arcWidth;
    [self setNeedsDisplay];
}

@end
