//
//  NSString+orNull.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/8/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSString+orNull.h"

@implementation NSString (orNull)

+ (id)stringWithCStringOrNil:(const char *)cString encoding:(NSStringEncoding)enc
{
	if (cString)
		return [NSString stringWithCString:cString encoding:enc];
	else
		return nil;
}

@end
