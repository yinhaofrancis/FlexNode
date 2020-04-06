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

+ (nullable SEL)propertyNode:(NSString *)name;


@end
@interface FNXMLParser : NSObject<NSXMLParserDelegate>
- (void)parseNode:(NSURL *)fileURL handle:(void (^)(NSError * e,id element))callback;
@end

@interface FNPropertyElement : NSObject
@property(nonatomic,strong) NSObject *object;
@property(nonatomic,assign) SEL entry;

@property(nonatomic,strong) NSMutableArray *propertyObjects;

@end

NS_ASSUME_NONNULL_END
