//
//  FNXMLParser.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "FNXMLParser.h"
#import "FNFlexNode.h"
#import "CALayer+FlexXml.h"
#import "FNCoreTextLayer.h"
@implementation FNXMLParser{
    FNFlexNode* _Nullable root;
    NSMutableArray *currentElement;
    void (^callback)(NSError * _Nullable, FNFlexNode * _Nullable);
    NSInteger subNode;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        currentElement = [NSMutableArray new];
    }
    return self;
}
- (void)parseNode:(NSURL *)fileURL handle:(void (^)(NSError * _Nullable, id _Nullable))callback{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    self->callback = callback;
    [parser parse];
}
- (id)parse:(NSString *)code{
    NSData *data = [code dataUsingEncoding:NSUTF8StringEncoding];
    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
    parser.delegate = self;
    BOOL succes = [parser parse];
    if(succes){
        id re = root;
        root = nil;
        return re;
    }
    return nil;
}
- (id)parseUrl:(NSURL *)fileURL{
    NSXMLParser* parser = [[NSXMLParser alloc] initWithContentsOfURL:fileURL];
    parser.delegate = self;
    BOOL succes = [parser parse];
    if(succes){
        id re = root;
        root = nil;
        return re;
    }
    return nil;
}
- (void)parserDidStartDocument:(NSXMLParser *)parser {
    
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if(callback){
        callback(nil,root);
        root = nil;
    }
    [currentElement removeAllObjects];
    
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    if([elementName containsString:@"."]){ //属性节点切换
        id owned;
        if([currentElement.lastObject isKindOfClass:FNPropertyElement.class]){
            owned = ((FNPropertyElement *)currentElement.lastObject).propertyObjects.lastObject;
        }else{
            owned = currentElement.lastObject;
        }
        FNPropertyElement* property = [[FNPropertyElement alloc] init];
        property.object = owned;
        property.entry = [[owned class] propertyNode:elementName];
        [currentElement addObject:property];
    }else{ //普通节点
        Class cls = [self elementNameMapClass:elementName];
        id element = [cls nodeWithXMLAttribute:attributeDict];
        if([currentElement.lastObject isKindOfClass:FNPropertyElement.class]){
            [((FNPropertyElement *)currentElement.lastObject).propertyObjects addObject:element];
        }else{
            [currentElement addObject:element];
        }
        
        if(!root){
            root = element;
        }
    }
    
    
}
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    if([elementName containsString:@"."]){ //属性节点切
        FNPropertyElement* e = currentElement.lastObject;
        for (id obj in e.propertyObjects) {
            IMP imp = [e.object methodForSelector:e.entry];
            void(*func)(id,void *,id) = (void*)imp;
            func(e.object,imp,obj);
        }
        [currentElement removeLastObject];
    }else{ //普通节点
//        if(![currentElement.lastObject isKindOfClass:FNPropertyElement.class]){
//            
//        }
    }
}
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    NSLog(@"%@",parseError);
    root = nil;
    [currentElement removeAllObjects];
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
    if([elementName isEqualToString:@"AttributeString"]){
        return [NSMutableAttributedString class];
    }
    if([elementName isEqualToString:@"Shadow"]){
        return [NSShadow class];
    }
    if([elementName isEqualToString:@"ParagraphStyle"]){
        return [NSMutableParagraphStyle class];
    }
    if([elementName isEqualToString:@"CoreText"]){
        return [FNCoreTextLayer class];
    }
    if([elementName isEqualToString:@"Font"]){
        return [UIFont class];
    }
    return NSClassFromString(elementName);
}
@end

@implementation FNPropertyElement

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.propertyObjects = [NSMutableArray new];
        
    }
    return self;
}

@end
