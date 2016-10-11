//
//  TTExtraCongif.h
//  KVCAnimationKit
//
//  Created by 唐韬 on 2016/10/11.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTExtraConfig : NSObject

-(TTExtraConfig *) withProgress:(void(^)(double progress, id currenValue))progress;

-(TTExtraConfig *) withCompletion:(void(^)(void))completion;

-(TTExtraConfig *) inQueue:(NSOperationQueue *)queue;

-(void) commit;

@end
