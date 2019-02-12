//
//  UIScrollView+XWRefresh.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/12/19.
//  Copyright © 2018 admin. All rights reserved.
//

#import "UIScrollView+XWRefresh.h"

@implementation UIScrollView (XWRefresh)
- (void)addPullRefreshHandle:(void(^)(void))block {
    //    MJRefreshGifHeader *header          = [MJRefreshGifHeader headerWithRefreshingBlock:block];
    //    header.lastUpdatedTimeLabel.hidden  = YES;
    //    [header setImages:[ABCommonDataManager getRefreshPullingImages] forState:MJRefreshStateIdle];
    //    [header setImages:[ABCommonDataManager getRefreshRefreshingImages] forState:MJRefreshStateRefreshing];
    //    header.gifView.contentMode          = UIViewContentModeScaleAspectFit;
    //    header.stateLabel.hidden            = YES;
    //    header.backgroundColor              = HEXCOLOR(0xe9e9e9);
    //    self.mj_header                      = header;
    
    MJRefreshNormalHeader *header          = [MJRefreshNormalHeader headerWithRefreshingBlock:block];
    header.lastUpdatedTimeLabel.hidden  = YES;
    header.stateLabel.hidden            = NO;
    header.backgroundColor              = [UIColor colorWithHexString:@"#FFFFFF"];
    self.mj_header                      = header;
}

- (void)addPullNextHandle:(void (^)(void))block {
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:block];
    [footer setTitle:@"" forState:MJRefreshStateIdle];
    [footer setTitle:@"加载中..." forState:MJRefreshStateRefreshing];
    [footer setTitle:@"到底啦~" forState:MJRefreshStateNoMoreData];
    footer.refreshingTitleHidden    = YES;
    footer.stateLabel.font          = [UIFont systemFontOfSize:12];
    footer.stateLabel.textColor     = labNorColorFFFFFF;
    self.mj_footer = footer;
}
@end
