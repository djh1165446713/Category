//
//  XWListAlert.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/12/29.
//  Copyright © 2018 admin. All rights reserved.
//

#import "XWListAlert.h"
@interface SonView()


@end

@implementation SonView
- (instancetype)initWithFrame:(CGRect)frame{
    if ([super initWithFrame:frame]) {
        [self setView];
        
    }
    return self;
}

- (void)setView{
    [self addSubview:self.leftlab];
    [self addSubview:self.rightlab];
    WEAKSELF;
    [self.leftlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakSelf).offset(0);
        make.centerY.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(100,17));
    }];
    
    [self.rightlab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(weakSelf.mas_right).offset(0);
        make.centerY.equalTo(weakSelf);
        make.size.sizeOffset(CGSizeMake(100,17));
    }];
}

- (UILabel *)leftlab{
    if(!_leftlab){
        _leftlab = [[UILabel alloc] init];
        _leftlab.textColor = HexColor(@"#999999");
        _leftlab.textAlignment = NSTextAlignmentLeft;
        _leftlab.font = [UIFont systemFontOfSize:14];
    }
    return _leftlab;
}

- (UILabel *)rightlab{
    if(!_rightlab){
        _rightlab = [[UILabel alloc] init];
        _rightlab.textColor = HexColor(@"#999999");
        _rightlab.textAlignment = NSTextAlignmentRight;
        _rightlab.font = [UIFont systemFontOfSize:14];
    }
    return _rightlab;
}

@end


@interface XWListAlert()
@property(nonatomic,assign) CGFloat alpha;
@property(nonatomic,assign) float withdrawNum;
@property(nonatomic,assign) float interest;
@property(nonatomic,assign) float discount;
@property(nonatomic,assign) float last;
@property(nonatomic,strong) NSArray * array;
@end

@implementation XWListAlert
- (instancetype)initWithFrame:(CGRect)frame alertViewWithBackAlpha:(CGFloat)alpha array:(NSArray *)array{
    if ([super initWithFrame:frame]) {
        self.alpha = alpha;
        self.array = array;
    

        [self setupUI];
        [self setView];
        
    }
    return self;
}

- (void)setView{
    self.alpha_view.alpha = self.alpha;
   
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
    [self addSubview:self.titlelab];

    [self addSubview:self.sureButton];
    
    
    [self.rightClose mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.bg_img).offset(kRealValue(15));
        make.right.equalTo(weakSelf.bg_img).offset(-(kRealValue(15)));
        make.size.sizeOffset(CGSizeMake(kRealValue(14), kRealValue(14)));
    }];
    
    [self.titlelab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.top.equalTo(weakSelf.bg_img).offset(kRealValue(25));
        make.size.sizeOffset(CGSizeMake(kRealValue(150), kRealValue(24)));
    }];
    
    [self.sureButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakSelf);
        make.bottom.equalTo(weakSelf.bg_img.mas_bottom).offset(kRealValue(-15));
        make.size.sizeOffset(CGSizeMake(kRealValue(205), kRealValue(52)));
    }];
    
    for (int i = 0; i < self.array.count; i++) {
        SonView *v = [[SonView alloc] initWithFrame:CGRectMake(kRealValue(91), self.bg_img.top + kRealValue(64) + (kRealValue(10) + 17) * i, self.bg_img.width - 50, 17)];
        NSDictionary *dic = self.array[i];
        v.leftlab.text = dic[@"left"];
        v.rightlab.text = dic[@"right"];

        [self addSubview:v];
    }
}
- (UIImageView *)bg_img{
    if (!_bg_img) {
        _bg_img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kRealValue(245), kRealValue(45 + 85 + self.array.count * kRealValue(27)))];
        _bg_img.centerY = self.centerY;
        _bg_img.centerX = self.centerX;
        _bg_img.layer.masksToBounds = YES;
        _bg_img.layer.cornerRadius = 4;
        UITapGestureRecognizer *hideTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hideBg_imgAction)];
        _bg_img.userInteractionEnabled = YES;
        [_bg_img addGestureRecognizer:hideTap];
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
            [weakSelf removeFromSuperview];
        }];
        [_rightClose addGestureRecognizer:removeTap];
        _rightClose.image = [UIImage imageNamed:@"pop_close"];
    }
    return _rightClose;
}

- (UILabel *)titlelab{
    if(!_titlelab){
        _titlelab = [[UILabel alloc] init];
        _titlelab.textColor = [UIColor blackColor];
        _titlelab.text = @"账单金额明细";
        _titlelab.textAlignment = NSTextAlignmentCenter;
        _titlelab.font = [UIFont systemFontOfSize:17];
    }
    return _titlelab;
}

- (UIButton *)sureButton{
    if (!_sureButton) {
        _sureButton = [[UIButton alloc] init];
        _sureButton.layer.cornerRadius = kRealValue(52) / 2;
        _sureButton.layer.masksToBounds = YES;
        _sureButton.backgroundColor = HexColor(@"#FBD571");
        [_sureButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_sureButton addTarget:self action:@selector(sureButtonAction) forControlEvents:UIControlEventTouchUpInside];
        _sureButton.titleLabel.font = [UIFont systemFontOfSize:17];
        [_sureButton setTitle:@"知道了" forState:0];
        [_sureButton sizeToFit];
        
    }
    return _sureButton;
}


- (void)hideAction{
    [self removeFromSuperview];

}

- (void)hideBg_imgAction{
    [self removeFromSuperview];
}

- (void)sureButtonAction{
    [self removeFromSuperview];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
}
@end
