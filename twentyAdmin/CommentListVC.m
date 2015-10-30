//
//  CommentListVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "CommentListVC.h"
#import "CommentOb.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"

@interface CommentListVC () {
    UITableView *tableView;
    NSMutableArray *commentList;
    UILabel *label1;
}

@end

@implementation CommentListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    commentList = [[NSMutableArray alloc] init];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s&bo_table=%@",[[KeychainHelper loadWithKey:@"auth"] bytes], self.interest.bo_table];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_COMMENT connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in result) {
        @try {
            CommentOb *comment = [[CommentOb alloc] initWithName:@"EditorPost"];
            comment.wr_subject = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_subject"]];
            comment.wr_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_id"]];
            comment.wr_thumb = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_thumb"]];
            comment.wr_name = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_name"]];
            comment.wr_content = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_content"]];
            comment.wr_datetime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_datetime"]];

            
            [commentList addObject:comment];
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
    return 1;
}

// 셀 갯수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return commentList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    CommentOb *comment = ((CommentOb *)[commentList objectAtIndex:indexPath.row]);
//    
//    if ([post.is_publish isEqualToString:@"1"])
//        cell.backgroundColor = [UIColor colorWithRed:0.95 green:1 blue:1 alpha:1];
//    else
//        cell.backgroundColor = WHITE_COLOR;
//    
    UIImageView *thumb = [Customs CSImageViewImg:nil imgPlachHolder:nil
                                         imgRect:CGRectMake(16, 8, 50, 50) isCached:YES
                                          imgUrl:comment.wr_thumb contentMode:@"AspectFill"
                                       backColor:CLEAR_COLOR radius:0 borderWidth:0.7
                                     borderColor:[UIColor colorWithWhite:0.7 alpha:1]];
    [cell addSubview:thumb];

    
    UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"wr_id: %@ [%@]", comment.wr_id, comment.wr_name]
                                LabelRect:CGRectMake(16+50+12, 7, SCR_WIDTH-16-50-12-16, 20)
                                textAlign:@"left" textFont:FONT_SB textSize:0
                                textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label];
    
    UILabel *label3 = [Customs CSLabelText:[NSString stringWithFormat:@"%@ > %@", self.interest.bo_subject, comment.wr_subject]
                                 LabelRect:CGRectMake(16+50+12, 27, SCR_WIDTH-16-50-12-16, 20)
                                 textAlign:@"left" textFont:FONT_L textSize:0
                                 textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label3];
    
    UILabel *label2 = [Customs CSLabelText:[NSString stringWithFormat:@"%@", comment.wr_datetime]
                                 LabelRect:CGRectMake(16+50+12, 44, SCR_WIDTH-16-50-12-16, 20)
                                 textAlign:@"left" textFont:FONT_L textSize:-2
                                 textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label2];
    
    label1 = [Customs CSLabelText:[NSString stringWithFormat:@"%@", comment.wr_content]
                                LabelRect:CGRectMake(16, 66, SCR_WIDTH-16-16, 20)
                                textAlign:@"left" textFont:FONT_R textSize:0
                                textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    label1.numberOfLines = 5;
    [label1 sizeToFit];
    [cell addSubview:label1];

    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 75 + label1.bounds.size.height;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

@end
