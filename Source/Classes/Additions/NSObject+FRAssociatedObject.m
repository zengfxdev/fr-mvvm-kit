//
//  NSObject+FRAssociatedObject.m
//  FRMvvmKit
//
//  Created by 曾凡旭 on 2017/5/17.
//  Copyright © 2017年 zengfxios. All rights reserved.
//

#import "NSObject+FRAssociatedObject.h"
#import <objc/runtime.h>

@implementation NSObject (FRAssociatedObject)

- (id)object:(SEL)key {
    return objc_getAssociatedObject(self, key);
}

- (void)setRetainNonatomicObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setCopyNonatomicObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)setRetainObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_RETAIN);
}

- (void)setCopyObject:(id)object withKey:(SEL)key {
    objc_setAssociatedObject(self, key, object, OBJC_ASSOCIATION_COPY);
}


@end
