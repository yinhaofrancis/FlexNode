//
//  FNFlexNodeView.h
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import <UIKit/UIKit.h>
#import "FNFlexNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNFlexNodeScrollView : UIScrollView
@property(nonatomic, strong) FNFlexNode *node;
@property(nonatomic, assign) UILayoutConstraintAxis direction;
@end

NS_ASSUME_NONNULL_END
