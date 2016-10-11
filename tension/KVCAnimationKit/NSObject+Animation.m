//
//  NSObject+Animation.m
//  tension
//
//  Created by 唐韬 on 16/9/9.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "NSObject+Animation.h"

#import <UIKit/UIKit.h>
#import "TTExtraConfig.h"

@implementation NSObject (Animation)

-(TTExtraConfig *)  setValue:(id)value
       forKeyPath:(NSString *)keyPath
          duraion:(NSTimeInterval)duration {

    TTExtraConfig * extraConfig = [[TTExtraConfig alloc] init];
    [extraConfig setValue:value forKey:@"value"];
    [extraConfig setValue:keyPath forKey:@"keyPath"];
    [extraConfig setValue:@(duration) forKey:@"duration"];
    [extraConfig setValue:self forKey:@"animationObj"];
    
    return extraConfig;
}

@end
