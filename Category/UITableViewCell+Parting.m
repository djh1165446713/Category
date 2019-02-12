//
//  UITableViewCell+Parting.m
//  privatePersonDemo
//
//  Created by admin on 16/7/16.
//  Copyright © 2016年 admin. All rights reserved.
//

#import "UITableViewCell+Parting.h"

@implementation UITableViewCell (Parting)
+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        SEL originalSelector = @selector(layoutSubviews);
        SEL swizzledSelector = @selector(swizzling_layoutSubviews);
        
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
}

-(void)swizzling_layoutSubviews{
    [self swizzling_layoutSubviews];
//    //获取成员变量列表
//    unsigned int count;
//    Ivar *ivarList = class_copyIvarList([self class], &count);
//    for (unsigned int i = 0; i < count; i++) {
//        Ivar ivar = ivarList[i];
//        DebugLog(@"-------getRunTimeIvarList: %@",[NSString stringWithUTF8String:ivar_getName(ivar)]);
//    }
    UIView *separatorView = [self valueForKey:@"_separatorView"];//
    CGRect frame = separatorView.frame;
    frame.origin.x = 15;
    frame.size.width = self.frame.size.width - 30;
    separatorView.backgroundColor = HexColor(@"e7e7e7");
    separatorView.frame = frame;
}

- (void)setAccessoryType:(UITableViewCellAccessoryType)accessoryType {
    if (accessoryType == UITableViewCellAccessoryDisclosureIndicator) {
        UIImageView *accessoryView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"normal_list_here_icon"]];
        accessoryView.centerY = self.centerY;
        accessoryView.right = self.width-20;
        self.accessoryView = accessoryView;
    } else if (accessoryType == UITableViewCellAccessoryNone) {
        self.accessoryView = nil;
    }
}
@end
