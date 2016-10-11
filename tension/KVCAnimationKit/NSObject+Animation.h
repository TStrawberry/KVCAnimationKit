//
//  NSObject+Animation.h
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <Foundation/Foundation.h>

@class TTExtraConfig;

@interface NSObject (Animation)

-(TTExtraConfig *)  setValue:(id)value
       forKeyPath:(NSString *)keyPath
          duraion:(NSTimeInterval)duration;

/**
 用于对动画数据进行清理, 如果确定不需要再调用以上接口了, 应该手动调用此方法.
 */
//-(void) invalidateAnimationData;

@end
