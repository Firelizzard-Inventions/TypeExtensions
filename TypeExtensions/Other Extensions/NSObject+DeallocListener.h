//
//  NSObject+DeallocListener.h
//  TypeExtensions
//
//  Created by Ethan Reesor on 8/24/13.
//  Copyright (c) 2013 Lens Flare. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol DeallocListener <NSObject>

- (void)objectDidDeallocate:(id)obj;

@end

@protocol DeallocNotifier <NSObject>

- (void)addDeallocListener:(id<DeallocListener>)listener;
- (void)removeDeallocListener:(id<DeallocListener>)listener;

@end

@interface NSObject (DeallocListener)

- (void)addDeallocListener:(id<DeallocListener>)listener;
- (void)removeDeallocListener:(id<DeallocListener>)listener;

@end
