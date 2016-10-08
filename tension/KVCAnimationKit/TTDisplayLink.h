//
//  TTDisplayLink.h
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Extension.h"

@interface TTDisplayLink : NSObject

@property(nonatomic, assign) BOOL paused;

+(instancetype)displayLinkWithTarget:(id)target selector:(SEL)sel;

-(void) updateAnimationDataForObj:(id)obj value:(id)value keyPath:(NSString *)keyPath duration:(NSTimeInterval)duration inQueue:(NSOperationQueue *)queue progress:(void(^)(double progress, id currenValue))progress completion:(void(^)(void))completion;

-(void) animation;

@end
