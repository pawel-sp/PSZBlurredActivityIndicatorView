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

#pragma mark - Utilities

- (CGFloat)arcVerticalOffset {
    return self.bounds.size.width;
}

- (void)drawArcInContext:(CGContextRef)ctx {
    CGSize  shadowOffset = CGSizeMake (-[self arcVerticalOffset], 0);
    CGPathRef pathRef    = [self arcPath];
    
    CGContextSaveGState(ctx);
    CGContextSetShadowWithColor(ctx, shadowOffset, self.blurRadius, self.arcColor.CGColor);
    CGContextSetLineWidth(ctx, self.arcWidth);
    CGContextSetStrokeColorWithColor(ctx,[UIColor blackColor].CGColor);
    CGContextAddPath(ctx, pathRef);
    CGContextStrokePath(ctx);
    CGContextRestoreGState(ctx);
}

- (CGPathRef)arcPath {
    CGRect bounds     = self.bounds;
    CGPoint arcCenter = CGPointMake(bounds.size.width/2 + [self arcVerticalOffset], bounds.size.height/2);
    CGFloat radius    = self.bounds.size.width/2 - 1.15*self.blurRadius;
    return [UIBezierPath bezierPathWithArcCenter:arcCenter radius:radius startAngle:self.startAngle endAngle:self.endAngle clockwise:YES].CGPath;
}

#pragma mark - Overrides

- (void)drawInContext:(CGContextRef)ctx {
    [super drawInContext:ctx];
    [self drawArcInContext:ctx];
}

@end
