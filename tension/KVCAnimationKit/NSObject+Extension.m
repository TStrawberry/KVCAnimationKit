//
//  NSObject+Extension.m
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSObject+Extension.h"
#import "TTDisplayLink.h"
#import "TTAnimationModel.h"

#define StatementVoidPointer(target) void * target = NULL

#define CopyValueToTarget(ObjType, type, ValuePrefix, target)   type value = [(ObjType *)self ValuePrefix##Value]; \
                                                                size_t size = sizeof(type); \
                                                                target = malloc(size); \
                                                                memcpy(target, &value, size);

static char * DISPLAY_LINK_NAME = "displayLink";



@interface NSObject()

@property(nonatomic, strong, readonly) TTDisplayLink * displayLink;

@end

@implementation NSObject (Extension)

extern unsigned int BKDRHash(const char* str);

-(TTDisplayLink *)displayLink {

    TTDisplayLink * displayLink = objc_getAssociatedObject(self, DISPLAY_LINK_NAME);
    if (displayLink == nil) {
        displayLink = [TTDisplayLink displayLinkWithTarget:self selector:@selector(updateKeyPath:)];
        objc_setAssociatedObject(self, DISPLAY_LINK_NAME, displayLink, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return displayLink;
}

-(void) updateAnimationDataForConfig:(TTAnimationModel *)animationModel {

    [self.displayLink updateAnimationModel:animationModel];

    if (self.displayLink.paused) {
        self.displayLink.paused = NO;
    }
}

-(void) updateKeyPath:(CADisplayLink *)displayLink {

    [self.displayLink animation];
}

-(void) invalidateAnimationData {

    objc_setAssociatedObject(self, DISPLAY_LINK_NAME, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}




-(Ivar) ivarKeyPath:(NSString *)keyPath {

    NSArray <NSString *> * vars = [keyPath componentsSeparatedByString:@"."];
    if (vars.count == 0) return nil;

    id obj = self;
    for (int i = 0; i < vars.count; i++) {

        if (i == vars.count - 1) {

            Ivar ivar = class_getInstanceVariable([obj class], [vars[i] UTF8String]);
            return ivar;
        }

        obj = [obj valueForKey:vars[i]];
    }

    return nil;
}

-(TTBaseType)ivarTypeForName:(NSString *)name {

    Ivar i = class_getInstanceVariable([self class], [name UTF8String]);

    if (i == NULL) {

        NSString * _name = [NSString stringWithFormat:@"_%@", name];
        i = class_getInstanceVariable([self class], [_name UTF8String]);

        if (i == NULL) {
            return TTBaseTypeInvalid;
        }
    }

    return [self ivarTypeForIvar:i];
}

-(TTBaseType) ivarTypeForIvar:(Ivar)ivar {

    if (ivar == NULL) {
        return TTBaseTypeInvalid;
    }

    return BKDRHash(ivar_getTypeEncoding(ivar));
}

-(TTBaseType) typeForProperty:(objc_property_t)property {

    if (property == NULL) {
        return TTBaseTypeInvalid;
    }

    return BKDRHash([[[[NSString stringWithUTF8String:property_getAttributes(property)] componentsSeparatedByString:@","] firstObject] UTF8String]);
}

-(TTBaseType) typeWithKey:(NSString *)key isProperty:(BOOL *)isProperty {

    objc_property_t property = class_getProperty([self class], [key UTF8String]);
    if (property != NULL) {
        *isProperty = YES;
        return [self typeForProperty:property];
    }

    SEL keySetter = [self impSetter:NULL property:key];
    Method keyMethod = class_getInstanceMethod([self class], keySetter);

    char * argumentType = method_copyArgumentType(keyMethod, 2);
    NSString * typeStr = [NSString stringWithFormat:@"T%s", argumentType];
    free(argumentType);
//    free(keyMethod);

    if (typeStr) {
        
        TTBaseType type = BKDRHash([typeStr UTF8String]);
        switch (type) {

            case TTBaseTypePropertyInt:
            case TTBaseTypePropertyUInt:
            case TTBaseTypePropertyLong:
            case TTBaseTypePropertyULong:
            case TTBaseTypePropertyLonglong:
            case TTBaseTypePropertyULonglong:
            case TTBaseTypePropertyFloat:
            case TTBaseTypePropertyDouble:
            case TTBaseTypePropertyCGPoint:
            case TTBaseTypePropertyCGRect:
            case TTBaseTypePropertyCGSize:
                *isProperty = YES;
                return type;

            default:
                break;
        }
    }


    Ivar ivar = class_getInstanceVariable([self class], [[NSString stringWithFormat:@"_%@", key] UTF8String]);
    *isProperty = NO;
    return [self ivarTypeForIvar:ivar];

}

-(void *) getValueInIvar:(Ivar)ivar valueType:(TTBaseType)type {

    void * value = [self getIvarHead:ivar];
    void * address = NULL;
    size_t size = [self mallocMemoryForPointer:&address Type:type];
    memcpy(address, value, size);
    return address;
}

-(void *) getIvarHead:(Ivar)ivar {

    ptrdiff_t offset = ivar_getOffset(ivar);
    unsigned char * stuffBytes = (unsigned char *)(__bridge void *)self;
    void * value = stuffBytes + offset;
    return value;
}

-(size_t) mallocMemoryForPointer:(void **)pointer Type:(TTBaseType)type {

    size_t t = 0;

    switch (type) {

        case TTBaseTypePropertyInt:
        case TTBaseTypeIvarInt:
        {
            t = sizeof(int);
            break;
        }

        case TTBaseTypePropertyUInt:
        case TTBaseTypeIvarUInt:
        {
            t = sizeof(unsigned int);
            break;
        }

        case TTBaseTypePropertyLong:
        case TTBaseTypeIvarLong:
        {
            t = sizeof(long);
            break;
        }

        case TTBaseTypePropertyULong:
        case TTBaseTypeIvarULong:
        {
            t = sizeof(unsigned long);
            break;
        }

        case TTBaseTypePropertyLonglong:
        case TTBaseTypeIvarLonglong:
        {
            t = sizeof(long long);
            break;
        }

        case TTBaseTypePropertyULonglong:
        case TTBaseTypeIvarULonglong:
        {
            t = sizeof(unsigned long long);
            break;
        }

        case TTBaseTypePropertyFloat:
        case TTBaseTypeIvarFloat:
        {
            t = sizeof(float);
            break;
        }

        case TTBaseTypePropertyDouble:
        case TTBaseTypeIvarDouble:
        {
            t = sizeof(double);
            break;
        }

        case TTBaseTypePropertyCGRect:
        case TTBaseTypeIvarCGRect:
        {
            t = sizeof(CGRect);
            break;
        }

        case TTBaseTypePropertyCGPoint:
        case TTBaseTypeIvarCGPoint:
        {
            t = sizeof(CGPoint);
            break;
        }

        case TTBaseTypePropertyCGSize:
        case TTBaseTypeIvarCGSize:
        {
            t = sizeof(CGSize);
            break;
        }
            
        default:
        {
            return 0;
        }
    }

    *pointer = malloc(t);
    return t;

}

-(SEL) impSetter:(IMP *)imp property:(NSString *)property {

    NSString * first = [[property substringToIndex:1] uppercaseString];
    NSString * last = [property substringFromIndex:1];
    NSString * selStr = [NSString stringWithFormat:@"set%@%@:", first, last];
    SEL s = NSSelectorFromString(selStr);
    Method m = class_getInstanceMethod([self class],  s);
    IMP i = method_getImplementation(m);
    if (imp != NULL) {
        *imp = i;
    }
    
    return s;

}


-(void *) valueForKeyPathType:(CGKeyPathType)keyPathType {

    StatementVoidPointer(target);

    switch (keyPathType) {

        case CGKeyPathTypeOrigin:
        {
            CopyValueToTarget(NSValue, CGPoint, CGPoint, target);
            break;
        }

        case CGKeyPathTypeSize:
        {
            CopyValueToTarget(NSValue, CGSize, CGSize, target);
            break;
        }

        case CGKeyPathTypeX:
        case CGKeyPathTypeY:
        case CGKeyPathTypeWidth:
        case CGKeyPathTypeHeight:
        {
            CopyValueToTarget(NSNumber, CGFloat, double, target);
            break;
        }

        default:
            break;
    }

    return target;
}

-(void *) valueForBaseType:(TTBaseType)baseType {

    StatementVoidPointer(target);

    switch (baseType) {

        case TTBaseTypePropertyInt:
        case TTBaseTypeIvarInt:
        {

            CopyValueToTarget(NSNumber, int, int, target);
            break;
        }

        case TTBaseTypePropertyUInt:
        case TTBaseTypeIvarUInt:
        {

            CopyValueToTarget(NSNumber, unsigned int, unsignedInt, target);
            break;
        }

        case TTBaseTypePropertyLong:
        case TTBaseTypeIvarLong:
        {

            CopyValueToTarget(NSNumber, long, long, target);
            break;
        }

        case TTBaseTypePropertyULong:
        case TTBaseTypeIvarULong:
        {
            CopyValueToTarget(NSNumber, unsigned long, unsignedLong, target);
            break;
        }

        case TTBaseTypePropertyLonglong:
        case TTBaseTypeIvarLonglong:
        {

            CopyValueToTarget(NSNumber, long long, longLong, target);
            break;
        }

        case TTBaseTypePropertyULonglong:
        case TTBaseTypeIvarULonglong:
        {
            CopyValueToTarget(NSNumber, unsigned long long, unsignedLongLong, target);
            break;
        }

        case TTBaseTypePropertyFloat:
        case TTBaseTypeIvarFloat:
        {

            CopyValueToTarget(NSNumber, float, float, target);
            break;
        }

        case TTBaseTypePropertyDouble:
        case TTBaseTypeIvarDouble:
        {
            CopyValueToTarget(NSNumber, double, double, target);
            break;
        }

        case TTBaseTypePropertyCGRect:
        case TTBaseTypeIvarCGRect:
        {

            CopyValueToTarget(NSValue, CGRect, CGRect, target);
            break;
        }

        case TTBaseTypePropertyCGPoint:
        case TTBaseTypeIvarCGPoint:
        {
            CopyValueToTarget(NSValue, CGPoint, CGPoint, target);
            break;
        }

        case TTBaseTypePropertyCGSize:
        case TTBaseTypeIvarCGSize:
        {
            CopyValueToTarget(NSValue, CGSize, CGSize, target);
            break;
        }
            
        default:
        {
            return nil;
        }
    }
    
    return target;

}

@end


