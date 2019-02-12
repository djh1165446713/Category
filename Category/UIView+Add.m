//
//  UIView+Add.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import "UIView+Add.h"

@implementation UIView (Add)


//快速创建一个按钮 带图片
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font imageNamed:(NSString *)imageNamed{
    
    UIButton *button = [[UIButton alloc] init];
    
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    
    //    button.backgroundColor = [UIColor whiteColor];
    
    [button setTitle:title forState:UIControlStateNormal];
    
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    
    if (imageNamed) {
        
        [button setImage:[UIImage imageNamed:imageNamed] forState:UIControlStateNormal];
    }
    
    [button sizeToFit];
    
    return button;
    
}

@end
