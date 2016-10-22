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

-(TTExtraConfig *) setValue:(id)value
       forKeyPath:(NSString *)keyPath
          duraion:(NSTimeInterval)duration;

@end
