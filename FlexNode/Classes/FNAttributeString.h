//
//  FNAttributeString.h
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import <Foundation/Foundation.h>
#import "FNLine.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSAttributedString (FNAttributeString)
- (void)drawInContext:(CGContextRef)ctx;
@end

NS_ASSUME_NONNULL_END
