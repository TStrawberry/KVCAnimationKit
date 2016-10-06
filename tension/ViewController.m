//
//  ViewController.m
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "ViewController.h"

#import "TTViewController.h"
#import "KVCAnimationKit.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *blackView;



@end


@implementation ViewController



-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    __weak typeof(self) weakSelf = self;

    [self setValue:@400 forKeyPath:@"animationView.center.y" duraion:1.5];
    [self setValue:@0.2 forKeyPath:@"blueView.alpha" duraion:2.0];
    [self setValue:[NSValue valueWithCGRect:CGRectMake(20, 50, 200, 150)] forKeyPath:@"redView.frame" duraion:3.0];
    [self setValue:@130 forKeyPath:@"blackView.frame.x" duraion:1.5 progress:^(double progress, id currenValue) {
        
    } completion:^{

        [weakSelf invalidateAnimationData];
    }];

}


@end


