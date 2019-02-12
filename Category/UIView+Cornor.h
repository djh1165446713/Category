//
//  Cornor.h
//  SdkDemo
//
//  Created by 熊玮 on 14/7/24.
//  Copyright (c) 2014年 bbdtek. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Cornor)
//是否隐藏状态栏
- (void)hideStatusBarBackground:(BOOL)ishidden;
/**
 设置UIView的边框、颜色、圆角等
 */
- (void)setRadius:(CGFloat)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor;

- (void)roundedView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize
                                                                                       )cornerRadii;

+ (void)tipWithTitle:(NSString *)title;

/**
 view:需要设置圆角的 view
 corners：需要设置圆角的位置
 cornerRadii：设置圆角的弧度
 fillColor：填充色，view 的颜色只能设置成透明的颜色，用fillColor来展示 view 的颜色
 strokeColor：边框的颜色，如果有边框 可以为 nil
 lineWidth：边框的宽度 如果没有边框可以设置0
 */

+(void)setCornerRadWith:(UIView *)view ByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth;


- (UIViewController *)viewController;
- (UIViewController *)_getRootViewController;
@end
