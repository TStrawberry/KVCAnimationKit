//
//  TTAnimationModel.h
//  tension
//
//  Created by 唐韬 on 16/9/22.
//  Copyright © 2016年 TT. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "NSObject+Extension.h"

@class TTAnimationConfig;

@class TTAnimationModel;

@protocol TTAnimationModelDelegate <NSObject>

-(void) animationModelDidFinish:(TTAnimationModel *)aniamtionModel;

@end

@interface TTAnimationModel : NSObject 

@property(nonatomic, copy) NSString * keyPath;
@property(nonatomic, strong) id value;
@property(nonatomic, weak) id animationObj;
@property(nonatomic, assign) NSTimeInterval animationDuration;
@property(nonatomic, assign) NSTimeInterval delay;
@property(nonatomic, assign) NSInteger frameInterval;
@property(nonatomic, copy) void (^progress)(double, id);
@property(nonatomic, copy) void (^completion)(void);
@property(nonatomic, strong) NSOperationQueue * queue;


@property(nonatomic, assign) NSUInteger hashValue;
@property(nonatomic, weak) id <TTAnimationModelDelegate> delegate;

- (void) initialData;
- (BOOL) isEqualToModel:(TTAnimationModel *)model;
- (void) animation;

@end
