//
//  UIImage+MYAdd.h
//  CaiGuanJia
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 kunxun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (MYAdd)
// 分辨率压缩
- (UIImage *)imageWithMaxSide:(CGFloat)length;
- (NSData *)imageJPEGCompressionQuality;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
@end
