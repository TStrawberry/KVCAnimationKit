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

-(void)viewDidLoad {

    [super viewDidLoad];
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {

    [[[[self.orangeView setValue:[NSValue valueWithCGSize:CGSizeMake(300, 200)] forKeyPath:@"bounds.size" duraion:2] withProgress:^(double progress, id currenValue) {
        NSLog(@"%@", currenValue);
    }] withCompletion:^{
        NSLog(@"withCompletion");
    }] commit];
    
    [[self setValue:@400 forKeyPath:@"orangeView.center.y" duraion:2.6] commit];
    [[self setValue:@0.2 forKeyPath:@"blueView.alpha" duraion:1.7] commit];
    [[self setValue:[NSValue valueWithCGPoint:CGPointMake(120, 70)] forKeyPath:@"redView.frame.origin" duraion:3.0] commit];
    [[[self setValue:@130 forKeyPath:@"blackView.frame.origin.x" duraion:1.5] withCompletion:^{
        NSLog(@"*********");
    }] commit];

}


@end


