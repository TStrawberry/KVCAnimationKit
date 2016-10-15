//
//  TTDisplayLink.m
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "TTDisplayLink.h"
#import "TTAnimationModel.h"
#import "TTAnimationModel.h"

@interface TTDisplayLink() <TTAnimationModelDelegate>

@property(nonatomic, strong) CADisplayLink * displayLink;
@property(nonatomic, strong) NSMutableArray <TTAnimationModel *> * animationModels;

@end

@implementation TTDisplayLink

-(instancetype) initWithTarget:(id)target selector:(SEL)sel {

    if (self = [super init]) {

        self.displayLink = [CADisplayLink displayLinkWithTarget:target selector:sel];
    }
    return self;
}

+(instancetype)displayLinkWithTarget:(id)target selector:(SEL)sel {

    return [[self alloc] initWithTarget:target selector:sel];
}

-(NSMutableArray *)animationModels {

    if (_animationModels == nil) {
        _animationModels = (NSMutableArray *)[NSMutableArray array];
    }
    return _animationModels;
}

-(void)setDisplayLink:(CADisplayLink *)displayLink {

    _displayLink = displayLink;
    
    displayLink.paused = YES;
    [displayLink addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
}

-(void)setPaused:(BOOL)paused {

    self.displayLink.paused = paused;
}

-(BOOL)paused {

    return self.displayLink.paused;
}

-(void) animation {

    if (self.animationModels.count == 0) {
        self.displayLink.paused = YES;
        return;
    }

    [self.animationModels makeObjectsPerformSelector:@selector(animation)];
}

-(void) updateAnimationModel:(TTAnimationModel *)animationModel {

    NSUInteger hash = [animationModel.keyPath hash];
    for (TTAnimationModel * model in self.animationModels) {
        if (model.hashValue == hash) {

            #ifdef DEBUG
            NSLog(@"正在处理%@", animationModel.keyPath);
            #endif

            return;
        }
    }

    animationModel.delegate = self;
    [self.animationModels addObject:animationModel];
}


-(void)dealloc {

    [self.displayLink invalidate];
}

#pragma mark - TTAnimationModelDelegate

-(void)animationModelDidFinish:(TTAnimationModel *)aniamtionModel {

    [self.animationModels removeObject:aniamtionModel];
}



@end
