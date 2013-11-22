//
//  TypeExtensionsTests.m
//  TypeExtensionsTests
//
//  Created by Ethan Reesor on 11/21/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <XCTest/XCTest.h>
#import <TypeExtensions/Collection.h>

#import "Dummy.h"

@interface TECollectionTests : XCTestCase

@end

@implementation TECollectionTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testEntrySet
{
	NSDictionary * dictionary = @{ @(1) : @"One", @(2) : @"Two" };

	NSSet * entries = [dictionary entrySet];
	
	NSMutableSet * test = [NSMutableSet setWithCapacity:dictionary.count];
	[test addObject:[NSDictionaryEntrySetEntry dictionaryEntryWithKey:@(1) forDictionary:dictionary]];
	[test addObject:[NSDictionaryEntrySetEntry dictionaryEntryWithKey:@(2) forDictionary:dictionary]];
	
	if (![entries isEqual:test])
		XCTFail(@"Sets are not equal");
	
	for (NSDictionaryEntrySetEntry * entry in entries) {
		if ([@(1) isEqual:entry.key]) {
			if (![dictionary[@(1)] isEqual:entry.object])
				XCTFail(@"Entry set is bad");
		} else if ([@(2) isEqual:entry.key]) {
			if (![dictionary[@(2)] isEqual:entry.object])
				XCTFail(@"Entry set is bad");
		}
	}
}

- (void)testNonRetainingZeroingArray
{
	NSObject * obj = [[Dummy alloc] init];
	
	NSMutableArray_NonRetaining_Zeroing * arr = [NSMutableArray_NonRetaining_Zeroing array];
	
	[arr addObject:obj];
	
	if (!arr.count)
		XCTFail(@"Array does not contain object");
	
	[obj release];
	
	if (arr.count)
		XCTFail(@"Array contains object after it's release");
}

- (void)testNonRetainingZeroingDictionary
{
	NSObject * obj = [[Dummy alloc] init];
	
	NSMutableDictionary_NonRetaining_Zeroing * dict = [NSMutableDictionary_NonRetaining_Zeroing dictionary];
	
	dict[@(1)] = obj;
	
	if (!dict.count)
		XCTFail(@"Array does not contain object");
	
	[obj release];
	
	if (dict.count)
		XCTFail(@"Array contains object after it's release");
}

@end
