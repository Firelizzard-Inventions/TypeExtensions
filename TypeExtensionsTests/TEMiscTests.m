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

@interface TEMiscTests : XCTestCase <DeallocListener>

@end

@implementation TEMiscTests {
	NSAutoreleasePool * _pool;
	BOOL _caughtDeallocNotification, _caughtKVONotification;
}

- (void)setUp
{
    [super setUp];
	
	_pool = [[NSAutoreleasePool alloc] init];
	
	_caughtDeallocNotification = NO;
	_caughtKVONotification = NO;
}

- (void)tearDown
{
	[_pool drain];
	
    [super tearDown];
}

- (void)testDeallocateNotifier
{
	id obj;
	@autoreleasepool {
		obj = [Dummy dummy];
		[obj addDeallocListener:self];
	}
	
	if (!_caughtDeallocNotification)
		XCTFail(@"Did not receive deallocation notification");
}

- (void)objectDidDeallocate:(id)obj
{
	_caughtDeallocNotification = YES;
}

- (void)testKVOBugs
{
	id obj = [Dummy dummy];
	
	[obj setValue:@"Hi" forKey:@"something"];
	
	if (![@"Hi" isEqualToString:[obj valueForKey:@"something"]])
		XCTFail(@"KVC failed");
	
	[obj addObserver:self forKeyPath:@"something" options:0 context:nil];
	
	[obj addDeallocListener:self];
	
	[obj setValue:@"Lo" forKey:@"something"];
	
	if (![@"Lo" isEqualToString:[obj valueForKey:@"something"]])
		XCTFail(@"KVC failed");
	
	@try {
		[obj removeObserver:self forKeyPath:@"something" context:nil];
	}
	@catch (NSException *exception) {
		XCTFail(@"Failed: %@", exception);
	}
	
	if (!_caughtKVONotification)
		XCTFail(@"KVO notification not caught");
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	_caughtKVONotification = YES;
}

- (void)testObjectForKey
{
	id obj = [Dummy dummy];
	char * key = "com.firelizzard.TypeExtensions.Test.Misc.associatedObject.ObjectForKey";
	NSString * test = [NSMutableString stringWithString:@"Here is my test object"];
	
	// make sure DN doesn't interfere
	[obj addDeallocListener:self];
	
	[obj setAssociatedObject:test forKey:key];
	if (test != [obj associatedObjectForKey:key])
		XCTFail(@"Did not retreive correct object");
	[obj setAssociatedObject:nil forKey:key];
	if ([obj associatedObjectForKey:key])
		XCTFail(@"Object should be nil");
	
	[obj setAssociatedObject:test forSelector:_cmd];
	if (test != [obj associatedObjectForSelector:_cmd])
		XCTFail(@"Did not retreive correct object");
	[obj setAssociatedObject:nil forSelector:_cmd];
	if ([obj associatedObjectForSelector:_cmd])
		XCTFail(@"Object should be nil");
	
	[obj setAssociatedObject:test forClass:[self class]];
	if (test != [obj associatedObjectForClass:[self class]])
		XCTFail(@"Did not retreive correct object");
	[obj setAssociatedObject:nil forClass:[self class]];
	if ([obj associatedObjectForClass:[self class]])
		XCTFail(@"Object should be nil");
}

- (void)testBadTypes
{
	@try {
		[[[[NSObject alloc] init] autorelease] addDeallocListener:self];
		XCTFail(@"Adding a DeallocListener to an NSObject should fail");
	}
	@catch (NSException *exception) { }
	
	@try {
		[@"asdf" addDeallocListener:self];
		XCTFail(@"Adding a DeallocListener to an NSObject should fail");
	}
	@catch (NSException *exception) { }
	
	@try {
		[@(1) addDeallocListener:self];
		XCTFail(@"Adding a DeallocListener to an NSObject should fail");
	}
	@catch (NSException *exception) { }
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