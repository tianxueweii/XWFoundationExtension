//
//  XWCollectionViewFlowLayout.h
//  Pods
//
//  Created by tianxuewei on 2019/1/28.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
 对齐方式
 
 - XWCollectionViewFlowLayoutItemsAlignDetault: 默认规则
 - XWCollectionViewFlowLayoutItemsAlignStart: 从头开始对齐
 - XWCollectionViewFlowLayoutItemsAlignCenter: 从中央对齐
 - XWCollectionViewFlowLayoutItemsAlignEnd: 从尾部开始对齐
 */
typedef NS_ENUM(NSUInteger, XWCollectionViewFlowLayoutItemsAlign) {
    XWCollectionViewFlowLayoutItemsAlignDetault = 0,
    XWCollectionViewFlowLayoutItemsAlignStart,
    XWCollectionViewFlowLayoutItemsAlignCenter,
    XWCollectionViewFlowLayoutItemsAlignEnd
};


@interface XWCollectionViewFlowLayout : UICollectionViewFlowLayout

/** 项目对齐方式 */
@property (nonatomic, assign) XWCollectionViewFlowLayoutItemsAlign xw_itemsAlign;

@end

NS_ASSUME_NONNULL_END
