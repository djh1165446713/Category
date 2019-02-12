//
//  UIImage+Category.m
//  paopao
//
//  Created by yite on 14-4-28.
//  Copyright (c) 2014年 yite. All rights reserved.
//

#import "UIImage+Category.h"


//CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
//CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};


@implementation UIImage (Category)

#pragma mark - 这边用的imageWithBgColor方法截取屏幕颜色图片
+ (UIImage *)imageWithBgColor:(UIColor *)color{
    
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    
    UIGraphicsBeginImageContext(rect.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    
    CGContextFillRect(context, rect);
    
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return image;
    
}

//获取启动图
+ (UIImage *)getLaunchImage{
    CGSize viewSize = [UIScreen mainScreen].bounds.size;
    NSString *viewOr = @"Portrait";//垂直
    NSString *launchImage = nil;
    NSArray *launchImages =  [[[NSBundle mainBundle] infoDictionary] valueForKey:@"UILaunchImages"];
    for (NSDictionary *dict in launchImages) {
        CGSize imageSize = CGSizeFromString(dict[@"UILaunchImageSize"]);
        if (CGSizeEqualToSize(viewSize, imageSize) && [viewOr isEqualToString:dict[@"UILaunchImageOrientation"]]) {
            launchImage = dict[@"UILaunchImageName"];
        }
    }
    return [UIImage imageNamed:launchImage];
}

#pragma mark - 旋转
- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
//    [rotatedViewBox release];
    
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return resImage;
}

- (UIImage *)rescaleImageToSize:(CGSize)size {
    
    CGRect rect = CGRectMake(0.0, 0.0, size.width, size.height);
    
    UIGraphicsBeginImageContext(rect.size);
    
    [self drawInRect:rect];  // scales image to rect
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    return resImage;
    
}

#define PIC_WIDTH 1080

- (UIImage *)resizeImageWithCapInsets:(UIEdgeInsets)capInsets {
    CGFloat systemVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
    UIImage *image = nil;
    if (systemVersion >= 5.0) {
        image = [self resizableImageWithCapInsets:capInsets];
        return image;
    }
    else
        image = [self stretchableImageWithLeftCapWidth:capInsets.left topCapHeight:capInsets.top];
    return image;
}

- (UIImage *)fixOrientation {
    // No-op if the orientation is already correct
    if (self.imageOrientation == UIImageOrientationUp) return self;
    
    // We need to calculate the proper transformation to make the image upright.
    // We do it in 2 steps: Rotate if Left/Right/Down, and then flip if Mirrored.
    CGAffineTransform transform = CGAffineTransformIdentity;
    
    switch (self.imageOrientation) {
        case UIImageOrientationDown:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, self.size.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformRotate(transform, M_PI_2);
            break;
            
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, 0, self.size.height);
            transform = CGAffineTransformRotate(transform, -M_PI_2);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationUpMirrored:
            break;
    }
    
    switch (self.imageOrientation) {
        case UIImageOrientationUpMirrored:
        case UIImageOrientationDownMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.width, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRightMirrored:
            transform = CGAffineTransformTranslate(transform, self.size.height, 0);
            transform = CGAffineTransformScale(transform, -1, 1);
            break;
            
        case UIImageOrientationUp:
        case UIImageOrientationDown:
        case UIImageOrientationLeft:
        case UIImageOrientationRight:
            break;
    }
    
    // Now we draw the underlying CGImage into a new context, applying the transform
    // calculated above.
    CGContextRef ctx = CGBitmapContextCreate(NULL, self.size.width, self.size.height,
                                             CGImageGetBitsPerComponent(self.CGImage), 0,
                                             CGImageGetColorSpace(self.CGImage),
                                             CGImageGetBitmapInfo(self.CGImage));
    CGContextConcatCTM(ctx, transform);
    switch (self.imageOrientation) {
        case UIImageOrientationLeft:
        case UIImageOrientationLeftMirrored:
        case UIImageOrientationRight:
        case UIImageOrientationRightMirrored:
            // Grr...
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.height, self.size.width), self.CGImage);
            break;
            
        default:
            CGContextDrawImage(ctx, CGRectMake(0, 0, self.size.width, self.size.height), self.CGImage);
            break;
    }
    
    // And now we just create a new UIImage from the drawing context
    CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
    UIImage *img = [UIImage imageWithCGImage:cgimg];
    CGContextRelease(ctx);
    CGImageRelease(cgimg);
    return img;
}

+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation {
    long double rotate = 0.0;
    CGRect rect;
    CGFloat translateX = 0;
    CGFloat translateY = 0;
    CGFloat scaleX = 1.0;
    CGFloat scaleY = 1.0;
    
    switch (orientation) {
        case UIImageOrientationLeft:
            rotate = M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = 0;
            translateY = -rect.size.width;
            scaleY = rect.size.width / rect.size.height;
            scaleX = rect.size.height / rect.size.width;
            break;
            
        case UIImageOrientationRight:
            rotate = 3 * M_PI_2;
            rect = CGRectMake(0, 0, image.size.height, image.size.width);
            translateX = -rect.size.height;
            translateY = 0;
            scaleY = rect.size.width / rect.size.height;
            scaleX = rect.size.height / rect.size.width;
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

- (UIImage *)scaleToSize:(CGSize)size {
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
    CGFloat verticalRadio = size.height * 1.0 / height;
    CGFloat horizontalRadio = size.width * 1.0 / width;
    
    CGFloat radio = 1.f;
    
    if (verticalRadio > 1 && horizontalRadio > 1)
        radio = verticalRadio > horizontalRadio ? horizontalRadio : verticalRadio;
    else
        radio = verticalRadio < horizontalRadio ? verticalRadio : horizontalRadio;
    
    width = width * radio;
    height = height * radio;
    
    CGFloat xPos = (size.width - width) / 2.f;
    CGFloat yPos = (size.height - height) / 2.f;
    
    // 创建一个bitmap的context
    // 并把它设置成为当前正在使用的context
    UIGraphicsBeginImageContext(size);
    
    // 绘制改变大小的图片
    [self drawInRect:CGRectMake(xPos, yPos, width, height)];
    
    // 从当前context中创建一个改变大小后的图片
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    
    // 返回新的改变大小后的图片
    return scaledImage;
}

+ (UIImage *)imageWithImage:(UIImage *)image scaledToSize:(CGSize)newSize {
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 1.0);
    [image drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image scaleFactor:(float)scaleFloat {
    CGSize size = CGSizeMake((int)(image.size.width * scaleFloat), (int)(image.size.height * scaleFloat));
    
    UIGraphicsBeginImageContext(size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGAffineTransform transform = CGAffineTransformIdentity;
    transform = CGAffineTransformScale(transform, scaleFloat, scaleFloat);
    CGContextConcatCTM(context, transform);
    [image drawAtPoint:CGPointMake(0.0f, 0.0f)];
    UIImage *newimg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newimg;
}

+ (UIImage *)chatModifyImage:(UIImage *)image {
    UIImage *newImage;
    if (image.size.width >= PIC_WIDTH && image.size.height >= PIC_WIDTH) {
        float scale = 0;
        if (image.size.width < image.size.height) {
            scale = PIC_WIDTH / image.size.width;
        }
        else {
            scale = PIC_WIDTH / image.size.height;
        }
        newImage = [UIImage scaleImage:image scaleFactor:scale];
    }
    else if (image.size.width < 640 && image.size.height < 640) {
        newImage = [UIImage scaleImage:image scaleFactor:1.f];
    }
    else if (image.size.height / image.size.width > 1.5 || image.size.width / image.size.height > 1.5) {
        float min = 0;
        if (image.size.height > image.size.width) {
            min = image.size.width;
        }
        else
            min = image.size.height;
        
        float scale = 0;
        if (min > 640) {
            scale = 640 / min;
        }
        else
            scale = min / 640;
        
        newImage = [UIImage scaleImage:image scaleFactor:scale];
    }else{
        newImage = [UIImage scaleImage:image scaleFactor:1.f];
    }
    
    return newImage;
}

+ (UIImage *)modifyImage:(UIImage *)image {
    UIImage *newImage;
    if (image.size.width > PIC_WIDTH && image.size.height > PIC_WIDTH) {
        float scale = PIC_WIDTH / image.size.height;
        newImage = [UIImage scaleImage:image scaleFactor:scale];
    }
    else
        newImage = image;
    return newImage;
}

- (BOOL)judgeImageWidth:(float)imageWidth {
    BOOL isNot = NO;
    if (imageWidth >= 200 && imageWidth <= PIC_WIDTH) {
        isNot = YES;
    }
    return isNot;
}

- (BOOL)judgeImageHeight:(float)imageHeigth {
    BOOL isNot = NO;
    if (imageHeigth >= 200 && imageHeigth <= PIC_WIDTH) {
        isNot = YES;
    }
    return isNot;
}

- (UIImage *)blurImageWithInputRadius:(CGFloat)radius {
    // create our blurred image
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:self.CGImage];
    
    CIFilter *affineClampFilter = [CIFilter filterWithName:@"CIAffineClamp"];
    CGAffineTransform xform = CGAffineTransformMakeScale(1.0, 1.0);
    [affineClampFilter setValue:inputImage forKey:kCIInputImageKey];
    [affineClampFilter setValue:[NSValue valueWithBytes:&xform
                                               objCType:@encode(CGAffineTransform)]
                         forKey:@"inputTransform"];
    
    CIImage *extendedImage = [affineClampFilter valueForKey:kCIOutputImageKey];
    
    // setting up Gaussian Blur (could use one of many filters offered by Core Image)
    CIFilter *blurFilter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [blurFilter setValue:extendedImage forKey:kCIInputImageKey];
    [blurFilter setValue:[NSNumber numberWithFloat:radius] forKey:@"inputRadius"];
    CIImage *result = [blurFilter valueForKey:kCIOutputImageKey];
    
    // CIGaussianBlur has a tendency to shrink the image a little,
    // this ensures it matches up exactly to the bounds of our original image
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    
    UIImage *returnImage = [UIImage imageWithCGImage:cgImage];
    //create a UIImage for this function to "return" so that ARC can manage the memory of the blur...
    //ARC can't manage CGImageRefs so we need to release it before this function "returns" and ends.
    CGImageRelease(cgImage);//release CGImageRef because ARC doesn't manage this on its own.
    
    return returnImage;
}

+ (UIImage *)imageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}

+ (UIImage *)getFilterImage:(UIImage *)originalImage value:(CGFloat)value type:(ImageFilterType) filterType
{
    if ([UIApplication sharedApplication].applicationState != UIApplicationStateActive) { // gpus_ReturnNotPermittedKillClient crash
        return originalImage;
    }
    UIImage *brighterImage;
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:originalImage.CGImage];
    
    CIFilter *lighten = [CIFilter filterWithName:@"CIColorControls"];
    [lighten setValue:inputImage forKey:kCIInputImageKey];
    
    switch (filterType) {
        case ImageFilterTypeSaturation:
            [lighten setValue:@(value) forKey:@"inputSaturation"];
            break;
        case ImageFilterTypeContrast:
            [lighten setValue:@(value) forKey:@"inputContrast"];
            break;
        case ImageFilterTypeBrightness:
            [lighten setValue:@(value) forKey:@"inputBrightness"];
            break;
        default:
            break;
    }
    
    CIImage *result = [lighten valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[inputImage extent]];
    brighterImage = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    
    return brighterImage;
}

+ (UIImage *)getBlurImage:(UIImage *)originalImage radiusValue:(CGFloat)value{
    CIContext *context = [CIContext contextWithOptions:nil];
    CIImage *inputImage = [CIImage imageWithCGImage:originalImage.CGImage];
    // create gaussian blur filter
    CIFilter *filter = [CIFilter filterWithName:@"CIGaussianBlur"];
    [filter setValue:inputImage forKey:kCIInputImageKey];
    [filter setValue:@(value) forKey:@"inputRadius"];
    // blur image
    CIImage *result = [filter valueForKey:kCIOutputImageKey];
    CGImageRef cgImage = [context createCGImage:result fromRect:[result extent]];
    UIImage *image = [UIImage imageWithCGImage:cgImage];
    CGImageRelease(cgImage);
    return image;
}

+ (UIImage *)getImageFromURL:(NSURL *)imageURL {
    UIImage *result;
    NSData *data = [NSData dataWithContentsOfURL:imageURL];
    result = [UIImage imageWithData:data];
    return result;
}

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
    if (self.size.height > 1080 || self.size.width > 1080) {
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

+ (UIImage *)createImageWithColor:(UIColor *)color {
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
@end
