//
//  CGRect+Extension.h
//  tension
//
//  Created by 唐韬 on 16/9/24.
//  Copyright © 2016年 TT. All rights reserved.
//

#ifndef CGRect_Extension_h
#define CGRect_Extension_h

#include <stdio.h>
#include <CoreGraphics/CoreGraphics.h>
#include "GlobleEnum.h"

CGRect CGRectSetValueForKey(CGRect rect, void * value, const char * key);
CGSize CGSizeSetValueForKey(CGSize size, CGFloat value, const char * key);
CGPoint CGPointSetValueForKey(CGPoint point, CGFloat value,const char * key);

CGRect CGRectSetValueForType(CGRect rect, void * value, CGKeyPathType type);
CGSize CGSizeSetValueForType(CGSize size, CGFloat value, CGKeyPathType type);
CGPoint CGPointSetValueForType(CGPoint point, CGFloat value, CGKeyPathType type);

CGKeyPathType CGTypeForKey(const char * key);

CGPoint CGPointFromOriginalToTargetWithProgress(CGPoint original, CGPoint target, double progress);
CGSize CGSizeFromOriginalToTargetWithProgress(CGSize original, CGSize target, double progress);
CGRect CGRectFromOriginalToTargetWithProgress(CGRect original, CGRect target, double progress);

void * CGRectValueForType(CGRect rect, CGKeyPathType type);
void * CGSizeValueForType(CGSize size, CGKeyPathType type);
void * CGPointValueForType(CGPoint point, CGKeyPathType type);

void * CGValueForValueBaseTypeKeyPathType(void *value, TTBaseType baseType, CGKeyPathType keyPathType);

#endif /* CGRect_Extension_h */
