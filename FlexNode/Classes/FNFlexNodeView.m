//
//  FNFlexNodeView.m
//  FlexNode
//
//  Created by hao yin on 2020/4/10.
//

#import "FNFlexNodeView.h"
#import "FNXMLParser.h"
@implementation FNFlexNodeView
- (void)layoutSubviews{
    [super layoutSubviews];
    self.node.width = self.frame.size.width;
    self.node.height = self.frame.size.height;
    [self.node layout];
}
- (void)setNode:(FNFlexNode *)node{
    _node  = node;
    [self addSubview:node.view];
    [self.layer addSublayer:node.layer];
    
}
- (void)setLayout:(NSString *)layout{
    _layout = layout;
    NSURL *url = [NSBundle.mainBundle URLForResource:layout withExtension:@"xml"];
    id root = [[[FNXMLParser alloc] init] parseUrl:url];
    [self setNode:root];
}
@end
