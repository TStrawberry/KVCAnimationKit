//
//  TTCGModel.m
//  tension
//
//  Created by 唐韬 on 16/9/27.
//  Copyright © 2016年 TT. All rights reserved.
//

#import "TTCGModel.h"
#import "NSObject+Extension.h"
#import "CGRect+Extension.h"
#import <objc/objc-runtime.h>

@interface TTCGModel()

@end

@implementation TTCGModel

-(instancetype) initWithOriginal:(void *)original target:(void *)target keyPathTyep:(CGKeyPathType)type {

    if (self = [super init]) {

        _originalValue = original;
        _targetValue = target;
        _type = type;
    }

    return self;
}


-(void) getCurrentValue:(void *)current ForProgress:(NSTimeInterval)progress originalTopValue:(void *)topValue baseType:(TTBaseType)baseType {


    switch (baseType) {

        case TTBaseTypeIvarCGRect:
        case TTBaseTypePropertyCGRect:
        {

            CGRect currentValue = CGRectZero;

            switch (_type) {

                case CGKeyPathTypeX:
                case CGKeyPathTypeY:
                case CGKeyPathTypeWidth:
                case CGKeyPathTypeHeight:
                {

                    CGFloat ori = *((CGFloat *)_originalValue);
                    CGFloat tar = *((CGFloat *)_targetValue);
                    CGFloat curr = ori + (tar - ori) * progress;
                    currentValue = CGRectSetValueForType(*((CGRect *)topValue), &curr, _type);

                    break;
                }

                case CGKeyPathTypeSize:
                {
                    CGSize ori = *((CGSize *)_originalValue);
                    CGSize tar = *((CGSize *)_targetValue);
                    CGSize curr = CGSizeFromOriginalToTargetWithProgress(ori, tar, progress);
                    currentValue = CGRectSetValueForType(*((CGRect *)topValue), &curr, _type);

                    break;
                }

                case CGKeyPathTypeOrigin:
                {

                    CGPoint ori = *((CGPoint *)_originalValue);
                    CGPoint tar = *((CGPoint *)_targetValue);
                    CGPoint curr = CGPointFromOriginalToTargetWithProgress(ori, tar, progress);
                    currentValue = CGRectSetValueForType(*((CGRect *)topValue), &curr, _type);
                    
                    break;
                }
                    
                default:
                    break;
            }

            memcpy(current, &currentValue, sizeof(CGRect));

            break;
        }

        case TTBaseTypeIvarCGPoint:
        case TTBaseTypePropertyCGPoint:
        {

            CGFloat ori = *((CGFloat *)_originalValue);
            CGFloat tar = *((CGFloat *)_targetValue);
            CGFloat curr = ori + (tar - ori) * progress;
            CGPoint currentValue = CGPointSetValueForType(*((CGPoint *)topValue), curr, _type);
            memcpy(current, &currentValue, sizeof(CGPoint));

            break;

        }

        case TTBaseTypeIvarCGSize:
        case TTBaseTypePropertyCGSize:
        {

            CGFloat ori = *((CGFloat *)_originalValue);
            CGFloat tar = *((CGFloat *)_targetValue);
            CGFloat curr = ori + (tar - ori) * progress;
            CGSize currentValue = CGSizeSetValueForType(*((CGSize *)topValue), curr, _type);
            memcpy(current, &currentValue, sizeof(CGSize));

            break;
        }
        default:
            break;
    }

}

-(void)dealloc {

    free(_originalValue);
    free(_targetValue);
}

@end
