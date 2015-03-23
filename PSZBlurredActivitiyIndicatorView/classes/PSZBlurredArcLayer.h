//
//  PSZBlurredArcLayer.h
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

@interface PSZBlurredArcLayer : CAShapeLayer

@property (nonatomic        ) CGFloat startAngle;
@property (nonatomic        ) CGFloat endAngle;
@property (nonatomic        ) CGFloat blurRadius;
@property (strong, nonatomic) UIColor *arcColor;
@property (nonatomic        ) CGFloat arcWidth;
@property (nonatomic        ) CGFloat anglesOffset;

@end
