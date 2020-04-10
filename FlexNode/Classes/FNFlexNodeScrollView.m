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
        self.direction = -1;
    }
    return self;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    if(self.direction == UILayoutConstraintAxisVertical){
        self.node.width = self.frame.size.width;
    }else if (self.direction == UILayoutConstraintAxisHorizontal){
        self.node.height = self.frame.size.height;
    }else{
        
    }
    [self.node layout];
    self.contentSize = CGSizeMake(self.node.width, self.node.height);
    
}

@end
