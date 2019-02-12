//
//  JH_AlertManager.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import "JH_AlertManager.h"

@interface JH_AlertManager() <UIAlertViewDelegate>
@property (nonatomic, strong) NSMutableArray *alertViewsArray;
@property (nonatomic, strong) NSMutableArray *alertEventsArray;

@end

@implementation JH_AlertManager
+ (instancetype)sharedHandler {
    static JH_AlertManager *handler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[JH_AlertManager alloc] init];
    });
    return handler;
}
- (instancetype)init {
    if (self = [super init]) {
        _alertViewsArray = @[].mutableCopy;
        _alertEventsArray = @[].mutableCopy;
    }
    return self;
}



// 横列
+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok{
        JHAlertView *view = [[JHAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) alertViewWithBackAlpha:alpha backgroundImage:image noticImage:noticImage taostTit:toast title:title buttonTitle:buttonTitle HideBlock:blcok] ;
        [[UIApplication sharedApplication].keyWindow addSubview:view];
}


+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock{
    JHAlertView *view = [[JHAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) alertViewWithBackAlpha:alpha backgroundImage:image noticImage:noticImage taostTit:toast title:title buttonTitle:buttonTitle HideBlock:blcok sureButtonClickBlock:sureButtonClickBlock] ;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}


+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonImg:(NSString *)buttonImg HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock{
    JHAlertView *view = [[JHAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) alertViewWithBackAlpha:alpha backgroundImage:image noticImage:noticImage taostTit:toast title:title buttonImg:buttonImg HideBlock:blcok sureButtonClickBlock:sureButtonClickBlock] ;
    [[UIApplication sharedApplication].keyWindow addSubview:view];
}

// 纵列
+ (void)showAlertForType:(AlertStyle)alertStyle balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock{
    if (alertStyle == alertOnlyImage) {
        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:1 balpha:balpha backImg:backImg  title:title oneButtonImg:oneButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }else{
        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:2 balpha:balpha backImg:backImg title:title oneButtonImg:oneButtonImg twoButtonImg:twoButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock rightBtnClickBlock:rightBtnClickBlock];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}


+ (void)showAlertForType:(AlertStyle)alertStyle balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title titleCenter:(NSString *)titleCenter oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok  leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock{
    if (alertStyle == alertOnlyImage) {
        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:1 balpha:balpha backImg:backImg  title:title oneButtonImg:oneButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }else{
        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrameAndCenterTit:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:2 balpha:balpha backImg:backImg title:title titleCenter:titleCenter oneButtonImg:oneButtonImg twoButtonImg:twoButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock rightBtnClickBlock:rightBtnClickBlock];
        [[UIApplication sharedApplication].keyWindow addSubview:view];
    }
}


//+ (void)showAlertForTypeDiscount:(AlertStyle)alertStyle balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title titleCenter:(NSString *)titleCenter oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok  leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock{
//    if (alertStyle == alertOnlyImage) {
//        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:1 balpha:balpha backImg:backImg  title:title oneButtonImg:oneButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock];
//        [[UIApplication sharedApplication].keyWindow addSubview:view];
//    }else{
//        JHImageAlertView *view = [[JHImageAlertView alloc] initWithFrameAndCenterTit:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) imgBtnCount:2 balpha:balpha backImg:backImg title:title titleCenter:titleCenter oneButtonImg:oneButtonImg twoButtonImg:twoButtonImg HideBlock:blcok leftBtnClickBlock:leftClickBlock rightBtnClickBlock:rightBtnClickBlock];
//        [[UIApplication sharedApplication].keyWindow addSubview:view];
//    }
//}


+ (void)hideAlert{
    for (UIView *v in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([v isKindOfClass:[JHAlertView class]]) {
            JHAlertView *view = (JHAlertView *)v;
            [view removeFromSuperview];
            view = nil;
            return;
        }

    }
}


+ (void)hideImgeAlert{
    for (UIView *v in [UIApplication sharedApplication].keyWindow.subviews) {
        if ([v isKindOfClass:[JHImageAlertView class]]) {
            JHImageAlertView *view = (JHImageAlertView *)v;
            [view removeFromSuperview];
            view = nil;
            return;
        }
    }
}


@end
