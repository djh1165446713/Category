//
//  JH_AlertManager.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/22.
//  Copyright © 2018 admin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JHAlertView.h"
#import "JHImageAlertView.h"

typedef enum {
    alertDoubleBt,
    alertOnlyImage,
} AlertStyle;

typedef void(^ClickButtonEvent)(NSInteger buttonIndex);


@interface JH_AlertManager : NSObject
// 横列
+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok;

+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonTitle:(NSString *)buttonTitle HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock;

+ (void)showAlertForBackAlpha:(CGFloat)alpha backgroundImage:(UIImage *)image noticImage:(UIImage *)noticImage taostTit:(NSString *)toast title:(NSString *)title buttonImg:(NSString *)buttonImg HideBlock:(HideAlertBlock)blcok sureButtonClickBlock:(sureButtonClickBlock)sureButtonClickBlock;

// 纵列
+ (void)showAlertForType:(AlertStyle)alertStyle balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok  leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock ;  // twobuttonimg 为nil时，创建一个按钮，同时title最好也赋值为nil


+ (void)showAlertForType:(AlertStyle)alertStyle balpha:(CGFloat)balpha backImg:(UIImage *)backImg title:(NSString *)title titleCenter:(NSString *)titleCenter oneButtonImg:(UIImage *)oneButtonImg twoButtonImg:(UIImage *)twoButtonImg HideBlock:(HideBlock)blcok  leftBtnClickBlock:(leftBtnClickBlock)leftClickBlock rightBtnClickBlock:(rightBtnClickBlock)rightBtnClickBlock;

+ (void)hideAlert;

+ (void)hideImgeAlert;




+ (void)showAlertViewWithAction:(ClickButtonEvent _Nullable)actionBlock
                          title:(nullable NSString *)title
                        message:(nullable NSString *)message
              cancelButtonTitle:(nullable NSString *)cancelButtonTitle
              otherButtonTitles:(nullable NSString *)otherButtonTitles, ... NS_REQUIRES_NIL_TERMINATION;

@end


