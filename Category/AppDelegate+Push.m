//
//  AppDelegate+Push.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/26.
//  Copyright © 2018 admin. All rights reserved.
//

#import "AppDelegate+Push.h"
#import "XWTabbarViewController.h"
#import "XWNavigationViewController.h"
@implementation AppDelegate (Push)
+ (void)pushToController:(UIViewController *)vc {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // umeng error report
    if ([appDelegate.window.rootViewController isKindOfClass:[XWTabbarViewController class]]) {
        XWTabbarViewController *rootVC = (XWTabbarViewController *)appDelegate.window.rootViewController;
        if ([[rootVC selectedViewController] isKindOfClass:[XWNavigationViewController class]]) {
            XWNavigationViewController *nav = (XWNavigationViewController *)[rootVC selectedViewController];
            [nav pushViewController:vc animated:YES];
            
        } else {
            
        }
    }
}


+ (void)presentToController:(UIViewController *)vc{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    // umeng error report
    if ([appDelegate.window.rootViewController isKindOfClass:[XWTabbarViewController class]]) {
        XWTabbarViewController *rootVC = (XWTabbarViewController *)appDelegate.window.rootViewController;
        if ([[rootVC selectedViewController] isKindOfClass:[XWNavigationViewController class]]) {
            XWNavigationViewController *nav = (XWNavigationViewController *)[rootVC selectedViewController];
            [nav presentViewController:vc animated:YES completion:nil];
            
        } else {
            
        }
    }
}

@end
