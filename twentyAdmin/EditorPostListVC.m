//
//  EditorPostListVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "EditorPostListVC.h"
#import "EditorPostOb.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"

@interface EditorPostListVC () {
    UITableView *tableView;
    NSMutableArray *postList;
}

@end

@implementation EditorPostListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = self.editor_mb_name;
    
    postList = [[NSMutableArray alloc] init];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s&mb_no=%@",[[KeychainHelper loadWithKey:@"auth"] bytes], self.editor_mb_no];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_EDITOR_POST connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    for (NSMutableDictionary *dic in result) {
        @try {
            EditorPostOb *post = [[EditorPostOb alloc] initWithName:@"EditorPost"];
            post.wr_type = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_type"]];
            post.bo_table = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bo_table"]];
            post.wr_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_id"]];
            post.wr_subject = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_subject"]];
            post.wr_datetime = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_datetime"]];
            post.wr_thumb_url = [NSString stringWithFormat:@"%@",[dic objectForKey:@"wr_thumb_url"]];
            post.is_publish = [NSString stringWithFormat:@"%@",[dic objectForKey:@"is_publish"]];
            
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
    return 1;
}

// 셀 갯수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return postList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    EditorPostOb *post = ((EditorPostOb *)[postList objectAtIndex:indexPath.row]);
    
    if ([post.is_publish isEqualToString:@"1"])
        cell.backgroundColor = [UIColor colorWithRed:0.95 green:1 blue:1 alpha:1];
    else
        cell.backgroundColor = WHITE_COLOR;
    
    UIImageView *thumb = [Customs CSImageViewImg:nil imgPlachHolder:nil
                                         imgRect:CGRectMake(16, 8, 108, 192) isCached:YES
                                          imgUrl:post.wr_thumb_url contentMode:@"AspectFill"
                                       backColor:CLEAR_COLOR radius:0 borderWidth:0.7
                                     borderColor:[UIColor colorWithWhite:0.7 alpha:1]];
    [cell addSubview:thumb];
    
    
    UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"%@", post.wr_subject]
                                LabelRect:CGRectMake(16+108+8, 7, SCR_WIDTH-16-108-8-16, 20)
                                textAlign:@"left" textFont:FONT_SB textSize:0
                                textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    label.numberOfLines = 3;
    [label sizeToFit];
    [cell addSubview:label];
    
    UILabel *label2 = [Customs CSLabelText:[NSString stringWithFormat:@"type: %@", post.wr_type]
                                LabelRect:CGRectMake(16+108+8, 14+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                textAlign:@"left" textFont:FONT_L textSize:0
                                textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label2];
    
    UILabel *label3 = [Customs CSLabelText:[NSString stringWithFormat:@"table: %@", post.bo_table]
                                 LabelRect:CGRectMake(16+108+8, 34+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                 textAlign:@"left" textFont:FONT_L textSize:0
                                 textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label3];
    
    UILabel *label4 = [Customs CSLabelText:[NSString stringWithFormat:@"wr_id: %@", post.wr_id]
                                 LabelRect:CGRectMake(16+108+8, 54+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                 textAlign:@"left" textFont:FONT_L textSize:0
                                 textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label4];
    
    UILabel *label5 = [Customs CSLabelText:[NSString stringWithFormat:@"wr_datetime: %@", post.wr_datetime]
                                 LabelRect:CGRectMake(16+108+8, 74+label.bounds.size.height, SCR_WIDTH-16-60-8-16, 20)
                                 textAlign:@"left" textFont:FONT_L textSize:0
                                 textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label5];
    
    
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 208;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


@end
