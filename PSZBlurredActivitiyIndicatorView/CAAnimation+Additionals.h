//
//  CAAnimation+Additionals.h
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 23.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CAAnimation (Additionals)

+ (CAAnimation*)arcAnimationForDuration:(NSTimeInterval)duration;
+ (CAAnimation*)opacityAnimationForLayer:(CALayer*)layer withDuration:(NSTimeInterval)duration fromValue:(CGFloat)fromValue toValue:(CGFloat)toValue;

@end
