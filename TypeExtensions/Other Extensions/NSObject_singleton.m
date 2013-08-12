//
//  NSObject_singleton.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/11/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject_Singleton.h"

@implementation NSObject_Singleton

+ (id)sharedInstance
{
	return [[super allocWithZone:NULL] init];
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

- (id)retain
{
	return self;
}

- (id)autorelease
{
	return self;
}

- (oneway void)release
{
	// don't release
}

@end
