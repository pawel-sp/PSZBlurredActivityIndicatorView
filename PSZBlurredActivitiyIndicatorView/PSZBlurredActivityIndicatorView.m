//
//  PSZBlurredActivityIndicatorView.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "PSZBlurredActivityIndicatorView.h"
#import "PSZBlurredArcLayer.h"

@implementation PSZBlurredActivityIndicatorView

- (void)drawRect:(CGRect)rect {
    PSZBlurredArcLayer *arcLayer = [PSZBlurredArcLayer layer];
    arcLayer.frame               = rect;
    arcLayer.startAngle          = -M_PI_2;
    arcLayer.endAngle            = 0;
    arcLayer.arcColor            = [UIColor redColor];
    arcLayer.arcWidth            = 10;
    arcLayer.blurRadius          = 15;
    [self.layer addSublayer:arcLayer];
}

@end
