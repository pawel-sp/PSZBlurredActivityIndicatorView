//
//  ViewController.m
//  PSZBlurredActivitiyIndicatorView
//
//  Created by Paweł Sporysz on 20.03.2015.
//  Copyright (c) 2015 Paweł Sporysz. All rights reserved.
//

#import "ViewController.h"
#import "PSZBlurredActivityIndicatorView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet PSZBlurredActivityIndicatorView *blurredActivityIndicatorView;
@end

@implementation ViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.blurredActivityIndicatorView.arcColor = [UIColor redColor];
//    self.blurredActivityIndicatorView.arcWidth = 20.0f;
//    self.blurredActivityIndicatorView.arcBlurRadius = 20.0f;
}

#pragma mark - Actions

- (IBAction)switchAction:(UISwitch *)sender {
    if (sender.isOn) {
        [self.blurredActivityIndicatorView startAnimating];
    } else {
        [self.blurredActivityIndicatorView stopAnimation];
    }
}

@end
