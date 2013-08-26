//
//  NSObject+abstractClass.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 4/10/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject+abstractClass.h"

@implementation NSObject (abstractClass)

+ (NSException *)_subclassImplementationExceptionFromMethod:(SEL)method isClassMethod:(BOOL)classMethod
{
	NSString * string = classMethod ? @"+" : @"-";
	string = [string stringByAppendingString:NSStringFromSelector(method)];
	string = [NSString stringWithFormat:@"You must override %@ in a subclass", string];
	
	return [NSException exceptionWithName:NSInternalInconsistencyException
								   reason:string
								 userInfo:nil];
}

@end
