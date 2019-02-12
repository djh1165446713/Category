//
//  UIImage+MYAdd.m
//  CaiGuanJia
//
//  Created by admin on 16/5/17.
//  Copyright © 2016年 kunxun. All rights reserved.
//

#import "UIImage+MYAdd.h"

@implementation UIImage (MYAdd)
static inline CGSize CWSizeReduce(CGSize size, CGFloat limit) {
    CGFloat max = MAX(size.width, size.height);
    if (max < limit) {
        return size;
    }
    CGSize imgSize;
    CGFloat ratio = size.height / size.width;
    if (size.width > size.height) {
        imgSize = CGSizeMake(limit, round(limit*ratio));
    } else {
        imgSize = CGSizeMake(round(limit/ratio), limit);
    }
    return imgSize;
}

- (UIImage *)imageWithMaxSide:(CGFloat)length {
    if (self.size.height > length || self.size.width > length) {
        CGFloat scale = 1.0f;
        CGSize imgSize = CWSizeReduce(self.size, length);
        UIImage *img = nil;
        UIGraphicsBeginImageContextWithOptions(imgSize, YES, scale);  // 创建一个 bitmap context
        [self drawInRect:CGRectMake(0, 0, imgSize.width, imgSize.height)
               blendMode:kCGBlendModeNormal alpha:1.0];              // 将图片绘制到当前的 context 上
        img = UIGraphicsGetImageFromCurrentImageContext();            // 从当前 context 中获取刚绘制的图片
        UIGraphicsEndImageContext();
        return img;
    }
    return self;
}

- (NSData *)imageJPEGCompressionQuality {
    CGSize imageSize = self.size;
    NSData *imageData;
    if (imageSize.width > 1280 || imageSize.height > 1280) {
        imageData = UIImageJPEGRepresentation(self, 0.05f);
    } else if (imageSize.width > 1080 || imageSize.height > 1080) {
        imageData = UIImageJPEGRepresentation(self, 0.2f);
    } else if (imageSize.width > 640 || imageSize.height > 640) {
        imageData = UIImageJPEGRepresentation(self, 0.3f);
    } else if (imageSize.width > 540 || imageSize.height > 540) {
        imageData = UIImageJPEGRepresentation(self, 0.5f);
    } else if (imageSize.width > 320 || imageSize.height > 320) {
        imageData = UIImageJPEGRepresentation(self, 0.6f);
    } else {
        imageData = UIImageJPEGRepresentation(self, 0.7f);
    }
    return imageData;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation{
    
    long double rotate = 0.0;
    CGRect rect;
    float translateX = 0;
    float translateY = 0;
    float scaleX = 1.0;
    float scaleY = 1.0;
    switch (orientation) {
            
        case UIImageOrientationLeft:
            
            rotate = M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = 0;
            
            translateY = -rect.size.width;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationRight:
            
            rotate = 3 * M_PI_2;
            
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            
            translateX = -rect.size.height;
            
            translateY = 0;
            
            scaleY = rect.size.width/rect.size.height;
            
            scaleX = rect.size.height/rect.size.width;
            
            break;
            
        case UIImageOrientationDown:
            
            rotate = M_PI;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = -rect.size.width;
            
            translateY = -rect.size.height;
            
            break;
            
        default:
            
            rotate = 0.0;
            
            rect = CGRectMake(0, 0, image.size.width, image.size.height);
            
            translateX = 0;
            
            translateY = 0;
            
            break;
            
    }
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    //做CTM变换
    
    CGContextTranslateCTM(context, 0.0, rect.size.height);
    
    CGContextScaleCTM(context, 1.0, -1.0);
    
    CGContextRotateCTM(context, rotate);
    
    CGContextTranslateCTM(context, translateX, translateY);
    
    
    
    CGContextScaleCTM(context, scaleX, scaleY);
    
    //绘制图片
    
    CGContextDrawImage(context, CGRectMake(0, 0, rect.size.width, rect.size.height), image.CGImage);
    
    
    
    UIImage *newPic = UIGraphicsGetImageFromCurrentImageContext();
    
    
    
    return newPic;
    
}


@end
