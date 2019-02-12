//
//  UIImage+Category.h
//  paopao
//
//  Created by yite on 14-4-28.
//  Copyright (c) 2014年 yite. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,ImageFilterType)
{
    ImageFilterTypeSaturation,    //饱和度
    ImageFilterTypeContrast,      //对比度
    ImageFilterTypeBrightness     //亮度
};

@interface UIImage (Category)

+ (UIImage *)imageWithBgColor:(UIColor *)color;

- (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets;
- (UIImage *)fixOrientation;
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
//等比例缩放
- (UIImage *)scaleToSize:(CGSize)size;
+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize;
+ (UIImage *)scaleImage:(UIImage *)image scaleFactor:(float)scaleFloat;
+ (UIImage *)modifyImage:(UIImage *)image;
+ (UIImage *)chatModifyImage:(UIImage *)image;
+ (UIImage *)imageWithColor:(UIColor *)color;
- (BOOL)judgeImageWidth:(float)imageWidth;
- (BOOL)judgeImageHeight:(float)imageHeigth;

- (UIImage *)blurImageWithInputRadius:(CGFloat)radius;
/**
 *  图片旋转
 */
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;

- (UIImage *)rescaleImageToSize:(CGSize)size;
/**
 *  调整图片属性
 *  (亮度,对比度,饱和度)
 *  (-1---1,0---4,0---2)
 */
+ (UIImage *)getFilterImage:(UIImage *)originalImage value:(CGFloat)value type:(ImageFilterType) filterType;

/**
 *  高斯模糊
 *
 */
+ (UIImage *)getBlurImage:(UIImage *)originalImage radiusValue:(CGFloat)value;
/**
 *
 *  获取网络图片
 */
+ (UIImage *)getImageFromURL:(NSURL *)imageURL;

- (UIImage *)imageWithMaxSide:(CGFloat)length;

+ (UIImage *)createImageWithColor:(UIColor *)color;

//获取启动图
+ (UIImage *)getLaunchImage;


@end
