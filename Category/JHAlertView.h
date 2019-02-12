//
//  JHAlertView.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@class JHAlertView;

typedef void(^HideAlertBlock)(JHAlertView *view);
typedef void(^sureButtonClickBlock)(void);

@interface JHAlertView : UIView
@property(nonatomic,strong) UIView * alpha_view;
@property(nonatomic,strong) UIImageView * bg_img;
@property(nonatomic,strong) UIImageView * rightClose;
@property(nonatomic,strong) UIImageView * noticIcon;
@property(nonatomic,strong) UILabel * taostTitlab;
@property(nonatomic,strong) UILabel * titlelab;
@property(nonatomic,strong) UIButton * sureButton;




- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok;

- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock;

- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonImg:(NSString *)buttonImg HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock;
@end


