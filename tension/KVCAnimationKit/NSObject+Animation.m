//
//  NSObject+Animation.m
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "NSObject+Animation.h"

#import <UIKit/UIKit.h>
#import "TTDisplayLink.h"

@interface NSObject()

@property(nonatomic, strong, readonly) TTDisplayLink * displayLink;

@end

static char * DISPLAY_LINK_NAME = "displayLink";

@implementation NSObject (Animation)

-(TTDisplayLink *)displayLink {

    TTDisplayLink * displayLink = objc_getAssociatedObject(self, DISPLAY_LINK_NAME);
    if (displayLink == nil) {
        displayLink = [TTDisplayLink displayLinkWithTarget:self selector:@selector(updateKeyPath:)];
        objc_setAssociatedObject(self, DISPLAY_LINK_NAME, displayLink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return displayLink;
}

-(void)  setValue:(id)value
       forKeyPath:(NSString *)keyPath
          duraion:(NSTimeInterval)duration {

    [self setValue:value forKeyPath:keyPath duraion:duration inQueue:nil progress:nil completion:nil];
}

-(void)setValue:(id)value forKeyPath:(NSString *)keyPath duraion:(NSTimeInterval)duration progress:(void (^)(double, id))progress completion:(void (^)(void))completion {
    
    [self setValue:value forKeyPath:keyPath duraion:duration inQueue:nil progress:progress completion:completion];
}

-(void) setValue:(id)value
      forKeyPath:(NSString *)keyPath
         duraion:(NSTimeInterval)duration
         inQueue:(NSOperationQueue *)queue {

    [self setValue:value forKeyPath:keyPath duraion:duration inQueue:queue progress:nil completion:nil];
}

-(void) setValue:(id)value forKeyPath:(NSString *)keyPath duraion:(NSTimeInterval)duration inQueue:(NSOperationQueue *)queue progress:(void(^)(double progress, id currenValue))progress completion:(void(^)(void))completion {

    NSOperationQueue * targetQueue = queue == nil ? [NSOperationQueue currentQueue] : queue;
    [self.displayLink updateAnimationDataForObj:self value:value keyPath:keyPath duration:duration inQueue:targetQueue progress:progress completion:completion];

    if (self.displayLink.paused == YES) {
        self.displayLink.paused = NO;
    }
}

-(void) updateKeyPath:(CADisplayLink *)displayLink {

    [self.displayLink animation];
}

-(void) invalidateAnimationData {

    objc_setAssociatedObject(self, DISPLAY_LINK_NAME, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
