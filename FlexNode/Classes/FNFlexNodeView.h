//
//  FNFlexNodeView.h
//  FlexNode
//
//  Created by hao yin on 2020/4/10.
//

#import <UIKit/UIKit.h>
#import "FNFlexNode.h"
NS_ASSUME_NONNULL_BEGIN
@interface FNFlexNodeView : UIView
@property(nonatomic,strong) FNFlexNode *node;
@property(nonatomic,copy) IBInspectable NSString *layout;
@end

NS_ASSUME_NONNULL_END
