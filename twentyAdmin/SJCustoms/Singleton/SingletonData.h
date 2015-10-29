//
//  SingletonData.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 15..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "MainViewController.h"



@interface SingletonData : NSObject {
    NSInteger memberNum;
    NSInteger lastSelectedViewStackIndex;
    MainViewController *mainViewController;
    
    // Deep Link
    BOOL isShowDeepLink;
    NSString *deepLink_BoTable;
    NSString *deepLink_WrId;
}




/*************************************************************************************
 맴버 넘버
 *************************************************************************************/
@property (nonatomic) NSInteger memberNum;


/*************************************************************************************
 드로어랑 스택뷰의 이동간에 최근에 본 스택뷰 인덱스를 저장하여 인덱스를 다시 활용함.
 *************************************************************************************/
@property (nonatomic) NSInteger lastSelectedViewStackIndex;


/*************************************************************************************
 드로어랑 스택뷰의 이동간에 최근에 본 스택뷰 인덱스를 저장하여 인덱스를 다시 활용함.
 *************************************************************************************/
@property (nonatomic) MainViewController *mainViewController;







/*************************************************************************************
 딮 링크 여부
 *************************************************************************************/
@property (nonatomic) BOOL isShowDeepLink;
@property (nonatomic) NSString *deepLink_BoTable;
@property (nonatomic) NSString *deepLink_WrId;



+ (id)sharedManager;
@end



