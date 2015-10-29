//
//  VisualFormat.m
//  twenty
//
//  Created by 한승진 on 2015. 9. 26..
//  Copyright (c) 2015년 Appcoda. All rights reserved.
//

#import "VisualFormat.h"

@implementation VisualFormat


+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView left:(float)left right:(float)right top:(float)top bottom:(float)bottom; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[subView]-%f-|", left, right] options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[subView]-%f-|", top, bottom] options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    
}

+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleLeft:(float)left; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-%f-[subView]", left] options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}

+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleRight:(float)right; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:[subView]-%f-|", right] options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}


+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleTop:(float)top; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-%f-[subView]", top] options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}

+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView singleBottom:(float)bottom; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[subView]-%f-|", bottom] options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
}


+ (void)VF_FullSizeSuperView:(UIView *)superView subView:(UIView *)subView attachedBottom:(float)bottom; {
    UIView *superview = superView;
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    NSDictionary *views = NSDictionaryOfVariableBindings(subView, superview);
    
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:[subView]-%f-|", bottom] options:NSLayoutFormatAlignAllCenterX metrics:nil views:views]];
    [superview addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[subView]-0-|"] options:NSLayoutFormatAlignAllCenterY metrics:nil views:views]];
}


@end
