//
//  NSObject+methodDescriptionForSelectorInProtocol.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/20/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject+methodDescriptionForSelectorInProtocol.h"

@implementation NSObject (methodDescriptionForSelectorInProtocol)

BOOL isNullMethodDescription(struct objc_method_description description)
{
    return (description.name == NULL && description.types == NULL);
}

+ (struct objc_method_description)methodDescriptionForSelector:(SEL)aSelector inProtocol:(Protocol *)protocol
{
	if (!protocol)
		return (struct objc_method_description){NULL, NULL};
	
    //required methods
    struct objc_method_description description = protocol_getMethodDescription(protocol, aSelector, YES, YES);
    if (isNullMethodDescription(description))
    {
        //optional methods
        description = protocol_getMethodDescription(protocol, aSelector, NO, YES);
    }
    //look in the super-protocols
    if (isNullMethodDescription(description))
    {
        unsigned int protocolCount = 0;
        Protocol * __unsafe_unretained *protocols = protocol_copyProtocolList(protocol, &protocolCount);
        if (protocols == NULL)
        {
            return description;
        }
        unsigned int protocolCursor = 0;
        for (protocolCursor = 0; protocolCursor < protocolCount; protocolCursor++)
        {
            Protocol *thisProtocol = protocols[protocolCursor];
            description = [self methodDescriptionForSelector:aSelector inProtocol:thisProtocol];
            if (!isNullMethodDescription(description)) break;
        }
        free(protocols);
    }
    return description;
}

@end
