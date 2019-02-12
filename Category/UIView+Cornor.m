//
//  Cornor.m
//  SdkDemo
//
//  Created by 熊玮 on 14/7/24.
//  Copyright (c) 2014年 bbdtek. All rights reserved.
//

#import "UIView+Cornor.h"

@implementation UIView (Cornor)

- (void)setRadius:(CGFloat)radius
      borderWidth:(CGFloat)borderWidth
      borderColor:(UIColor *)borderColor
{
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = borderWidth;
    self.layer.cornerRadius = radius;
}

-(void)roundedView:(UIView *)view byRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize
                                                                                       )cornerRadii{
    /*参数说明
     
     view
     要修改的控件
     
     corners
     圆角位置,系统的枚举,多个参照下面
     
     cornerRadii
     圆角的
     size
     */
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii
                                                                    :cornerRadii];
    //修改显示layer
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = view.bounds;
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}


+ (void)tipWithTitle:(NSString *)title {
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleCustom];
    [SVProgressHUD setBackgroundColor:[[UIColor blackColor] colorWithAlphaComponent:0.6]];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    if (title.length != 0) {
        [SVProgressHUD showImage:nil status:[@" "  stringByAppendingString:title]];
    }
    [SVProgressHUD setMinimumDismissTimeInterval:0.6];
}


+(void)setCornerRadWith:(UIView *)view ByRoundingCorners:(UIRectCorner)corners cornerRadii:(CGSize)cornerRadii fillColor:(UIColor *)fillColor strokeColor:(UIColor *)strokeColor lineWidth:(CGFloat)lineWidth{
    
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds byRoundingCorners:corners cornerRadii:cornerRadii];
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = view.bounds;
    layer.path = path.CGPath;
    layer.fillColor = fillColor.CGColor;
    layer.lineWidth = lineWidth;
    layer.strokeColor = strokeColor.CGColor;
    view.layer.mask = layer;
//    [view.layer addSublayer: layer];
}

//获取当前 view 的控制器
- (UIViewController *)viewController {
    for (UIView* next = [self superview]; next; next = next.superview) {
        UIResponder *nextResponder = [next nextResponder];
        if ([nextResponder isKindOfClass:[UIViewController class]]) {
            return (UIViewController *)nextResponder;
        }
    }
    return nil;
}
//是否隐藏状态栏
- (void)hideStatusBarBackground:(BOOL)ishidden {
    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    statusBar.hidden = ishidden;
}

- (UIViewController *)_getRootViewController {
    UIViewController *ctrl = nil;
    UIApplication *app = YYTextSharedApplication();
    if (!ctrl) ctrl = app.keyWindow.rootViewController;
    if (!ctrl) ctrl = [app.windows.firstObject rootViewController];
    if (!ctrl) ctrl = [self viewController];
    if (!ctrl) return nil;
    
    while (!ctrl.view.window && ctrl.presentedViewController) {
        ctrl = ctrl.presentedViewController;
    }
    if (!ctrl.view.window) return nil;
    return ctrl;
}

@end
