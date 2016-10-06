//
//  TTAnimationModel.h
//  tension
//
//  Created by 唐韬 on 16/9/22.
//  Copyright © 2016年 TT. All rights reserved.
//


#import <Foundation/Foundation.h>
#import <objc/objc-runtime.h>
#import "NSObject+Extension.h"

@class TTAnimationModel;

@protocol TTAnimationModelDelegate <NSObject>

-(void) animationModelDidFinish:(TTAnimationModel *)aniamtionModel;

@end

@interface TTAnimationModel : NSObject

@property(nonatomic, assign) NSUInteger hashValue;
@property(nonatomic, weak) id <TTAnimationModelDelegate> delegate;

+ (instancetype) animationModelWithObj:(id)obj value:(id)value keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration inQueue:(NSOperationQueue *)queue progress:(void(^)(double progress, id currenValue))progress completion:(void(^)(void))completion;

- (void) animation;

@end
