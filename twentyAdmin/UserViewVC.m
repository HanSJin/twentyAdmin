//
//  UserViewVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 28..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "UserViewVC.h"
#import "MemberOb.h"
#import "EditorPostListVC.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"


@interface UserViewVC () {
    UITableView *tableView;
    NSMutableArray *userList;
}

@end

@implementation UserViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    userList = [[NSMutableArray alloc] init];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s&memberOrEditor=%@",[[KeychainHelper loadWithKey:@"auth"] bytes], self.memberOrEditor];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_MEMBERS connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    
    for (NSMutableDictionary *dic in result) {
        MemberOb *member = [[MemberOb alloc] initWithName:@"Member"];
        member.mb_no = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_no"]];
        member.mb_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_id"]];
        member.mb_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_name"]];
        member.mb_nick = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_nick"]];
        member.mb_email = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_email"]];
        member.mb_homepage = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_homepage"]];
        member.mb_level = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_level"]];
        member.mb_sex = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_sex"]];
        member.mb_birth = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_birth"]];
        member.mb_point = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_point"]];
        member.mb_today_login = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_today_login"]];
        member.mb_login_ip = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_login_ip"]];
        member.mb_datetime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_datetime"]];
        member.mb_memo = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_memo"]];
        member.mb_mailling = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_mailling"]];
        member.mb_sms = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_sms"]];
        member.mb_open = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_open"]];
        member.mb_univ_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_univ_name"]];
        member.mb_major_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_major_name"]];
        member.mb_stu_no = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_stu_no"]];
        member.mb_grade = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_grade"]];
        member.mb_image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_image"]];
        member.mb_fb_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_fb_id"]];
        member.mb_cnt_visit = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_cnt_visit"]];
        member.mb_cnt_comment = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_cnt_comment"]];
        member.mb_cnt_scrap = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_cnt_scrap"]];
        member.mb_push_token = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_push_token"]];
        member.mb_push_flag = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_push_flag"]];
        member.mb_change_interest = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_change_interest"]];
        member.mb_is_android = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_is_android"]];
        member.mb_message = [NSString stringWithFormat:@"%@",[dic objectForKey:@"mb_message"]];
        
        [userList addObject:member];
    }
    
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCR_WIDTH, SCR_HEIGHT-64-IS_HOT_SPOT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    if ([self.memberOrEditor isEqualToString:@"member"])
        tableView.allowsSelection = NO;
    [self.view addSubview:tableView];
    
}



#pragma mark - tableview delegate

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

// 셀 갯수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 1;
    else
        return userList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    if ([self.memberOrEditor isEqualToString:@"editor"] && indexPath.section == 1)
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    cell.backgroundColor = WHITE_COLOR;
    
    
    
    if (indexPath.section == 0) {
        UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"유저 수 : %d", userList.count]
                                    LabelRect:CGRectMake(16, 15, SCR_WIDTH-32, 20)
                                    textAlign:@"left" textFont:FONT_SB textSize:0
                                    textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label];
    }
    
    
    
    else if (indexPath.section == 1) {
        MemberOb *member = ((MemberOb *)[userList objectAtIndex:indexPath.row]);
        
        UIImageView *thumb = [Customs CSImageViewImg:nil imgPlachHolder:nil
                                             imgRect:CGRectMake(16, 8, 60, 60) isCached:YES
                                              imgUrl:member.mb_image contentMode:@"AspectFill"
                                           backColor:CLEAR_COLOR radius:0 borderWidth:0.7
                                         borderColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [cell addSubview:thumb];
        
        
        UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"No.%@  %@ (%@)",member.mb_no, member.mb_name, member.mb_nick]
                                    LabelRect:CGRectMake(16+60+8, 7, SCR_WIDTH-16-60-8-16, 20)
                                    textAlign:@"left" textFont:FONT_SB textSize:0
                                    textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label];
        
        
        NSString *levStr = @"";
        if ([member.mb_level isEqualToString:@"1"])
            levStr = @"탈퇴 유저";
        else if ([member.mb_level isEqualToString:@"2"])
            levStr = @"일반 유저";
        else if ([member.mb_level isEqualToString:@"3"])
            levStr = @"에디터";
        if ([member.mb_level isEqualToString:@"3"]) {
            UILabel *levLabel = [Customs CSLabelText:[NSString stringWithFormat:@"에디터"]
                                           LabelRect:CGRectMake(16+60+8, 6, SCR_WIDTH-16-60-8-16, 20)
                                           textAlign:@"right" textFont:FONT_SB textSize:0
                                           textColor:[UIColor blueColor] backColor:CLEAR_COLOR];
            [cell addSubview:levLabel];
        } else if ([member.mb_level isEqualToString:@"1"]) {
            UILabel *levLabel = [Customs CSLabelText:[NSString stringWithFormat:@"탈퇴"]
                                           LabelRect:CGRectMake(16+60+8, 6, SCR_WIDTH-16-60-8-16, 20)
                                           textAlign:@"right" textFont:FONT_SB textSize:0
                                           textColor:[UIColor redColor] backColor:CLEAR_COLOR];
            [cell addSubview:levLabel];
        }
        
        
        UILabel *idLabel = [Customs CSLabelText:[NSString stringWithFormat:@"ID : %@",member.mb_id]
                                      LabelRect:CGRectMake(16+60+8, 31, SCR_WIDTH-16-60-8-16, 20)
                                      textAlign:@"left" textFont:FONT_R textSize:0
                                      textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:idLabel];
        
        
        UILabel *emailLabel = [Customs CSLabelText:[NSString stringWithFormat:@"%@ (%@)",member.mb_email, member.mb_homepage]
                                         LabelRect:CGRectMake(16+60+8, 51, SCR_WIDTH-16-60-8-16, 20)
                                         textAlign:@"left" textFont:FONT_R textSize:0
                                         textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:emailLabel];
        
        
        
        
        UILabel *label1 = [Customs CSLabelText:[NSString stringWithFormat:@"UV: %@   MJ: %@   GR: %@",member.mb_univ_name, member.mb_major_name, member.mb_grade]
                                     LabelRect:CGRectMake(16, 78, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label1];
        
        UILabel *label2 = [Customs CSLabelText:[NSString stringWithFormat:@"SN: %@     SX: %@     BIR: %@     PT: %@", member.mb_stu_no, member.mb_sex, member.mb_birth, member.mb_point]
                                     LabelRect:CGRectMake(16, 98, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label2];
        
        UILabel *label3 = [Customs CSLabelText:[NSString stringWithFormat:@"LOGIN TIME: %@",member.mb_today_login]
                                     LabelRect:CGRectMake(16, 118, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label3];
        
        UILabel *label4 = [Customs CSLabelText:[NSString stringWithFormat:@"REGIST TIME: %@", member.mb_datetime]
                                     LabelRect:CGRectMake(16, 138, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label4];
        
        UILabel *label5 = [Customs CSLabelText:[NSString stringWithFormat:@"IP: %@", member.mb_login_ip]
                                     LabelRect:CGRectMake(16, 158, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label5];
        
        UILabel *label6 = [Customs CSLabelText:[NSString stringWithFormat:@"MAIL: %@     SMS: %@     OPEN: %@", member.mb_mailling, member.mb_sms, member.mb_open]
                                     LabelRect:CGRectMake(16, 178, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label6];
        
        UILabel *label7 = [Customs CSLabelText:[NSString stringWithFormat:@"FB: %@", member.mb_fb_id]
                                     LabelRect:CGRectMake(16, 198, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label7];
        
        UILabel *label8 = [Customs CSLabelText:[NSString stringWithFormat:@"VISIT: %@     COMMENT: %@     SCRAP: %@", member.mb_cnt_visit, member.mb_cnt_comment, member.mb_cnt_scrap]
                                     LabelRect:CGRectMake(16, 218, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label8];
        
        if ([member.mb_push_token isEqualToString:@"<null>"])
            member.mb_push_token = @"OFF";
        UILabel *label9 = [Customs CSLabelText:[NSString stringWithFormat:@"PUSH: %@", member.mb_push_token]
                                     LabelRect:CGRectMake(16, 238, SCR_WIDTH-32, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label9];
        
        UILabel *label10 = [Customs CSLabelText:[NSString stringWithFormat:@"INTEREST: %@", member.mb_change_interest]
                                      LabelRect:CGRectMake(16, 258, SCR_WIDTH-32, 40)
                                      textAlign:@"left" textFont:FONT_L textSize:0
                                      textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        label10.numberOfLines = 3;
        [label10 sizeToFit];
        [cell addSubview:label10];
        
        NSString *device = @"";
        if ([member.mb_is_android isEqualToString:@"0"])
            device = @"iPhone";
        else if ([member.mb_is_android isEqualToString:@"1"])
            device = @"Android";
        else if ([member.mb_is_android isEqualToString:@"2"])
            device = @"Web";
        UILabel *label11 = [Customs CSLabelText:[NSString stringWithFormat:@"DEV: %@", device]
                                      LabelRect:CGRectMake(16, 260+label10.frame.size.height, SCR_WIDTH-32, 20)
                                      textAlign:@"left" textFont:FONT_L textSize:0
                                      textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label11];
        
        UILabel *label12 = [Customs CSLabelText:[NSString stringWithFormat:@"MEMO: %@", member.mb_memo]
                                      LabelRect:CGRectMake(16, 280+label10.frame.size.height, SCR_WIDTH-32, 20)
                                      textAlign:@"left" textFont:FONT_L textSize:0
                                      textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label12];
        
        UILabel *label13 = [Customs CSLabelText:[NSString stringWithFormat:@"MSG: %@", member.mb_message]
                                      LabelRect:CGRectMake(16, 300+label10.frame.size.height, SCR_WIDTH-32, 20)
                                      textAlign:@"left" textFont:FONT_L textSize:0
                                      textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label13];
    }
    
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 50;
    else
        return 370;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([self.memberOrEditor isEqualToString:@"editor"] && indexPath.section == 1) {
        EditorPostListVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"EditorPostListVC"];
        MemberOb *member = ((MemberOb *)[userList objectAtIndex:indexPath.row]);
        toVC.editor_mb_no = member.mb_no;
        toVC.editor_mb_name = member.mb_name;
        [self.navigationController pushViewController:toVC animated:YES];
    }
}


@end
