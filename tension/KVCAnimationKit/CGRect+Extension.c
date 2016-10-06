//
//  CGRect+Extension.c
//  tension
//
//  Created by 唐韬 on 16/9/24.
//  Copyright © 2016年 TT. All rights reserved.
//

#include <stdlib.h>
#include "CGRect+Extension.h"

extern void *memcpy(void *__dst, const void *__src, size_t __n);

unsigned int BKDRHash(const char *str){
    
    unsigned int seed = 131; // 31 131 1313 13131 131313 etc..
    unsigned int hash = 0;
    while (*str)
    {
        hash = hash * seed + (*str++);
    }
    return (hash & 0x7FFFFFFF);
}

CGRect CGRectSetValueForKey(CGRect rect, void * value, const char * key) {

    CGKeyPathType type = BKDRHash(key);

    return CGRectSetValueForType(rect, value, type);
}

CGRect CGRectSetValueForType(CGRect rect, void * value, CGKeyPathType type) {

    switch (type) {

        case CGKeyPathTypeOrigin:
        {
            rect.origin = *((CGPoint *)value);
            break;
        }

        case CGKeyPathTypeX:
        {
            rect.origin.x = *((CGFloat *)value);
            break;
        }

        case CGKeyPathTypeY:
        {
            rect.origin.y = *((CGFloat *)value);
            break;
        }

        case CGKeyPathTypeSize:
        {
            rect.size = *((CGSize *)value);
            break;
        }

        case CGKeyPathTypeWidth:
        {
            rect.size.width = *((CGFloat *)value);
            break;
        }

        case CGKeyPathTypeHeight:
        {
            rect.size.height = *((CGFloat *)value);
            break;
        }
            
        default:
            break;
    }
    
    return rect;
    
}


CGSize CGSizeSetValueForKey(CGSize size, CGFloat value, const char * key) {

    CGKeyPathType type = BKDRHash(key);
    return CGSizeSetValueForType(size, value, type);
}

CGSize CGSizeSetValueForType(CGSize size, CGFloat value, CGKeyPathType type) {

    if (type == CGKeyPathTypeWidth) {

        size.width = value;
    } else if (type == CGKeyPathTypeHeight) {

        size.height = value;
    }

    return size;

}

CGPoint CGPointSetValueForKey(CGPoint point, CGFloat value, const char * key) {

    CGKeyPathType type = BKDRHash(key);
    return CGPointSetValueForType(point, value, type);
}

CGPoint CGPointSetValueForType(CGPoint point, CGFloat value, CGKeyPathType type) {


    if (type == CGKeyPathTypeX) {

        return CGPointMake(value, point.y);

    } else if (type == CGKeyPathTypeY) {

        return CGPointMake(point.x, value);
    }
    
    return point;
}

CGKeyPathType CGTypeForKey(const char * key){

    CGKeyPathType type = BKDRHash(key);

    switch (type) {
        case   CGKeyPathTypeInvalid:

        case CGKeyPathTypeOrigin:
        case CGKeyPathTypeX:
        case CGKeyPathTypeY:

        case CGKeyPathTypeSize:
        case CGKeyPathTypeWidth:
        case CGKeyPathTypeHeight:
            return type;

        default:
            return CGKeyPathTypeInvalid;
    }
}

CGPoint CGPointFromOriginalToTargetWithProgress(CGPoint original, CGPoint target, double progress) {

    CGFloat x = original.x + (target.x - original.x) * progress;
    CGFloat y = original.y + (target.y - original.y) * progress;
    return CGPointMake(x, y);
}
CGSize CGSizeFromOriginalToTargetWithProgress(CGSize original, CGSize target, double progress) {

    CGFloat w = original.width + (target.width - original.width) * progress;
    CGFloat h = original.height + (target.height - original.height) * progress;
    return CGSizeMake(w, h);
}


CGRect CGRectFromOriginalToTargetWithProgress(CGRect original, CGRect target, double progress) {

    CGPoint targetPoint = CGPointFromOriginalToTargetWithProgress(original.origin, target.origin, progress);
    CGSize targetSize = CGSizeFromOriginalToTargetWithProgress(original.size, target.size, progress);
    return CGRectMake(targetPoint.x, targetPoint.y, targetSize.width, targetSize.height);
}

void * CGRectValueForType(CGRect rect, CGKeyPathType type) {

    void * value = NULL;

    switch (type) {

        case CGKeyPathTypeOrigin:
        {
            CGPoint targetValue = rect.origin;
            size_t size = sizeof(CGPoint);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }

        case CGKeyPathTypeX:
        {
            CGFloat targetValue = rect.origin.x;
            size_t size = sizeof(CGFloat);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }

        case CGKeyPathTypeY:
        {

            CGFloat targetValue = rect.origin.y;
            size_t size = sizeof(CGFloat);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }

        case CGKeyPathTypeSize:
        {
            CGSize targetValue = rect.size;
            size_t size = sizeof(CGSize);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }

        case CGKeyPathTypeWidth:
        {
            CGFloat targetValue = rect.size.width;
            size_t size = sizeof(CGFloat);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }

        case CGKeyPathTypeHeight:
        {
            CGFloat targetValue = rect.size.height;
            size_t size = sizeof(CGFloat);
            value = malloc(size);
            memcpy(value, &targetValue, size);
            break;
        }
            
        default:
            break;
    }

    return value;

}

void * CGSizeValueForType(CGSize size, CGKeyPathType type) {

    void * value = NULL;
    size_t sz = sizeof(CGFloat);
    value = malloc(sz);
    CGFloat targetValue = 0;

    if (type == CGKeyPathTypeWidth) {

        targetValue = size.width;

    } else if (type == CGKeyPathTypeHeight) {

        targetValue = size.height;
    }

    memcpy(value, &targetValue, sz);
    return value;
}

void * CGPointValueForType(CGPoint point, CGKeyPathType type) {

    void * value = NULL;
    size_t size = sizeof(CGFloat);
    value = malloc(size);
    CGFloat targetValue = 0;

    if (type == CGKeyPathTypeX) {

        targetValue = point.x;

    } else if (type == CGKeyPathTypeY) {

        targetValue = point.y;
    }

    memcpy(value, &targetValue, size);
    return value;
}


void * CGValueForValueBaseTypeKeyPathType(void * value, TTBaseType baseType, CGKeyPathType keyPathType) {

    void * target = NULL;

    switch (baseType) {

        case TTBaseTypePropertyCGRect:
        case TTBaseTypeIvarCGRect:
        {

            CGRect topValue = *((CGRect *)value);

            switch (keyPathType) {

                case CGKeyPathTypeOrigin:
                {
                    CGPoint point = topValue.origin;
                    size_t size = sizeof(CGPoint);
                    target = malloc(size);
                    memcpy(target, &point, size);
                    break;
                }

                case CGKeyPathTypeSize:
                {
                    CGSize size1 = topValue.size;
                    size_t size = sizeof(CGSize);
                    target = malloc(size);
                    memcpy(target, &size1, size);
                    break;
                }

                case CGKeyPathTypeX:
                {

                    CGFloat x = topValue.origin.x;
                    size_t size = sizeof(CGFloat);
                    target = malloc(size);
                    memcpy(target, &x, size);
                    break;
                }

                case CGKeyPathTypeY:
                {
                    CGFloat y = topValue.origin.y;
                    size_t size = sizeof(CGFloat);
                    target = malloc(size);
                    memcpy(target, &y, size);
                    break;
                }

                case CGKeyPathTypeWidth:
                {
                    CGFloat w = topValue.size.width;
                    size_t size = sizeof(CGFloat);
                    target = malloc(size);
                    memcpy(target, &w, size);
                    break;
                }
                case CGKeyPathTypeHeight:
                {

                    CGFloat h = topValue.size.height;
                    size_t size = sizeof(CGFloat);
                    target = malloc(size);
                    memcpy(target, &h, size);
                    break;
                }

                default:
                    break;
            }

            break;
        }

        case TTBaseTypePropertyCGPoint:
        case TTBaseTypeIvarCGPoint:
        {
            CGPoint topValue = *((CGPoint *)value);

            if (baseType == CGKeyPathTypeX) {

                CGFloat x = topValue.x;
                size_t size = sizeof(CGFloat);
                target = malloc(size);
                memcpy(target, &x, size);

            } else {

                CGFloat y = topValue.y;
                size_t size = sizeof(CGFloat);
                target = malloc(size);
                memcpy(target, &y, size);
            }
            break;

        }

        case TTBaseTypePropertyCGSize:
        case TTBaseTypeIvarCGSize:
        {
            CGSize topValue = *((CGSize *)value);

            if (baseType == CGKeyPathTypeWidth) {

                CGFloat w = topValue.width;
                size_t size = sizeof(CGFloat);
                target = malloc(size);
                memcpy(target, &w, size);

            } else {

                CGFloat h = topValue.height;
                size_t size = sizeof(CGFloat);
                target = malloc(size);
                memcpy(target, &h, size);
            }

            break;
        }

        default:
            break;
    }

    return target;
}



