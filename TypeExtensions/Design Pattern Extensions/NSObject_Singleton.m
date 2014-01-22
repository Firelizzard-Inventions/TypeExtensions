//
//  NSObject_singleton.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/11/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject_Singleton.h"

#import "NSObject+associatedObject.h"

#define kSingletonKey "com.firelizzard.TypeExtensions.Misc.Singleton.key"

@implementation NSObject_Singleton

+ (id)sharedInstance
{
	id shared = [self associatedObjectForKey:kSingletonKey];
	
	if (!shared)
		[self setAssociatedObject:(shared = [[super allocWithZone:NULL] init]) forKey:kSingletonKey];
	
	return shared;
}

+ (id)allocWithZone:(NSZone *)zone
{
	return [self sharedInstance];
}

- (id)copyWithZone:(NSZone *)zone {
	return self;
}

@end
