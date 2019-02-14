//
//  DHCollectViewFlowLayout.m
//  extensionCollectViewSeactionColor
//
//  Created by 杜建虎 on 2019/2/14.
//  Copyright © 2019 wooha. All rights reserved.
//

#import "DHCollectViewFlowLayout.h"

static NSString *const DHCollectViewSectionColor = @"https://github.com/djh1165446713";

@interface DHCollectViewLayoutAttributes: UICollectionViewLayoutAttributes
// 背景色
@property(nonatomic,strong)UIColor *backgroudColor;

@end

@implementation DHCollectViewLayoutAttributes


@end


@interface DhCollectionReusableView : UICollectionReusableView

@end

@implementation DhCollectionReusableView

- (void)applyLayoutAttributes:(UICollectionViewLayoutAttributes *)layoutAttributes{
    [super applyLayoutAttributes:layoutAttributes];
    DHCollectViewLayoutAttributes *attr = (DHCollectViewLayoutAttributes *)layoutAttributes;
    self.backgroundColor = attr.backgroudColor;
}

@end


@interface DHCollectViewFlowLayout()
@property(nonatomic,strong)UIColor *sectionColor;
@property(nonatomic,strong)NSMutableArray<UICollectionViewLayoutAttributes *> *decorationViewAttrs;
@end

@implementation DHCollectViewFlowLayout


- (void)prepareLayout{
    [super prepareLayout];
    NSInteger sections = [self.collectionView numberOfSections];
    id<DHCollectViewFlowLayoutDelegate> delegate = self.collectionView.delegate;
    if (![delegate respondsToSelector:@selector(collectView:layout:colorForSectionAtIndex:)]) {
        return;
    }
    
    // 初始化
    [self registerClass:[DhCollectionReusableView class] forDecorationViewOfKind:DHCollectViewSectionColor];
    [self.decorationViewAttrs removeAllObjects];
    
    for (int section = 0; section < sections; section++) {
        NSInteger numberOfItems = [self.collectionView numberOfItemsInSection:section];
        if (numberOfItems > 0) {
            UICollectionViewLayoutAttributes *fristAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            UICollectionViewLayoutAttributes *lastAttr = [self layoutAttributesForItemAtIndexPath:[NSIndexPath indexPathForRow:numberOfItems - 1 inSection:section]];
            
            UIEdgeInsets sectionInset = self.sectionInset;
            if ([delegate respondsToSelector:@selector(collectionView:layout:insetForSectionAtIndex:)]) {
                UIEdgeInsets inset = [delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:section];
                if (!UIEdgeInsetsEqualToEdgeInsets(inset, sectionInset)) {
                    sectionInset = inset;
                }
            }
            
            CGRect sectionFrame = CGRectUnion(fristAttr.frame, lastAttr.frame);
            sectionFrame.origin.x -= sectionInset.left;
            sectionFrame.origin.y -= sectionInset.top;
            if (self.scrollDirection == UICollectionViewScrollDirectionHorizontal) {
                sectionFrame.size.width += sectionInset.left + sectionInset.right;
                sectionFrame.size.height = self.collectionView.frame.size.height;
            }else{
                sectionFrame.size.width = self.collectionView.frame.size.width;
                sectionFrame.size.height += sectionInset.top + sectionInset.bottom;
            }
            
            // 定义
            DHCollectViewLayoutAttributes *attr = [DHCollectViewLayoutAttributes layoutAttributesForDecorationViewOfKind:DHCollectViewSectionColor withIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
            attr.frame = sectionFrame;
            attr.zIndex = -1;
            attr.backgroudColor = [delegate collectView:self.collectionView layout:self colorForSectionAtIndex:section];
        }else{
            continue;
        }
    }
}

- (NSMutableArray<UICollectionViewLayoutAttributes *> *)decorationViewAttrs{
    if (!_decorationViewAttrs) {
        _decorationViewAttrs = [NSMutableArray array];
    }
    return _decorationViewAttrs;
}
@end
