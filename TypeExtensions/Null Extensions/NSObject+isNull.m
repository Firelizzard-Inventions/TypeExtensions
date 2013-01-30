//
//  NSObject+isNulll.m
//  ObjectiveSQL
//
//  Created by Ethan Reesor on 11/20/12.
//  Copyright (c) 2012 Lens Flare. All rights reserved.
//

#import "NSObject+isNull.h"

@implementation NSObject (isNull)

- (BOOL)isNull
{
	return self == [NSNull null];
}

@end
