//
//  NSNotificationCenter+errorCenter.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/10/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSNotificationCenter+errorCenter.h"

@implementation NSNotificationCenter (errorCenter)

+ (NSNotificationCenter *)errorCenter
{
	static NSNotificationCenter * inst;
	
	if (!inst)
		inst = [[NSNotificationCenter alloc] init];
	
	return inst;
}

@end