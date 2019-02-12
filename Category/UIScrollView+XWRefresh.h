//
//  UIScrollView+XWRefresh.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/12/19.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MJRefresh.h>


@interface UIScrollView (XWRefresh)
- (void)addPullRefreshHandle:(void(^)(void))block;
- (void)addPullNextHandle:(void(^)(void))block;
@end

