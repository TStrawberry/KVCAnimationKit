//
//  TTCGModel.h
//  tension
//
//  Created by 唐韬 on 16/9/27.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GlobleEnum.h"

@interface TTCGModel : NSObject {

    void * _originalValue;
    void * _targetValue;
}

@property(nonatomic, assign) CGKeyPathType type;

-(instancetype) initWithOriginal:(void *)original target:(void *)target keyPathTyep:(CGKeyPathType)type;

-(void) getCurrentValue:(void *)current ForProgress:(NSTimeInterval)prgress originalTopValue:(void *)topValue baseType:(TTBaseType)baseType;

@end
