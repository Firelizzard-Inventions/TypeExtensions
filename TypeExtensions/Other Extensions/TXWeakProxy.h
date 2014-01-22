//
//  TXZeroingWeakProxy.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 1/21/14.
//  Copyright (c) 2014 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXWeakProxy : NSProxy

+ (instancetype)proxyWithTarget:(NSObject *)target;
- (id)initWithTarget:(NSObject *)target;

@property (readonly, weak) NSObject * target;
@property (unsafe_unretained, readonly) Class targetClass;

@end
