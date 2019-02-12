//
//  AppDelegate+Push.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/26.
//  Copyright © 2018 admin. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (Push)
+ (void)pushToController:(UIViewController *)vc ;
+ (void)presentToController:(UIViewController *)vc ;
@end

NS_ASSUME_NONNULL_END
