//
//  NSMutableAttributedString+FlexXml.h
//  FlexNode
//
//  Created by hao yin on 2020/4/2.
//

#import <Foundation/Foundation.h>
#import "FNXMLParser.h"
#import "FNFlexNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface NSMutableAttributedString (FlexXml)<FNXMLElement>

@end

@interface NSMutableParagraphStyle (FlexXml)<FNXMLElement>

@end

@interface NSShadow (FlexXml)<FNXMLElement>

@end

@interface UIFont (FlexXml)<FNXMLElement>

@end
NS_ASSUME_NONNULL_END
