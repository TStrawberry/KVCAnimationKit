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
{

     CGRect _name2;
}

@property(nonatomic, copy) NSString * name;

@property(nonatomic, strong) TTViewController * tVc;

@property(nonatomic, assign) int i;
@property(nonatomic, assign) unsigned int ui;
@property(nonatomic, assign) long l;
@property(nonatomic, assign) unsigned long ul;
@property(nonatomic, assign) long long q;
@property(nonatomic, assign) unsigned long long uq;
@property(nonatomic, assign) float f;
@property(nonatomic, assign) double d;
@property  CGRect ff;
@property(nonatomic, assign) CGSize ss;
@property(nonatomic, assign) CGPoint pp;


@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIView *animationView;
@property (weak, nonatomic) IBOutlet UIView *redView;
@property (weak, nonatomic) IBOutlet UIView *blueView;
@property (weak, nonatomic) IBOutlet UIView *blackView;

@property(nonatomic, assign) BOOL layouted;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *labelTop;

@property(nonatomic, assign) CGRect frame;

@end


@implementation ViewController

-(void)setFrame:(CGRect)frame {

}

- (CGRect)frame {

    return CGRectZero;
}

- (IBAction)btnClicked:(UIButton *)sender {

    
}



- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {


    __weak typeof(self) weakSelf = self;

    [self setValue:@130 forKeyPath:@"blackView.frame.x" duraion:1.5 progress:^(double progress, id currenValue) {

    } completion:^{

        [weakSelf invalidateAnimationData];
    }];


}


@end


