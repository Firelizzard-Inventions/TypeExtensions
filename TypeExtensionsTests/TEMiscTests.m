//
//  TypeExtensionsTests.m
//  TypeExtensionsTests
//
//  Created by Ethan Reesor on 11/21/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <XCTest/XCTest.h>

#import <TypeExtensions/Misc.h>

#import "Dummy.h"

@interface TEMiscTests : XCTestCase

@end

@implementation TEMiscTests {
	NSAutoreleasePool * _pool;
}

- (void)setUp
{
    [super setUp];
	
	_pool = [[NSAutoreleasePool alloc] init];
}

- (void)tearDown
{
	[_pool drain];
	
    [super tearDown];
}

- (void)testSingleton
{
	id s1 = [NSObject_Singleton sharedInstance];
	id s2 = [s1 copyWithZone:[self zone]];
	id s3 = [[NSObject_Singleton allocWithZone:[self zone]] init];
	
	if (s1 != s2 || s2 != s3)
		XCTFail(@"Sington pattern broken");
}

@end