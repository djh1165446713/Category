//
//  DHCollectViewFlowLayout.h
//  extensionCollectViewSeactionColor
//
//  Created by 杜建虎 on 2019/2/14.
//  Copyright © 2019 wooha. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DHCollectViewFlowLayoutDelegate<UICollectionViewDelegateFlowLayout>

- (UIColor *)collectView:(UICollectionView *)collectView layout:(UICollectionViewFlowLayout *)collectViewFlowLayout colorForSectionAtIndex:(NSInteger)section;

@end

@interface DHCollectViewFlowLayout : UICollectionViewFlowLayout

@end

