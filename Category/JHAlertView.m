//
//  JHAlertView.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JHAlertView.h"
@interface JHAlertView()
@property(nonatomic,copy) NSString * title;
@property(nonatomic,copy) NSString * toast;
@property(nonatomic,strong) UIImage * backgroundImage;
@property(nonatomic,strong) UIImage * noticImage;
@property(nonatomic,copy) NSString * buttonTitle;
@property(nonatomic,assign) CGFloat alpha;
@property(nonatomic,copy) NSString * buttonImg;

@property(nonatomic,copy) HideAlertBlock block;

@property(nonatomic,copy) sureButtonClickBlock sureButtonClickBlock;
@end


@implementation JHAlertView
- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok {
    if ([super initWithFrame:frame]) {
        self.title = title;
        self.toast = toast;
        self.backgroundImage = image;
        self.noticImage = noticImage;
        self.buttonTitle = buttonTitle;
        self.alpha = alpha;
        self.block = blcok;
        [self setupUI];
        [self setView];
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock{
    if ([super initWithFrame:frame]) {
        self.title = title;
        self.toast = toast;
        self.backgroundImage = image;
        self.noticImage = noticImage;
        self.buttonTitle = buttonTitle;
        self.alpha = alpha;
        self.block = blcok;
        self.sureButtonClickBlock = sureButtonClickBlock;
        [self setupUI];
        [self setView];

    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonImg:(NSString *)buttonImg HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock{
    if ([super initWithFrame:frame]) {
        self.title = title;
        self.toast = toast;
        self.backgroundImage = image;
        self.noticImage = noticImage;
        self.buttonImg = buttonImg;
        self.alpha = alpha;
        self.block = blcok;
        self.sureButtonClickBlock = sureButtonClickBlock;
        [self setupUI];
        [self setView];
        
    }
    return self;
}

- (void)setView{
    self.alpha_view.alpha = self.alpha;
    self.bg_img.image = self.backgroundImage;
    self.noticIcon.image = self.noticImage;
    self.titlelab.text = self.title;
    [self.sureButton setImage:[UIImage imageNamed:self.buttonImg] forState:0];
    self.taostTitlab.text = self.toast;
    [self.sureButton setTitle:self.buttonTitle forState:(UIControlStateNormal)];
}

- (void)setupUI{
    WEAKSELF;
    self.alpha_view = [[UIView alloc] initWithFrame:self.frame];
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    self.alpha_view.userInteractionEnabled = YES;
    [self.alpha_view addGestureRecognizer:hideTap];
    self.alpha_view.backgroundColor = [UIColor blackColor];
    [self addSubview:self.alpha_view];
    
    [self addSubview:self.bg_img];
    [self addSubview:self.rightClose];
    [self addSubview:self.noticIcon];
    [self addSubview:self.titlelab];
    [self addSubview:self.taostTitlab];
    [self addSubview:self.sureButton];

    
    [self.bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(245), kRealValue(260)));
    }];
    
    
    [self.rightClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bg_img).offset(kRealValue(15));
        make.right.equalTo(weakSelf.bg_img).offset(-(kRealValue(15)));
        make.size.sizeOffset(CGSizeMake(kRealValue(14), kRealValue(14)));
    }];
    
    [self.noticIcon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.bg_img).offset(kRealValue(20));
        make.size.sizeOffset(CGSizeMake(kRealValue(50), kRealValue(50)));
    }];
    
    [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.noticIcon.mas_bottom).offset(kRealValue(15));
        make.size.sizeOffset(CGSizeMake(kRealValue(200), kRealValue(35)));
    }];
    
    [self.taostTitlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.titlelab.mas_bottom).offset(kRealValue(15));
        make.size.sizeOffset(CGSizeMake(kRealValue(205), kRealValue(52)));
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.taostTitlab.mas_bottom).offset(kRealValue(15));
        make.size.sizeOffset(CGSizeMake(kRealValue(205), 45));
    }];
}


- (UIImageView *)bg_img{
    if (!_bg_img) {
        _bg_img = [[UIImageView alloc] init];
        UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBg_imgAction)];
        _bg_img.userInteractionEnabled = YES;
        [_bg_img addGestureRecognizer:hideTap];
        _bg_img.layer.masksToBounds = YES;
        _bg_img.layer.cornerRadius = 7;
        _bg_img.contentMode = UIViewContentModeScaleAspectFit;
        _bg_img.backgroundColor = [UIColor whiteColor];
    }
    return _bg_img;
}


- (UIImageView *)rightClose{
    if (!_rightClose) {
        _rightClose = [[UIImageView alloc] init];
        _rightClose.contentMode = UIViewContentModeScaleAspectFit;
        _rightClose.userInteractionEnabled = YES;
        WEAKSELF;
        UITapGestureRecognizer *removeTap = [[UITapGestureRecognizer alloc] initWithActionBlock:^(id  _Nonnull sender) {
            [weakSelf hideAction];
        }];
        [_rightClose addGestureRecognizer:removeTap];
        _rightClose.image = [UIImage imageNamed:@"pop_close"];
    }
    return _rightClose;
}

- (UIImageView *)noticIcon{
    if(!_noticIcon){
        _noticIcon = [[UIImageView alloc] init];
        _noticIcon.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _noticIcon;
}

- (UILabel *)titlelab{
    if(!_titlelab){
        _titlelab = [[UILabel alloc] init];
        _titlelab.textColor = [UIColor blackColor];
        _titlelab.numberOfLines = 0;
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:17];
    }
    return _titlelab;
}


- (UILabel *)taostTitlab{
    if(!_taostTitlab){
        _taostTitlab = [[UILabel alloc] init];
        _taostTitlab.textColor = labNorColorFFFFFF;
        _taostTitlab.textAlignment = NSTextAlignmentCenter;
        _taostTitlab.numberOfLines = 0;
        _taostTitlab.font = [UIFont systemFontOfSize:14];
    }
    return _taostTitlab;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.layer.cornerRadius = 45 / 2;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.backgroundColor = HexColor(@"#FBD571");
        [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureButton sizeToFit];
        
    }
    return _sureButton;
}


- (void)hideAction{
    [self removeFromSuperview];
    if (self.block) {
        self.block(self);
    }
}

- (void)hideBg_imgAction{
    NSLog(@"背景白条点击方法");
}


- (void)sureButtonAction:(UIButton *)button{
    [self removeFromSuperview];
    if (self.sureButtonClickBlock) {
        self.sureButtonClickBlock();
    }
}



@end
