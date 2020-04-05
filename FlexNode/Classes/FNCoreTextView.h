//
//  FNCoreTextView.h
//  FlexNode
//
//  Created by hao yin on 2020/4/4.
//

#import <UIKit/UIKit.h>
#import "FNCoreTextLayer.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCoreTextView : UIScrollView
@property (nonatomic,copy)NSAttributedString *attributeString;
@property (nonatomic,assign) IBInspectable CGFloat constraint;
- (instancetype)initWithAxis:(UILayoutConstraintAxis)axis;
@end

NS_ASSUME_NONNULL_END
