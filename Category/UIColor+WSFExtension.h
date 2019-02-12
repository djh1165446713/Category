//
//  UIColor+WSFExtension.h
//

#import <UIKit/UIKit.h>

@interface UIColor (WSFExtension)

+ (UIColor *)randomColor;

+ (instancetype)colorWithHex:(NSString*)hex andAlpha:(CGFloat)alpha;

@end
