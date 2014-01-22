//
//  PRIVATE_NSObject_KVCArrayForwarding.m
//  TypeExtensions
//
//  Created by Ethan Reesor on 2/17/13.
//  Copyright (c) 2013 Lens Flare. Some rights reserved, see license.
//

#import "NSObject_KVCArrayForwarding.h"

#import <objc/runtime.h>

@interface NSObject_KVCArrayForwarding ()

- (NSArray *)arrayProperty;
- (NSMutableArray *)mutableArrayProperty;

@end

@implementation NSObject_KVCArrayForwarding {
	id target;
	NSString * keyPath;
}

- (id)initWithTarget:(id)theTarget keyPath:(NSString *)theKeyPath isMutable:(BOOL)isMutable
{
	if (self = [super init]) {
		target = theTarget;
		keyPath = theKeyPath;
		NSString * KeyPath = keyPath.capitalizedString;
		
		Class class = [self class];
		Class targetClass = [target class];
		
		NSString * className = NSStringFromClass(class);
		NSString * targetClassName = NSStringFromClass(targetClass);
		NSString * subclassName = [NSString stringWithFormat:@"%@_%@_%@", className, targetClassName, KeyPath];
		
		Class subclass = objc_allocateClassPair(class, subclassName.UTF8String, 0);
		
		if (subclass == nil)
			return nil;
		
//		class_addMethod(subclass,
//						@selector(dealloc),
//						[class instanceMethodForSelector:@selector(dealloc)],
//						"v@:");
		
		class_addMethod(subclass,
						NSSelectorFromString([NSString stringWithFormat:@"countOf%@", KeyPath]),
						[class instanceMethodForSelector:@selector(countOfArray)],
						"L@:");
		
		class_addMethod(subclass,
						NSSelectorFromString([NSString stringWithFormat:@"objectIn%@AtIndex:", KeyPath]),
						[class instanceMethodForSelector:@selector(objectInArrayAtIndex:)],
						"@@:L");
		
		class_addMethod(subclass,
						NSSelectorFromString([NSString stringWithFormat:@"%@AtIndexes:", keyPath]),
						[class instanceMethodForSelector:@selector(objectsAtIndexes:)],
						"@@:@");
		
		class_addMethod(subclass,
						NSSelectorFromString([NSString stringWithFormat:@"get%@:range:", KeyPath]),
						[class instanceMethodForSelector:@selector(getArrayObjects:range:)],
						"v@:^@{_NSRange=LL}");
		
		if (isMutable) {
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"insertObject:in%@AtIndex:", KeyPath]),
							[class instanceMethodForSelector:@selector(insertObject:inArrayAtIndex:)],
							"v@:@L");
			
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"insert%@:atIndexes:", KeyPath]),
							[class instanceMethodForSelector:@selector(insertArrayObjects:atIndexes:)],
							"v@:@@");
			
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"removeObjectFrom%@AtIndex:", KeyPath]),
							[class instanceMethodForSelector:@selector(removeObjectFromArrayAtIndex:)],
							"v@:L");
			
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"remove%@AtIndexes:", KeyPath]),
							[class instanceMethodForSelector:@selector(removeArrayObjectsAtIndexes:)],
							"v@:@");
			
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"replaceObjectIn%@AtIndex:withObject:", KeyPath]),
							[class instanceMethodForSelector:@selector(replaceObjectInArrayAtIndex:withObject:)],
							"v@:L@");
			
			class_addMethod(subclass,
							NSSelectorFromString([NSString stringWithFormat:@"replace%@AtIndexes:withChildren:", KeyPath]),
							[class instanceMethodForSelector:@selector(replaceArrayObjectsAtIndexes:withChildren:)],
							"v@:@@");
		}
		
		objc_registerClassPair(subclass);
		
		object_setClass(self, subclass);
	}
	return self;
}


- (NSArray *)arrayProperty
{
	id array = [target valueForKey:keyPath];
	if (![array isKindOfClass:[NSArray class]])
		[NSException raise:@"Invalid property access" format:@"property %@ of %@ is not an instance of (NSArray *)", keyPath, target];
	return array;
}

- (NSMutableArray *)mutableArrayProperty
{
	id array = [target valueForKey:keyPath];
	if (![array isKindOfClass:[NSMutableArray class]])
		[NSException raise:@"Invalid property access" format:@"property %@ of %@ is not an instance of (NSMutableArray *)", keyPath, target];
	return array;
}

- (NSUInteger)countOfArray
{
	return self.arrayProperty.count;
}

- (id)objectInArrayAtIndex:(NSUInteger)index
{
	return self.arrayProperty[index];
}

- (NSArray *)arrayObjectsAtIndexes:(NSIndexSet *)indexes
{
	return [self.arrayProperty objectsAtIndexes:indexes];
}

- (void)getArrayObjects:(__unsafe_unretained id *)buffer range:(NSRange)inRange
{
	[self.arrayProperty getObjects:buffer range:inRange];
}

- (void)insertObject:(id)object inArrayAtIndex:(NSUInteger)index
{
	[self.mutableArrayProperty insertObject:object atIndex:index];
}

- (void)insertArrayObjects:(NSArray *)array atIndexes:(NSIndexSet *)indexes
{
	[self.mutableArrayProperty insertObjects:array atIndexes:indexes];
}

- (void)removeObjectFromArrayAtIndex:(NSUInteger)index
{
	[self.mutableArrayProperty removeObjectAtIndex:index];
}

- (void)removeArrayObjectsAtIndexes:(NSIndexSet *)indexes
{
	[self.mutableArrayProperty removeObjectsAtIndexes:indexes];
}

- (void)replaceObjectInArrayAtIndex:(NSUInteger)index withObject:(id)object
{
	self.mutableArrayProperty[index] = object;
}

- (void)replaceArrayObjectsAtIndexes:(NSIndexSet *)indexes withChildren:(NSArray *)array
{
	[self.mutableArrayProperty replaceObjectsAtIndexes:indexes withObjects:array];
}

@end
