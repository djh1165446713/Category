//
//  UIView+Frame.m
//  Lesson-06 UISlider
//
//  Created by admin on 15/8/3.
//  Copyright (c) 2015年 admin. All rights reserved.
//

#import "UIView+Frame.h"

@implementation UIView (Frame)

- (void)setTop:(CGFloat)top
{
    
    if (self == [super init]) {
        CGRect newFrame = self.frame;
        newFrame.origin.y = top;
        self.frame = newFrame;
    }
}
- (CGFloat)top
{
    return self.frame.origin.y;
}


- (void)setBottom:(CGFloat)bottom
{
    if (self == [super init])
    {
        CGRect newFrame = self.frame;
        newFrame.origin.y = bottom - self.frame.size.height;
        self.frame = newFrame;
    }
}
- (CGFloat)bottom
{
    return self.frame.origin.y + self.frame.size.height;
}


- (void)setLeft:(CGFloat)left
{
    if (self == [super init])
    {
        CGRect newFrame = self.frame;
        newFrame.origin.x = left;
        self.frame = newFrame;
    }
}
- (CGFloat)left
{
    return self.frame.origin.x;
}


- (void)setRight:(CGFloat)right
{
    if (self == [super init])
    {
        CGRect newFrame = self.frame;
        newFrame.origin.x = right - self.frame.size.width;
        self.frame = newFrame;
    }
}
- (CGFloat)right
{
    return self.frame.origin.x + self.frame.size.width;
}


- (void)setWidth:(CGFloat)width
{
    if (self == [super init])
    {
        CGRect newFrame = self.frame;
        newFrame.size.width = width;
        self.frame = newFrame;
    }
}
- (CGFloat)width
{
    return self.frame.size.width;
}


- (void)setHeight:(CGFloat)height
{
    if (self == [super init])
    {
        CGRect newFrame = self.frame;
        newFrame.size.height = height;
        self.frame = newFrame;
    }
}
- (CGFloat)height
{
    return self.frame.size.height;
}

- (void)setX:(CGFloat)x
{
    CGRect frame = self.frame;
    frame.origin.x = x;
    self.frame = frame;
}

- (CGFloat)x
{
    return self.frame.origin.x;
}

- (void)setY:(CGFloat)y
{
    CGRect frame = self.frame;
    frame.origin.y = y;
    self.frame = frame;
}

- (CGFloat)y
{
    return self.frame.origin.y;
}

- (void)setCenterX:(CGFloat)centerX
{
    CGPoint center = self.center;
    center.x = centerX;
    self.center = center;
}

- (CGFloat)centerX
{
    return self.center.x;
}
- (void)setCenterY:(CGFloat)centerY
{
    CGPoint center = self.center;
    center.y = centerY;
    self.center = center;
}

- (CGFloat)centerY
{
    return self.center.y;
}

- (void)setSize:(CGSize)size
{
    //    self.width = size.width;
    //    self.height = size.height;
    CGRect frame = self.frame;
    frame.size = size;
    self.frame = frame;
}

- (CGSize)size
{
    return self.frame.size;
}

+ (UILabel *)labelWithText:(NSString *)text textColor:(UIColor *)color font:(NSInteger)font textAliment:(NSTextAlignment)textAliment{
    
    UILabel *label = [[UILabel alloc] init];
    
    label.text = text;
    
    label.textColor = color;
    
    label.font = [UIFont systemFontOfSize:font];
    
    if (textAliment) {
        
        label.textAlignment = textAliment;
    }
    
    return label;
}

//输入框
+ (UITextField *)textFieldWithFont:(CGFloat)font color:(UIColor *)color placeholder:(NSString *)placeholder{
    
    UITextField *nameTextField = [[UITextField alloc] init];
    nameTextField.placeholder = placeholder;
    nameTextField.font = [UIFont systemFontOfSize:font];
    nameTextField.textColor = color;
    
    return nameTextField;
}

//快速创建一个按钮
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font{
    
    UIButton *button = [[UIButton alloc] init];
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    
    
    //    button.backgroundColor = titleColor;
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    return button;
    
}

//快速创建一个按钮带背景图
+ (UIButton *)buttonWithImage:(NSString *)imageName backImageNamed:(NSString *)backName{
    
    UIButton *button = [[UIButton alloc] init];
    
    if (imageName) {
        
        [button setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
    
    if (backName) {
        
        [button setBackgroundImage:[UIImage imageNamed:backName] forState:UIControlStateNormal];
    }
    
    //    button.backgroundColor = [UIColor whiteColor];
    
    [button sizeToFit];
    
    return button;
    
}

//创建一个圆角按钮
+ (UIButton *)roundButtonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(CGFloat)font backgroundColor:(UIColor *)backgroundColor frame:(CGRect)frame{
    
    UIButton *button = [UIButton buttonWithTitle:title titleColor:titleColor titleFont:font];
    
    button.backgroundColor = backgroundColor;
    
    button.frame = frame;
    
    button.layer.cornerRadius = button.height/2;
    button.clipsToBounds = YES;
    
    return button;
}
@end
