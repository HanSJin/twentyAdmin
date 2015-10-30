//
//  MemberOb.h
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 28..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MemberOb : NSObject

@property (nonatomic, strong) NSString *mb_no;
@property (nonatomic, strong) NSString *mb_id;
@property (nonatomic, strong) NSString *mb_name;
@property (nonatomic, strong) NSString *mb_nick;
@property (nonatomic, strong) NSString *mb_email;
@property (nonatomic, strong) NSString *mb_homepage;
@property (nonatomic, strong) NSString *mb_level;
@property (nonatomic, strong) NSString *mb_sex;
@property (nonatomic, strong) NSString *mb_birth;
@property (nonatomic, strong) NSString *mb_point;
@property (nonatomic, strong) NSString *mb_today_login;
@property (nonatomic, strong) NSString *mb_login_ip;
@property (nonatomic, strong) NSString *mb_datetime;
@property (nonatomic, strong) NSString *mb_memo;
@property (nonatomic, strong) NSString *mb_mailling;
@property (nonatomic, strong) NSString *mb_sms;
@property (nonatomic, strong) NSString *mb_open;
@property (nonatomic, strong) NSString *mb_univ_name;
@property (nonatomic, strong) NSString *mb_major_name;
@property (nonatomic, strong) NSString *mb_stu_no;
@property (nonatomic, strong) NSString *mb_grade;
@property (nonatomic, strong) NSString *mb_image;
@property (nonatomic, strong) NSString *mb_fb_id;
@property (nonatomic, strong) NSString *mb_cnt_visit;
@property (nonatomic, strong) NSString *mb_cnt_comment;
@property (nonatomic, strong) NSString *mb_cnt_scrap;
@property (nonatomic, strong) NSString *mb_push_token;
@property (nonatomic, strong) NSString *mb_push_flag;
@property (nonatomic, strong) NSString *mb_change_interest;
@property (nonatomic, strong) NSString *mb_is_android;
@property (nonatomic, strong) NSString *mb_message;

- (id)initWithName:(NSString *)aName;
@end
