//
//  JHImageAlertView.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JHImageAlertView.h"
@interface JHImageAlertView()
@property(nonatomic,strong) UIImage * backgroundImage;
@property(nonatomic,assign) CGFloat alpha;
@property(nonatomic,strong) UIImage * oneButtonImg;
@property(nonatomic,strong) UIImage * twoButtonImg;
@property(nonatomic,strong) NSString * title;
@property(nonatomic,copy) HideBlock block;
@property(nonatomic,copy) leftBtnClickBlock leftBtnClickBlock;
@property(nonatomic,copy) rightBtnClickBlock rightBtnClickBlock;
@property(nonatomic,strong) NSString * titleCenter;

@end
@implementation JHImageAlertView

- (instancetype)initWithFrame:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title oneButtonImg:(UIImage *)oneButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock{
    if ([super initWithFrame:frame]) {
        self.alpha = balpha;
        self.backgroundImage = backImg;
        self.oneButtonImg = oneButtonImg;
        self.block = blcok;
        self.title = title;
        self.leftBtnClickBlock = leftClickBlock;

        [self setupUIImgBtnCount:count];
        [self setViewCount:count];
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString*)title oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock  rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock{
    if ([super initWithFrame:frame]) {
        self.alpha = balpha;
        self.backgroundImage = backImg;
        self.oneButtonImg = oneButtonImg;
        self.twoButtonImg = twoButtonImg;
        self.title = title;
        self.block = blcok;
        self.leftBtnClickBlock = leftClickBlock;
        self.rightBtnClickBlock = rightBtnClickBlock;

        [self setupUIImgBtnCount:count];
        [self setViewCount:count];
    }
    return self;
}


- (instancetype)initWithFrameAndCenterTit:(CGRect)frame imgBtnCount:(NSInteger)count balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString*)title titleCenter:(NSString*)titleCenter oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock  rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock{
    if ([super initWithFrame:frame]) {
        self.alpha = balpha;
        self.backgroundImage = backImg;
        self.oneButtonImg = oneButtonImg;
        self.block = blcok;
        self.title = title;
        self.titleCenter = titleCenter;
        self.leftBtnClickBlock = leftClickBlock;
        
        [self setupUIImgBtnCount1:count];
        [self setViewCount1:count];
    }
    return self;
}


- (void)setViewCount:(NSInteger)count{
    self.alpha_view.alpha = self.alpha;
    self.bg_img.image = self.backgroundImage;
    self.oneButton.image = self.oneButtonImg;
    self.titLab.text = self.title;
    if (count != 1) {
        self.twoButton.image = self.twoButtonImg;
    }
}

- (void)setViewCount1:(NSInteger)count{
    self.alpha_view.alpha = self.alpha;
    self.bg_img.image = self.backgroundImage;
    self.oneButton.image = self.oneButtonImg;
    self.titLab.text = self.title;
    self.centerTitLab.text = self.titleCenter;
    if (count != 1) {
        self.twoButton.image = self.twoButtonImg;
    }

}

- (void)setupUIImgBtnCount:(NSInteger)count{
    self.alpha_view = [[UIView alloc] initWithFrame:self.frame];
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    self.alpha_view.userInteractionEnabled = YES;
    [self.alpha_view addGestureRecognizer:hideTap];
    self.alpha_view.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.alpha_view];
    
    [self addSubview:self.bg_img];
    [self addSubview:self.oneButton];


    WEAKSELF;
    CGFloat height_bg_img;

    if (count == 1) {
        height_bg_img = 300;
    }else{
        height_bg_img = 374;
        [self addSubview:self.twoButton];
    }
    [self addSubview:self.titLab];

    
    [self.bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(325), kRealValue(height_bg_img)));
    }];
    
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.bg_img.mas_bottom).offset(-(kRealValue(20)));
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(263), kRealValue(53)));
    }];
    
    if (count == 2) {
        [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.oneButton.mas_top).offset(-(kRealValue(12)));
            make.centerX.equalTo(weakSelf);
            make.size.sizeOffset(CGSizeMake(kRealValue(263), kRealValue(53)));
        }];
    }
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bg_img.mas_top).offset(kRealValue(116));
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(220), kRealValue(55)));
    }];
    
}





- (void)setupUIImgBtnCount1:(NSInteger)count{
    self.alpha_view = [[UIView alloc] initWithFrame:self.frame];
    UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideAction)];
    self.alpha_view.userInteractionEnabled = YES;
    [self.alpha_view addGestureRecognizer:hideTap];
    self.alpha_view.backgroundColor = [UIColor blackColor];
    
    [self addSubview:self.alpha_view];
    
    [self addSubview:self.bg_img];
    [self addSubview:self.oneButton];
    
    
    WEAKSELF;
    CGFloat height_bg_img;
    
    if (count == 1) {
        height_bg_img = 290;
    }else{
        height_bg_img = 364;
        [self addSubview:self.twoButton];
    }
    [self addSubview:self.titLab];
    
    [self addSubview:self.centerTitLab];

    [self.bg_img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(weakSelf);
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(325), kRealValue(height_bg_img)));
    }];
    
    
    if (count == 2) {
        [self.twoButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(weakSelf.oneButton.mas_top).offset(-(kRealValue(12)));
            make.centerX.equalTo(weakSelf);
            make.size.sizeOffset(CGSizeMake(kRealValue(263), kRealValue(53)));
        }];
    }

    
    [self.centerTitLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bg_img.mas_top).offset(kRealValue(161));
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(240), kRealValue(45)));
    }];
    
    [self.titLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(weakSelf.centerTitLab.mas_top).offset(kRealValue(-5));
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(220), kRealValue(20)));
    }];
    
    
    [self.oneButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.centerTitLab.mas_bottom).offset((kRealValue(50)));
        make.centerX.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(kRealValue(263), kRealValue(53)));
    }];
}

- (UIImageView *)bg_img{
    if (!_bg_img) {
        _bg_img = [[UIImageView alloc] init];
        UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBg_imgAction)];
        _bg_img.layer.masksToBounds = YES;
        _bg_img.layer.cornerRadius = 7;
        _bg_img.userInteractionEnabled = YES;
        [_bg_img addGestureRecognizer:hideTap];
        _bg_img.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _bg_img;
}



- (UIImageView *)oneButton{
    if (!_oneButton) {
        _oneButton = [[UIImageView alloc] init];
        _oneButton.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(oneButtonAction)];
       _oneButton.userInteractionEnabled = YES;
        [_oneButton addGestureRecognizer:tap];
    }
    return _oneButton;
}

- (UIImageView *)twoButton{
    if (!_twoButton) {
        _twoButton = [[UIImageView alloc] init];
        _twoButton.contentMode = UIViewContentModeScaleAspectFit;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(twoButtonAction)];
        _twoButton.userInteractionEnabled = YES;
        [_twoButton addGestureRecognizer:tap];
    }
    return _twoButton;
}

- (UILabel *)titLab{
    if(!_titLab){
        _titLab = [[UILabel alloc] init];
        _titLab.textColor = [UIColor blackColor];
        _titLab.textAlignment = NSTextAlignmentCenter;
        _titLab.font = [UIFont systemFontOfSize:17];
        _titLab.numberOfLines = 0;
    }
    return _titLab;
}

- (UILabel *)centerTitLab{
    if(!_centerTitLab){
        _centerTitLab = [[UILabel alloc] init];
        _centerTitLab.textColor = HexColor(@"#675628");
        _centerTitLab.textAlignment = NSTextAlignmentCenter;
        _centerTitLab.font = [UIFont systemFontOfSize:14];
        _centerTitLab.numberOfLines = 0;
        _centerTitLab.hidden = NO;
    }
    return _centerTitLab;
}

- (void)hideAction{
    [self removeFromSuperview];
    if (self.block) {
        self.block(self);
    }
}


- (void)oneButtonAction{
    [self removeFromSuperview];
    if (self.leftBtnClickBlock) {
        self.leftBtnClickBlock(self);
    }
}

- (void)twoButtonAction{
    [self removeFromSuperview];
    if (self.rightBtnClickBlock) {
        self.rightBtnClickBlock(self);
    }
}

- (void)hideBg_imgAction{
    
}
@end
