//
//  TXZeroingWeakProxy.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 1/4/14.
//  Copyright (c) 2014 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TXZeroingWeakProxy : NSProxy

+ (instancetype)proxyWithReference:(NSObject *)object;
- (id)initWithReference:(NSObject *)object;

@property (weak, readonly) NSObject * ref;
@property (readonly) Class refClass;

@end
