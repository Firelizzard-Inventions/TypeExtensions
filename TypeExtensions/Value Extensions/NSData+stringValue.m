//
//  NSData+stringValue.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/22/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSData+stringValue.h"

@implementation NSData (stringValue)

- (NSString *)stringValue
{
	return [[NSString alloc] initWithData:self encoding:NSUTF8StringEncoding];
}

@end
