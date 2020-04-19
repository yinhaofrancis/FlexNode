//
//  FNCoreTextView.h
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FNCoreTextView : UIView

@property(nonatomic,assign) IBInspectable CGSize estimatedSize;

@property(nonatomic,copy) IBInspectable NSAttributedString *string;

@end

NS_ASSUME_NONNULL_END
