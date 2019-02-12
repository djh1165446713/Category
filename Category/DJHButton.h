//
//  DJHButton.h
//  SightReading
//
//  Created by bianKerMacBook on 2018/2/28.
//  Copyright © 2018年 QvBian. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
    imageTop = 0,   // 图片上 标题下
    imageLeft,      // 图片左 标题右
    imageBottom,    // 图片下 标题上
    imageRight,     // 图片右 标题左
} ImageStyle;

@interface DJHButton : UIButton
@property (nonatomic, assign) ImageStyle buttonStyle;

@property (nonatomic, assign) BOOL ascending;

- (void)layoutButtonWithEdgeInsetsStyle:(ImageStyle)style  imageTitleSpace:(CGFloat)space;
@end
