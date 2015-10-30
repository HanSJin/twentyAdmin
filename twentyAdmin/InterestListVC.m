//
//  InterestListVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 30..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "InterestListVC.h"
#import "InterestOb.h"
#import "CommentListVC.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"

@interface InterestListVC () {
    UITableView *tableView;
    NSMutableArray *interestList;
}

@end

@implementation InterestListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    interestList = [[NSMutableArray alloc] init];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s",[[KeychainHelper loadWithKey:@"auth"] bytes]];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_INTEREST connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];
    
    for (NSMutableDictionary *dic in result) {
        @try {
            InterestOb *interest = [[InterestOb alloc] initWithName:@"Interest"];
            interest.bo_id = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bo_id"]];
            interest.bo_table = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bo_table"]];
            interest.bo_subject = [NSString stringWithFormat:@"%@",[dic objectForKey:@"bo_subject"]];
            
            [interestList addObject:interest];
        }
        @catch (NSException *exception) {
            return ;
        }
    }
    
    tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, SCR_WIDTH, SCR_HEIGHT-64-IS_HOT_SPOT) style:UITableViewStylePlain];
    tableView.delegate = self;
    tableView.dataSource = self;
    [self.view addSubview:tableView];
}


#pragma mark - tableview delegate

// Return the number of sections
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

// 셀 갯수
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return interestList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    InterestOb *interest = ((InterestOb *)[interestList objectAtIndex:indexPath.row]);
    
    UILabel *label = [Customs CSLabelText:[NSString stringWithFormat:@"No.%@     %@", interest.bo_id, interest.bo_subject]
                                LabelRect:CGRectMake(16, 14, SCR_WIDTH-32, 20)
                                textAlign:@"left" textFont:FONT_R textSize:0
                                textColor:SEMI_BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    CommentListVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"CommentListVC"];
    toVC.interest = ((InterestOb *)[interestList objectAtIndex:indexPath.row]);
    [self.navigationController pushViewController:toVC animated:YES];
}

@end
