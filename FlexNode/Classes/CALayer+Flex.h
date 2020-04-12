//
//  CALayer+FlexXml.h
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import <QuartzCore/QuartzCore.h>
#import "FNFlexNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Flex)
- (CGSize)FlexNodeContentSize:(CGSize)constaintSize;
@end

@interface CATextLayer (Flex)
- (CGSize)FlexNodeContentSize:(CGSize)constaintSize;
@end


NS_ASSUME_NONNULL_END
