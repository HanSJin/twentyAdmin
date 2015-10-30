//
//  SingletonData.h
//  SidebarDemo
//
//  Created by Han on 2015. 7. 15..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//


#import <Foundation/Foundation.h>



@interface SingletonData : NSObject {
//    NSInteger memberNum;
}




/*************************************************************************************
 맴버 넘버
 *************************************************************************************/
//@property (nonatomic) NSInteger memberNum;



+ (id)sharedManager;
@end



