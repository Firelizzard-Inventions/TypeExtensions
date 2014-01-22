//
//  TXBTree.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 12/5/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXBTree : NSDictionary

@property (retain)   id           key,
								  object;
@property (readonly) NSUInteger   count;
@property (copy)     NSComparator comparator;
@property (retain)   TXBTree      * parent,
								  * left,
								  * right;

+ (instancetype)treeWithComparator:(NSComparator)comparator forObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt;
- (id)initWithComparator:(NSComparator)comparator forObjects:(const id [])objects forKeys:(const id [])keys count:(NSUInteger)cnt;

@end
