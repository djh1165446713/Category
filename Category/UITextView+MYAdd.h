//
//  UITextView+MYAdd.h
//  Foundation
//
//  Created by developer on 16/6/6.
//  Copyright © 2016年 kunxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITextView (MYAdd)
@property (nonatomic, assign) NSUInteger maxLength;
@property (nonatomic,   copy) NSString *placeholder;
@property (nonatomic, strong) UIFont *placeholderFont;
@property (nonatomic, strong) UIColor *placeholderColor;
@end
