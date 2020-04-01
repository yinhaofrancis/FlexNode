//
//  FNXMLParser.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "FNXMLParser.h"
#import "FNFlexNode.h"
#import "CALayer+FlexXml.h"
@implementation FNXMLParser{
    FNFlexNode* root;
    NSMutableArray<FNFlexNode *> *currentNodes;
    void (^callback)(NSError * _Nullable, FNFlexNode * _Nullable);
    NSInteger subNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        currentNodes = [NSMutableArray new];
    }
    return self;
}
- (void)parseNode:(NSURL *)fileURL handle:(nonnull void (^)(NSError * _Nullable, FNFlexNode * _Nullable))callback{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    self->callback = callback;
    [parser parse];
}
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    callback(nil,root);
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if([elementName isEqualToString:@"Node"]){
        FNFlexNode* node = [FNFlexNode nodeWithXMLAttribute:attributeDict];
        if(root == nil){
            root = currentNodes.firstObject;
        }
        if(subNode){
            [currentNodes.lastObject addSubNode:node];
        }
        [currentNodes addObject:node];
    }
    if([elementName isEqualToString:@"SubNode"]){
        subNode += 1;
    }
    if ([elementName isEqualToString:@"Layer"]){
        CALayer* layer = [CALayer nodeWithXMLAttribute:attributeDict];
        [currentNodes.lastObject setContentLayer:layer];
    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName isEqualToString:@"Node"]){
        [currentNodes removeLastObject];
    }
    if([elementName isEqualToString:@"SubNode"]){
        subNode -= 1;
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",parseError);
}
@end
