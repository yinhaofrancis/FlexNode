//
//  FNFlexNodeView.m
//  FlexNode
//
//  Created by hao yin on 2020/4/1.
//

#import "FNFlexNodeScrollView.h"

@implementation FNFlexNodeScrollView
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        self.node = [[FNFlexNode alloc] initWithView:UIView.new];
        [self addSubview:self.node.view];
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    [self.node layout];
    self.contentSize = CGSizeMake(self.node.width, self.node.height);
}

@end
