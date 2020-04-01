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
    NSMutableArray *currentElement;
    NSMutableArray *propertyElement;
    void (^callback)(NSError * _Nullable, FNFlexNode * _Nullable);
    NSInteger subNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        currentElement = [NSMutableArray new];
        propertyElement = [NSMutableArray new];
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
    if([elementName containsString:@"."]){ //属性节点切换
        id item = currentElement.firstObject;
        SEL call = [[item class] propertyNode:elementName];
        if(call != nil){
            [propertyElement addObject:NSStringFromSelector(call)];
        }else{
            [propertyElement addObject:@" "];
        }
        
    }else{ //普通节点
        Class cls = [self elementNameMapClass:elementName];
        id element = [cls nodeWithXMLAttribute:attributeDict];
        if(propertyElement.count > 0){
            [currentElement.lastObject performSelector:NSSelectorFromString(propertyElement.lastObject) withObject:element];
        }
        [currentElement addObject:element];
        if(!root){
            root = element;
        }
    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName containsString:@"."]){ //属性节点切换
        [propertyElement removeLastObject];
    }else{ //普通节点
        [currentElement removeLastObject];
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",parseError);
}

- (Class) elementNameMapClass:(NSString *)elementName{
    if([elementName isEqualToString:@"Node"]){
        return [FNFlexNode class];
    }
    if([elementName isEqualToString:@"Layer"]){
        return [CALayer class];
    }
    if([elementName isEqualToString:@"Text"]){
        return [CATextLayer class];
    }
    return NSClassFromString(elementName);
}
@end
