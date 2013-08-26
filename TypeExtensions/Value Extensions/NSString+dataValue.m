//
//  NSString+dataValue.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSString+dataValue.h"

@implementation NSString (dataValue)

- (NSData *)dataValue
{
	return [self dataUsingEncoding:NSUTF8StringEncoding];
}

@end
