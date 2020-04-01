//
//  FNXMLParser.h
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import <Foundation/Foundation.h>
@class FNFlexNode;
NS_ASSUME_NONNULL_BEGIN
@protocol FNXMLElement <NSObject>

+ (instancetype)nodeWithXMLAttribute:(NSDictionary<NSString *,NSString *> *)attribute;

+ (SEL)propertyNode:(NSString *)name;

@end
@interface FNXMLParser : NSObject<NSXMLParserDelegate>
- (void)parseNode:(NSURL *)fileURL handle:(void (^)(NSError * e,FNFlexNode *node))callback;
@end

NS_ASSUME_NONNULL_END
