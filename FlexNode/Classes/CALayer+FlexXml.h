//
//  CALayer+FlexXml.h
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import <QuartzCore/QuartzCore.h>
#import "FNXMLParser.h"
NS_ASSUME_NONNULL_BEGIN

@interface CALayer (FlexXml)<FNXMLElement>

@end

@interface UIColor (FlexXml)
- (instancetype)initWithHex:(uint32_t)hexColor;
@end

@interface UIImage (FlexXml)
+ (instancetype)imageWithXmlValue:(NSString *)imageValue;
@end

NS_ASSUME_NONNULL_END
