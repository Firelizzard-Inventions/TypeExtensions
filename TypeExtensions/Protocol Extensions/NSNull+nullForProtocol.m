//
//  NSNull+nullForProtocol.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/20/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSNull+nullForProtocol.h"

#import <objc/runtime.h>
#import "NSObject_ProtocolConformer.h"

@implementation NSNull (nullForProtocol)

+ (id)nullForProtocol:(Protocol *)protocol
{
    NSString *className = [NSString stringWithFormat:@"__Null%s", protocol_getName(protocol)];
    Class NullClass = NSClassFromString(className);
    id nullObject = objc_getAssociatedObject(NullClass, "instance");
	if (nullObject == nil)
    {
        NullClass = objc_allocateClassPair(self, [className UTF8String], 0);
        class_addProtocol(NullClass, protocol);
        objc_registerClassPair(NullClass);
        nullObject = [[NSObject_ProtocolConformer alloc] initWithProtocol:protocol];
        objc_setAssociatedObject(NullClass, "instance", nullObject, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return nullObject;
}

@end