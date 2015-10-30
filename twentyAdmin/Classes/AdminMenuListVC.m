//
//  AdminMenuListVC.m
//  twentyAdmin
//
//  Created by 한승진 on 2015. 10. 28..
//  Copyright © 2015년 twentyapps. All rights reserved.
//

#import "AdminMenuListVC.h"
#import "UserViewVC.h"
#import "PostListVC.h"
#import "InterestListVC.h"

#import "Customs.h"
#import "VisualFormat.h"
#import "Constants.h"
#import "ConnectionFactory.h"
#import "KeychainHelper.h"



@interface AdminMenuListVC () {
    UITableView *tableView;
    
    NSMutableArray *menuList;
}

@end

@implementation AdminMenuListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"Twenty Admin";
    
    NSData *dataID = [@"hansj" dataUsingEncoding:NSUTF8StringEncoding];
    [KeychainHelper saveWithKey:@"auth" andData:dataID];
    
    NSString *adminAuth = [NSString stringWithFormat:@"auth=%s",[[KeychainHelper loadWithKey:@"auth"] bytes]];
    NSData *myData = [ConnectionFactory connType:@"GET" connAPI:CONNECT_ADMIN_CERT connParam:adminAuth];
    NSMutableDictionary *result = [NSJSONSerialization JSONObjectWithData:myData options:NSJSONReadingMutableContainers error:nil];

    if (![[result objectForKey:@"results"] isEqualToString:@"success"]) {
        AUTH_ALERT(@"twenty", @"외부접근 차단");
        return;
    }
    
    menuList = [[NSMutableArray alloc] initWithArray:@[@"회원 정보 열람",
                                                       @"에디터 정보 열람",
                                                       @"게시글 리스트",
                                                       @"댓글 리스트"]];
    
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
    return menuList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    
    for (UIView *subView in cell.subviews)
        [subView removeFromSuperview];
    
    cell.backgroundColor = WHITE_COLOR;
    
    UILabel *label = [Customs CSLabelText:[menuList objectAtIndex:indexPath.row] LabelRect:CGRectMake(16, 0, SCR_WIDTH-32, 50) textAlign:@"left" textFont:FONT_R textSize:2 textColor:BLACK_COLOR backColor:CLEAR_COLOR];
    [cell addSubview:label];
    
    return cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        UserViewVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserViewVC"];
        toVC.memberOrEditor = @"member";
        [self.navigationController pushViewController:toVC animated:YES];
    }
    else if (indexPath.row == 1) {
        UserViewVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"UserViewVC"];
        toVC.memberOrEditor = @"editor";
        [self.navigationController pushViewController:toVC animated:YES];
    }
    else if (indexPath.row == 2) {
        PostListVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"PostListVC"];
        [self.navigationController pushViewController:toVC animated:YES];
    }
    else if (indexPath.row == 3) {
        InterestListVC *toVC = [self.storyboard instantiateViewControllerWithIdentifier:@"InterestListVC"];
        [self.navigationController pushViewController:toVC animated:YES];
    }
}



@end
