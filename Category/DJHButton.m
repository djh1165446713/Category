//
//  DJHButton.m
//  SightReading
//
//  Created by bianKerMacBook on 2018/2/28.
//  Copyright © 2018年 QvBian. All rights reserved.
//

#import "DJHButton.h"


@implementation DJHButton
#define scale 0.6
#define titleFont [UIFont systemFontOfSize:18.0]


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        self.titleLabel.font = titleFont;
        self.buttonStyle = imageLeft;
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self imageRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageTop){
        return [self imageRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageBottom){
        return [self imageRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self imageRectWithImageLeftForContentTect:contentRect];
    }
    
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect{
    if (self.buttonStyle == imageRight) {
        return [self titleRectWithImageRightForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageTop){
        return [self titleRectWithImageTopForContentTect:contentRect];
    }
    else if (self.buttonStyle == imageBottom){
        return [self titleRectWithImageBottomForContentTect:contentRect];
    }
    else {
        return [self titleRectWithImageLeftForContentTect:contentRect];
    }
}

#pragma mark imageTop 图片在上 文字在下
- (CGRect)imageRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageTopForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+imageWH;;
    
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);
    
    return rect;
}

#pragma mark imageLeft 图片在左 文字在右
- (CGRect)imageRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageX, inteval, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageLeftForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (imageX < 0) {
        imageX = 0;
    }
    CGRect rect = CGRectMake(imageWH+imageX, 0, titleW , CGRectGetHeight(contentRect));
    
    return rect;
}

#pragma mark imageBottom 图片在下 文字在上
- (CGRect)imageRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat imageY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2+titleH;
    CGFloat imageX = (CGRectGetWidth(contentRect) - imageWH)/2;
    CGRect rect = CGRectMake(imageX, imageY, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageBottomForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)/2*scale;
    CGFloat titleH = [self heightForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleY = (CGRectGetHeight(contentRect)-imageWH-titleH)/2;
    CGRect rect = CGRectMake(0, titleY, CGRectGetWidth(contentRect) , titleH);
    
    return rect;
}

#pragma mark imageRight 图片在右 文字在左
- (CGRect)imageRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat inteval = (CGRectGetHeight(contentRect)-imageWH)/2;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX+titleW , inteval, imageWH, imageWH);
    
    return rect;
}

- (CGRect)titleRectWithImageRightForContentTect:(CGRect)contentRect{
    CGFloat imageWH = CGRectGetHeight(contentRect)*scale;
    CGFloat titleW = [self widthForTitleString:[self titleForState:UIControlStateNormal] ContentRect:contentRect];
    CGFloat titleX = (CGRectGetWidth(contentRect)-titleW-imageWH)/2;
    if (titleX < 0) {
        titleX = 0;
    }
    CGRect rect = CGRectMake(titleX, 0, titleW , CGRectGetHeight(contentRect));
    
    return rect;
}

#pragma mark 计算标题内容宽度
- (CGFloat)widthForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat width = MAX(size.width, 30);
        CGFloat imageW = [self imageForState:UIControlStateNormal].size.width;
        
        if (width+imageW > CGRectGetWidth(contentRect)) { // 当标题和图片宽度超过按钮宽度时不能越界
            return  CGRectGetWidth(contentRect) - imageW;
        }
        return width+10;
    }
    else {
        return CGRectGetWidth(contentRect)/2;
    }
}

#pragma mark 计算标题文字内容的高度
- (CGFloat)heightForTitleString:(NSString *)string ContentRect:(CGRect)contentRect{
    if (string) {
        CGSize constraint = contentRect.size;
        NSAttributedString* attributedText = [[NSAttributedString alloc] initWithString:string attributes:@{NSFontAttributeName: self.titleLabel.font}];
        CGRect rect = [attributedText boundingRectWithSize:constraint options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        CGSize size = rect.size;
        CGFloat height = MAX(size.height, 5);
        
        if (height > CGRectGetHeight(contentRect)/2) { // 当标题高度超过按钮1/2宽度时
            return  CGRectGetHeight(contentRect)/2 ;
        }
        return height;
    }
    else {
        return CGRectGetHeight(contentRect)/2;
    }
}


- (void)layoutButtonWithEdgeInsetsStyle:(ImageStyle)style  imageTitleSpace:(CGFloat)space {
    /**
     *  知识点：titleEdgeInsets是title相对于其上下左右的inset，跟tableView的contentInset是类似的，
     *  如果只有title，那它上下左右都是相对于button的，image也是一样；
     *  如果同时有image和label，那这时候image的上左下是相对于button，右边是相对于label的；title的上右下是相对于button，左边是相对于image的。
     */
    
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.image.size.width;
    CGFloat imageHeight = self.imageView.image.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    if ([UIDevice currentDevice].systemVersion.floatValue >= 8.0) {
        // 由于iOS8中titleLabel的size为0，用下面的这种设置
        labelWidth = self.titleLabel.intrinsicContentSize.width;
        labelHeight = self.titleLabel.intrinsicContentSize.height;
    } else {
        labelWidth = self.titleLabel.frame.size.width;
        labelHeight = self.titleLabel.frame.size.height;
    }
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    
    switch (style) {
        case imageTop:
        {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-space/2.0, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight-space/2.0, 0);
        }
            break;
        case imageLeft:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2.0, 0, space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2.0, 0, -space/2.0);
        }
            break;
        case imageBottom:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight-space/2.0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight-space/2.0, -imageWith, 0, 0);
        }
            break;
        case imageRight:
        {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+space/2.0, 0, -labelWidth-space/2.0);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith-space/2.0, 0, imageWith+space/2.0);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}


@end



