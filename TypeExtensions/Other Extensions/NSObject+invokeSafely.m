//
//  NSObject+invokeSafely.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 11/20/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import "NSObject+invokeSafely.h"

@implementation NSObject (invokeSafely)

static void handler(int sig) {
	@throw [NSException exceptionWithName:@"signal" reason:@"Received %d" userInfo:nil];
}

+ (void)invokeSafely:(NSInvocation *)invocation
{
	signal(0x91, &handler);
	
	@try {
		[invocation invoke];
	}
	@finally {
		signal(0x91, SIG_DFL);
	}
}

@end
