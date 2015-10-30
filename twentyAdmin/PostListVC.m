//
//  PostListVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "PostListVC.h"
#import "PostOb.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"

@interface PostListVC () {
    UITableView *tableView;
    NSMutableArray *postList;
    UILabel *label;
}

@end

@implementation PostListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    postList = [[NSMutableArray alloc] init];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s",[[KeychainHelper loadWithKey:@"auth"] bytes]];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_POSTS connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in result) {
        @try {
            PostOb *post = [[PostOb alloc] initWithName:@"Post"];
            post.news_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_id"]];
            post.wr_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_id"]];
            post.news_upload_datetime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_upload_datetime"]];
            post.news_publish_datetime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_publish_datetime"]];
            post.news_interest_1 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_interest_1"]];
            post.news_interest_2 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_interest_2"]];
            post.news_interest_3 = [NSString stringWithFormat:@"%@",[dic objectForKey:@"news_interest_3"]];
            post.wr_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_name"]];
            post.wr_comment = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_comment"]];
            post.wr_subject = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_subject"]];
            post.wr_content = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_content"]];
            post.wr_hit = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_hit"]];
            post.wr_good = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_good"]];
            post.wr_scrap = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_scrap"]];
            
            post.wr_news_type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_news_type"]];
            post.wr_news_image = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_news_image"]];
            post.wr_news_description = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_news_description"]];
            
            post.is_publish = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_publish"]];
            post.wr_black_cover = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_black_cover"]];
            post.is_top_white = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_top_white"]];
            post.is_bottom_white = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_bottom_white"]];
            
            [postList addObject:post];
        }
        @catch (NSException *exception) {
            return ;
        }
    }
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCR_WIDTH, SCR_HEIGHT-64-IS_HOT_SPOT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
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
        return postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    
    
    if (indexPath.section == 0) {
        UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"뉴스 수 : %d", postList.count]
                                    LabelRect:CGRectMake(16, 15, SCR_WIDTH-32, 20)
                                    textAlign:@"left" textFont:FONT_SB textSize:0
                                    textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label];
    } else if (indexPath.section == 1) {
        
        PostOb *post = ((PostOb *)[postList objectAtIndex:indexPath.row]);
        
        if ([post.is_publish isEqualToString:@"1"])
            cell.backgroundColor = [UIColor colorWithRed:0.95 green:1 blue:1 alpha:1];
        else
            cell.backgroundColor = WHITE_COLOR;
        
        UIImageView *thumb = [Customs CSImageViewImg:nil imgPlachHolder:nil
                                             imgRect:CGRectMake(16, 8, 108, 192) isCached:YES
                                              imgUrl:post.wr_news_image contentMode:@"AspectFill"
                                           backColor:CLEAR_COLOR radius:0 borderWidth:0.7
                                         borderColor:[UIColor colorWithWhite:0.7 alpha:1]];
        [cell addSubview:thumb];
        
        label = [Customs CSLabelText:[NSString stringWithFormat:@"%@ + %@", post.wr_subject, post.wr_news_description]
                           LabelRect:CGRectMake(16+108+16, 7, SCR_WIDTH-16-108-8-16, 20)
                           textAlign:@"left" textFont:FONT_SB textSize:0
                           textColor:BLACK_COLOR backColor:CLEAR_COLOR];
        label.numberOfLines = 7;
        [label sizeToFit];
        [cell addSubview:label];
        
        UILabel *label1 = [Customs CSLabelText:[NSString stringWithFormat:@"작성자: %@", post.wr_name]
                                     LabelRect:CGRectMake(16+108+16, 14+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label1];
        
        UILabel *label2 = [Customs CSLabelText:[NSString stringWithFormat:@"NEW_ID: %@", post.news_id]
                                     LabelRect:CGRectMake(16+108+16, 34+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label2];
        
        UILabel *label3 = [Customs CSLabelText:[NSString stringWithFormat:@"업로드: %@", post.news_upload_datetime]
                                     LabelRect:CGRectMake(16+108+16, 54+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label3];
        
        NSString *publishStr = @"";
        UIColor *publishColor;
        if ([post.is_publish isEqualToString:@"1"]) {
            publishStr = @"ON";
        } else {
            publishStr = @"OFF";
        }
        UILabel *label4 = [Customs CSLabelText:[NSString stringWithFormat:@"발행: %@", publishStr]
                                     LabelRect:CGRectMake(16+108+16, 74+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label4];
        
        UILabel *label5 = [Customs CSLabelText:[NSString stringWithFormat:@"관심사: %@ / %@ / %@", post.news_interest_1, post.news_interest_2, post.news_interest_3]
                                     LabelRect:CGRectMake(16+108+16, 94+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label5];
        
        UILabel *label6 = [Customs CSLabelText:[NSString stringWithFormat:@"조회수: %@  댓글수: %@", post.wr_hit, post.wr_comment]
                                     LabelRect:CGRectMake(16+108+16, 114+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label6];
        
        UILabel *label7 = [Customs CSLabelText:[NSString stringWithFormat:@"좋아요: %@  스크랩: %@", post.wr_good, post.wr_scrap]
                                     LabelRect:CGRectMake(16+108+16, 134+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label7];
        
        UILabel *label8 = [Customs CSLabelText:[NSString stringWithFormat:@"COVER: %@  TOP: %@  BOTTOM: %@", post.wr_black_cover, post.is_top_white, post.is_bottom_white]
                                     LabelRect:CGRectMake(16+108+16, 154+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                     textAlign:@"left" textFont:FONT_L textSize:0
                                     textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
        [cell addSubview:label8];

    }
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return 50;
    else
        return MAX(208, 185 + label.bounds.size.height);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}





@end
