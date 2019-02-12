//
//  XWListAlert.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/12/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface SonView : UIView
@property(nonatomic,strong) UILabel * leftlab;
@property(nonatomic,strong) UILabel * rightlab;

@end



@interface XWListAlert : UIView
@property(nonatomic,strong) UIView * alpha_view;
@property(nonatomic,strong) UIImageView * bg_img;
@property(nonatomic,strong) UIImageView * rightClose;
@property(nonatomic,strong) UILabel * titlelab;

@property(nonatomic,strong) UIButton * sureButton;

- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha array:(NSArray *)array;

- (void)show;
@end


