//
//  TTDisplayLink.h
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Extension.h"
@class TTAnimationModel;

@interface TTDisplayLink : NSObject

@property(nonatomic, assign) BOOL paused;

+(instancetype)displayLinkWithTarget:(id)target selector:(SEL)sel;

-(void) updateAnimationModel:(TTAnimationModel *)animationModel;

-(void) animation;

@end
