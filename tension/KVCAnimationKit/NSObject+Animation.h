//
//  NSObject+Animation.h
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (Animation)

-(void)  setValue:(id)value
       forKeyPath:(NSString *)keyPath
          duraion:(NSTimeInterval)duration;

-(void)  setValue:(id)value
      forKeyPath:(NSString *)keyPath
         duraion:(NSTimeInterval)duration
        progress:(void(^)(double progress, id currenValue))progress
      completion:(void(^)(void))completion;

-(void) setValue:(id)value
      forKeyPath:(NSString *)keyPath
         duraion:(NSTimeInterval)duration
         inQueue:(NSOperationQueue *)queue;

-(void) setValue:(id)value
      forKeyPath:(NSString *)keyPath
         duraion:(NSTimeInterval)duration
         inQueue:(NSOperationQueue *)queue
        progress:(void(^)(double progress, id currenValue))progress
      completion:(void(^)(void))completion;


/**
 用于对动画数据进行清理, 如果确定不需要再调用以上接口了, 应该手动调用此方法.
 */
-(void) invalidateAnimationData;

@end
