//
//  XWCollectionViewFlowLayout.m
//  Pods
//
//  Created by tianxuewei on 2019/1/28.
//

#import "XWCollectionViewFlowLayout.h"

@implementation XWCollectionViewFlowLayout

- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect {
    NSArray * layoutAttributes = [super layoutAttributesForElementsInRect:rect];
    // 一行/一列items数组
    NSMutableArray * lineLayoutAttributes = [[NSMutableArray alloc] init];
    // 一行/一列items宽度/高度
    CGFloat lineSumSize = 0;
    
    for (NSUInteger i = 0; i < layoutAttributes.count ; i ++) {
        //当前cell位置
        UICollectionViewLayoutAttributes *currentAttr = layoutAttributes[i];
        //上一个cell位置
        UICollectionViewLayoutAttributes *previousAttr = (i == 0 ? nil : layoutAttributes[i-1]);
        //下一个cell位置
        UICollectionViewLayoutAttributes *nextAttr = (i + 1 == layoutAttributes.count ? nil : layoutAttributes[i+1]);
        
        //加入临时数组
        [lineLayoutAttributes addObject:currentAttr];
        
        CGFloat currentFrame, previousFrame, nextFrame;
        
        switch (self.scrollDirection) {
            case UICollectionViewScrollDirectionVertical:{
                currentFrame = CGRectGetMaxY(currentAttr.frame);
                previousFrame = previousAttr ? CGRectGetMaxY(previousAttr.frame) : -1;
                nextFrame = nextAttr ? CGRectGetMaxY(nextAttr.frame) : -1;
                break;
            }
            case UICollectionViewScrollDirectionHorizontal:{
                currentFrame = CGRectGetMaxX(currentAttr.frame);
                previousFrame = previousAttr ? CGRectGetMaxX(previousAttr.frame) : -1;
                nextFrame = nextAttr ? CGRectGetMaxX(nextAttr.frame) : -1;
                break;
            }
        }
        
        lineSumSize += (self.scrollDirection == UICollectionViewScrollDirectionVertical ? currentAttr.frame.size.width : currentAttr.frame.size.height);
        //如果当前cell是单独一行
        if (currentFrame != previousFrame && currentFrame != nextFrame){
            if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionHeader]) {
                lineSumSize = 0.0;
                [lineLayoutAttributes removeAllObjects];
            } else if ([currentAttr.representedElementKind isEqualToString:UICollectionElementKindSectionFooter]){
                lineSumSize = 0.0;
                [lineLayoutAttributes removeAllObjects];
            } else {
                [self resetALineAttributes:lineLayoutAttributes sumSize:lineSumSize];
                lineSumSize = 0.0;
                [lineLayoutAttributes removeAllObjects];
            }
        }
        //如果下一个cell在本行，这开始调整Frame位置
        else if (currentFrame != nextFrame) {
            [self resetALineAttributes:lineLayoutAttributes sumSize:lineSumSize];
            lineSumSize = 0.0;
            [lineLayoutAttributes removeAllObjects];
        }
    }
    return layoutAttributes;
}

//调整属于同一行的cell的位置frame
- (void)resetALineAttributes:(NSMutableArray *)layoutAttributes sumSize:(CGFloat)sumSize{
    
    CGFloat nowSize = 0.0;
    CGFloat collectionWidth = self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.collectionView.frame.size.width : self.collectionView.frame.size.height;
    CGFloat minimumSpacing = self.scrollDirection == UICollectionViewScrollDirectionVertical ? self.minimumInteritemSpacing : self.minimumLineSpacing;
    
    switch (self.xw_itemsAlign) {
        case XWCollectionViewFlowLayoutItemsAlignDetault: break;
        case XWCollectionViewFlowLayoutItemsAlignStart:{
            nowSize = self.scrollDirection == UICollectionViewScrollDirectionVertical
            ? self.sectionInset.left
            : self.sectionInset.top;
            
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    nowFrame.origin.x = nowSize;
                    nowSize += nowFrame.size.width + minimumSpacing;
                } else {
                    nowFrame.origin.y = nowSize;
                    nowSize += nowFrame.size.height + minimumSpacing;
                }
                attributes.frame = nowFrame;
            }
            break;
        }
            
        case XWCollectionViewFlowLayoutItemsAlignCenter:{
            nowSize = (collectionWidth - sumSize - ((layoutAttributes.count - 1) * minimumSpacing)) / 2;
            
            for (UICollectionViewLayoutAttributes * attributes in layoutAttributes) {
                CGRect nowFrame = attributes.frame;
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    nowFrame.origin.x = nowSize;
                    nowSize += nowFrame.size.width + minimumSpacing;
                } else {
                    nowFrame.origin.y = nowSize;
                    nowSize += nowFrame.size.height + minimumSpacing;
                }
                attributes.frame = nowFrame;
            }
            break;
        }
            
        case XWCollectionViewFlowLayoutItemsAlignEnd:
            nowSize = self.scrollDirection == UICollectionViewScrollDirectionVertical
            ? self.collectionView.frame.size.width - self.sectionInset.right
            : self.collectionView.frame.size.height - self.sectionInset.bottom;
            
            for (NSInteger i = layoutAttributes.count - 1 ; i >= 0 ; i--) {
                UICollectionViewLayoutAttributes * attributes = layoutAttributes[i];
                CGRect nowFrame = attributes.frame;
                if (self.scrollDirection == UICollectionViewScrollDirectionVertical) {
                    nowFrame.origin.x = nowSize - nowFrame.size.width;
                    nowSize = nowSize - nowFrame.size.width - minimumSpacing;
                } else {
                    nowFrame.origin.y = nowSize - nowFrame.size.height;
                    nowSize = nowSize - nowFrame.size.height - minimumSpacing;
                }
                attributes.frame = nowFrame;
            }
            break;
    }
}

@end
