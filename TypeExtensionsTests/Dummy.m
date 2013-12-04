//
//  Dummy.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/21/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "Dummy.h"

@implementation Dummy

+ (instancetype)dummy
{
	return [[[self alloc] init] autorelease];
}

- (id)init
{
	if (!(self = [super init]))
		return nil;
	
	_something = nil;
	
	return self;
}

@end
