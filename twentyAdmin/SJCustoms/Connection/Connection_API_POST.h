//
//  NewsConnection.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 19..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Connection_API_POST : NSObject

+ (NSData *)myConnection_api_post:(NSString *)connAPI connParam:(NSString *)connParam;

@end
