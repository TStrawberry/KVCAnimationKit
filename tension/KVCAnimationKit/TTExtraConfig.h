//
//  TTExtraCongif.h
//  KVCAnimationKit
//
//  Created by 唐韬 on 2016/10/11.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <Foundation/Foundation.h>

#warning 不要手动创建该对象, 创建方式详见NSObject+Animation.h。

@interface TTExtraConfig : NSObject

-(TTExtraConfig *) withProgress:(void(^)(double progress, id currenValue))progress;

-(TTExtraConfig *) withCompletion:(void(^)(void))completion;

-(TTExtraConfig *) withDelay:(NSTimeInterval)delay;

-(TTExtraConfig *) inQueue:(NSOperationQueue *)queue;

/**
 间隔的帧数

 @param frameInterval 详参-[CADisplayLink frameInterval], 必须大于0, 默认值为1。

 @return 当前的TTExtraConfig对象
 */
-(TTExtraConfig *) withFrameInterval:(NSInteger)frameInterval;

-(void) commit;

@end
