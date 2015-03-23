//
//  PSZBlurredArcLayer.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "PSZBlurredArcLayer.h"

@implementation PSZBlurredArcLayer

#pragma mark - Utilities

/**
 *  Arc is moved out of the visible rect, to show only it's shadow
 *
 */
- (CGFloat)shadowVerticalOffset {
    return self.bounds.size.width;
}

/**
 *  To keep spinning arc visible angle range should be grater then 0. That value increases angle range for both sides.
 *
 */
- (CGFloat)angleMargin {
    return M_PI/10;
}

- (CGFloat)arcRadius {
    return self.bounds.size.width/2 - self.blurRadius - self.arcWidth/2;
}

- (CGPoint)arcCenter {
    return CGPointMake(self.bounds.size.width/2 + [self shadowVerticalOffset], self.bounds.size.height/2);
}

- (CGSize)arcShadowOffset {
    return CGSizeMake (-[self shadowVerticalOffset], 0);
}

#pragma mark - Overrides

- (void)display {
    UIGraphicsBeginImageContextWithOptions(self.bounds.size, NO, 0);

    CGPathRef pathRef = [UIBezierPath bezierPathWithArcCenter:[self arcCenter]
                                                       radius:[self arcRadius]
                                                   startAngle:[[self presentationLayer] startAngle] + self.anglesOffset - [self angleMargin]
                                                     endAngle:[[self presentationLayer] endAngle] + self.anglesOffset + [self angleMargin]
                                                    clockwise:YES].CGPath;

    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetShadowWithColor(ctx, [self arcShadowOffset], self.blurRadius, self.arcColor.CGColor);
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
