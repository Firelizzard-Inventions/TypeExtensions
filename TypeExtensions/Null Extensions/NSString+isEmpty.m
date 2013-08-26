//
//  NSString+isEmpty.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. Some rights reserved, see license.
//

#import "NSString+isEmpty.h"

#import "NSObject+isNull.h"

@implementation NSString (isEmpty)

- (BOOL)isEmpty
{
	return [self isEqualToString:@""];
}

- (BOOL)isNull
{
	return [super isNull] || [self isEmpty];
}

@end
