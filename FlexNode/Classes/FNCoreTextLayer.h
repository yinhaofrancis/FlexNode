//
//  FNCoreTextLayer.h
//  FlexNode
//
//  Created by hao yin on 2020/4/4.
//

#import <QuartzCore/QuartzCore.h>
#import "FNXMLParser.h"
#import "FNFlexNode.h"
NS_ASSUME_NONNULL_BEGIN

@interface FNCoreTextLayer : CALayer<FNXMLElement,FNFlexNodeContentProtocol>
@property (nonatomic, strong) NSAttributedString *attributeString;
@property (nonatomic, assign) CGSize constraintSize;
@end

NS_ASSUME_NONNULL_END
