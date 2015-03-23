//
//  PSZBlurredActivityIndicatorView.h
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PSZBlurredActivityIndicatorViewAnimationCompletionBlock)();

@class PSZBlurredArcLayer;

@interface PSZBlurredActivityIndicatorView : UIView

/**
 *  Default value = 3.
 */
@property (nonatomic) NSTimeInterval arcAnimationDuration;

/**
 *  Default value = 0.5.
 */
@property (nonatomic) NSTimeInterval opacityAnimationDuration;

/**
 *  Default value = UIColor.black.
 */
@property (strong, nonatomic) UIColor *arcColor;

/**
 *  Default value = 5.0f.
 */
@property (nonatomic) CGFloat arcWidth;

/**
 *  Default value = 5.0f.
 */
@property (nonatomic) CGFloat arcBlurRadius;

- (void)startAnimating;
- (void)stopAnimation;
- (void)stopAnimationWithCompletionBlock:(PSZBlurredActivityIndicatorViewAnimationCompletionBlock)block;

@end
