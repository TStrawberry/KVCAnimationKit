//
//  ViewController.m
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "ViewController.h"

#import "KVCAnimationKit.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIView *orangeView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *blackView;


@end

@implementation ViewController

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[[[[self.orangeView setValue:@400 forKeyPath:@"frame.origin.y" duraion:2] withFrameInterval:2]
       withProgress:^(double progress, id currenValue) {

           NSLog(@"%f -- %@", progress, currenValue);
           
    }] withCompletion:nil] commit];

    [[self setValue:@0.2 forKeyPath:@"blueView.alpha" duraion:2] commit];
    [[[self setValue:@130 forKeyPath:@"blackView.frame.origin.x" duraion:2] withCompletion:^{
        NSLog(@"*********");
    }] commit];

    [[[self setValue:[NSValue valueWithCGPoint:CGPointMake(120, 70)] forKeyPath:@"redView.frame.origin" duraion:2.0] withDelay:1.0] commit];
    
}


@end


