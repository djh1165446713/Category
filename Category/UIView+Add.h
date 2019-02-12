//
//  UIView+Add.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (Add)
+ (UILabel *)setLabTextColor:(NSString *)color setFont:(NSInteger)font;

//快速创建一个按钮 带图片
+ (UIButton *)buttonWithTitle:(NSString *)title titleColor:(UIColor *)titleColor titleFont:(NSInteger)font imageNamed:(NSString *)imageNamed;

@end

NS_ASSUME_NONNULL_END
