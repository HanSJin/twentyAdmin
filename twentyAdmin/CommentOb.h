//
//  CommentOb.h
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommentOb : NSObject

@property (nonatomic, strong) NSString *wr_subject;
@property (nonatomic, strong) NSString *wr_id;
@property (nonatomic, strong) NSString *wr_name;
@property (nonatomic, strong) NSString *wr_thumb;
@property (nonatomic, strong) NSString *wr_content;
@property (nonatomic, strong) NSString *wr_datetime;

- (id)initWithName:(NSString *)aName;

@end