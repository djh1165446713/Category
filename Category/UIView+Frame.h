//
//  UIView+Frame.h
//  Lesson-06 UISlider
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property (nonatomic, assign) CGFloat top;
@property (nonatomic, assign) CGFloat bottom;
@property (nonatomic, assign) CGFloat left;
@property (nonatomic, assign) CGFloat right;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;


+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(NSInteger)font textAliment:(NSTextAlignment)textAliment;

+ (UITextField *)textFieldWithFont:(CGFloat)font color:(UIColor *)color placeholder:(NSString *)placeholder;

+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font;

+ (UIButton *)buttonWithImage:(NSString *)imageName backImageNamed:(NSString *)backName;

+ (UIButton *)roundButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame;

@end
