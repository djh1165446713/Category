//
//  JHImageAlertView.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHImageAlertView;

typedef void(^HideBlock)(JHImageAlertView *view);
typedef void(^leftBtnClickBlock)(JHImageAlertView *view);
typedef void(^rightBtnClickBlock)(JHImageAlertView *view);


@interface JHImageAlertView : UIView
@property(nonatomic,strong) UIView * alpha_view;
@property(nonatomic,strong) UIImageView * bg_img;
@property(nonatomic,strong) UIImageView * oneButton;
@property(nonatomic,strong) UIImageView * twoButton;
@property(nonatomic,strong) UILabel * titLab;

@property(nonatomic,strong) UILabel * centerTitLab;


- (instancetype)initWithFrame:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title oneButtonImg:(UIImage *)oneButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock ;

- (instancetype)initWithFrame:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString*)title oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock  rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock;

- (instancetype)initWithFrameAndCenterTit:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString*)title titleCenter:(NSString*)titleCenter oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock  rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock;
@end

