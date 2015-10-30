//
//  VisualFormat.h
//  twenty
//
//  Created by 한승진 on 2015. 9. 26..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface VisualFormat : NSObject

// 화면 풀사이즈
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView left:(float)left right:(float)right top:(float)top bottom:(float)bottom;


// 단방향 
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleLeft:(float)left;
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleRight:(float)right;
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleTop:(float)top;
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleBottom:(float)bottom;
+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView attachedBottom:(float)bottom;
@end
