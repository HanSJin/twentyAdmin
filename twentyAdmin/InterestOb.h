//
//  InterestOb.h
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InterestOb : NSObject

@property (nonatomic, strong) NSString *bo_table;
@property (nonatomic, strong) NSString *bo_subject;
@property (nonatomic, strong) NSString *bo_id;

- (id)initWithName:(NSString *)aName;

@end
