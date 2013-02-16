//
//  NSObject+varargsArray.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/16/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject+varargsArray.h"

@implementation NSObject (varargsArray)

- (NSArray *)varargsArrayNilTerminatedWithFirstArg:(id)firstArg, ...
{
	NSMutableArray * argsArr = @[].mutableCopy;
	
	va_list args;
	va_start(args, firstArg);
	for (id arg = firstArg; arg != nil; arg = va_arg(args, id))
		[argsArr addObject:arg];
	va_end(args);
	
	NSArray * _argsArr = [NSArray arrayWithArray:argsArr];
	[argsArr release];
	
	return _argsArr;
}

@end
