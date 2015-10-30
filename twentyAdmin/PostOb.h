//
//  PostOb.h
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostOb : NSObject

@property (nonatomic, strong) NSString *news_id;
@property (nonatomic, strong) NSString *bo_table;
@property (nonatomic, strong) NSString *wr_id;
@property (nonatomic, strong) NSString *news_upload_datetime;
@property (nonatomic, strong) NSString *news_publish_datetime;
@property (nonatomic, strong) NSString *news_interest_1;
@property (nonatomic, strong) NSString *news_interest_2;
@property (nonatomic, strong) NSString *news_interest_3;

@property (nonatomic, strong) NSString *wr_name;
@property (nonatomic, strong) NSString *wr_comment;
@property (nonatomic, strong) NSString *wr_subject;
@property (nonatomic, strong) NSString *wr_content;
@property (nonatomic, strong) NSString *wr_hit;
@property (nonatomic, strong) NSString *wr_good;
@property (nonatomic, strong) NSString *wr_scrap;

@property (nonatomic, strong) NSString *wr_news_type;
@property (nonatomic, strong) NSString *wr_news_image;
@property (nonatomic, strong) NSString *wr_news_description;

@property (nonatomic, strong) NSString *is_publish;
@property (nonatomic, strong) NSString *wr_black_cover;
@property (nonatomic, strong) NSString *is_top_white;
@property (nonatomic, strong) NSString *is_bottom_white;

- (id)initWithName:(NSString *)aName;

@end
