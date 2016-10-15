//
//  TTExtraCongif.m
//  KVCAnimationKit
//
//  Created by 唐韬 on 2016/10/11.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "TTExtraConfig.h"
#import "NSObject+Extension.h"
#import "TTAnimationModel.h"

@interface TTExtraConfig()

@property(nonatomic, weak) id animationObj;

@property(nonatomic, copy) NSString * keyPath;
@property(nonatomic, strong) id value;
@property(nonatomic, assign) NSTimeInterval duration;
@property(nonatomic, copy) void(^progress)(double, id);
@property(nonatomic, copy) void(^completion)(void);
@property(nonatomic, strong) NSOperationQueue * queue;

@end

@implementation TTExtraConfig


-(TTExtraConfig *) withProgress:(void(^)(double progress, id currenValue))progress {

    self.progress = progress;
    return self;
}

-(TTExtraConfig *) withCompletion:(void(^)(void))completion {

    self.completion = completion;
    return self;
}

-(TTExtraConfig *) inQueue:(NSOperationQueue *)queue {

    self.queue = queue;
    return self;
}

- (NSOperationQueue *)queue {

    if (_queue == nil) {
        return [NSOperationQueue currentQueue];
    }

    return _queue;
}

-(void) commit {

    TTAnimationModel * animationModel = [[TTAnimationModel alloc] init];

    animationModel.animationObj = self.animationObj;
    animationModel.keyPath = self.keyPath;
    animationModel.value = self.value;
    animationModel.animationDuration = self.duration;
    animationModel.progress = self.progress;
    animationModel.completion = self.completion;
    animationModel.queue = self.queue;

    [animationModel initialData];

    [self.animationObj updateAnimationDataForConfig:animationModel];
}

@end
