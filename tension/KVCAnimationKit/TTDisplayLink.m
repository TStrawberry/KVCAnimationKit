//
//  TTDisplayLink.m
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "TTDisplayLink.h"
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

-(void) updateAnimationDataForObj:(id)obj value:(id)value keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration inQueue:(NSOperationQueue *)queue progress:(void(^)(double progress, id currenValue))progress completion:(void(^)(void))completion{

    NSUInteger hash = [keyPath hash];
    for (TTAnimationModel * model in self.animationModels) {
        if (model.hashValue == hash) {
            NSLog(@"正在处理%@", keyPath);
            return;
        }
    }

    TTAnimationModel * model = [TTAnimationModel animationModelWithObj:obj value:value keyPath:keyPath duration:duration inQueue:queue progress:progress completion:completion];
    model.hashValue = [keyPath hash];
    model.delegate = self;
    [self.animationModels addObject:model];

}

-(void)dealloc {

    [self.displayLink invalidate];
}

#pragma mark - TTAnimationModelDelegate

-(void)animationModelDidFinish:(TTAnimationModel *)aniamtionModel {

    [self.animationModels removeObject:aniamtionModel];
}



@end
