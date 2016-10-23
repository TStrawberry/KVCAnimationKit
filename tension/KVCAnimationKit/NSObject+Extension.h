//
//  NSObject+Extension.h
//  tension
//
//  Created by 唐韬 on 16/9/20.
//  Copyright © 2016年 TT. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>
#import "GlobleEnum.h"

@class TTAnimationModel;

@interface NSObject (Extension)

-(void) updateAnimationDataForConfig:(TTAnimationModel *)animationModel;

-(Ivar) ivarKeyPath:(NSString *)keyPath;
-(TTBaseType)ivarTypeForName:(NSString *)name;
-(TTBaseType) ivarTypeForIvar:(Ivar)ivar;
-(TTBaseType) typeForProperty:(objc_property_t)property;
-(TTBaseType) typeWithKey:(NSString *)key isProperty:(BOOL *)isProperty;

-(void *) getValueInIvar:(Ivar)ivar valueType:(TTBaseType)type;
-(size_t) mallocMemoryForPointer:(void **)pointer Type:(TTBaseType)type;

-(void *) getIvarHead:(Ivar)ivar;
-(SEL) impSetter:(IMP *)imp property:(NSString *)property;

-(void *) valueForKeyPathType:(CGKeyPathType)keyPathType;
-(void *) valueForBaseType:(TTBaseType)baseType;

@end
