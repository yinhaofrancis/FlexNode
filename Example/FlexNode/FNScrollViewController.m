//
//  FNScrollViewController.m
//  FlexNode_Example
//
//  Created by hao yin on 2020/4/1.
//  Copyright © 2020 yinhaoFrancis. All rights reserved.
//

#import "FNScrollViewController.h"

@interface FNScrollViewController ()

@end

@implementation FNScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nodeView.node.wrap = true;
    self.nodeView.node.width = self.view.frame.size.width;
    self.nodeView.node.direction = FNFlexLayoutDirectionTypeCol;
    
    for (int i = 0; i < 50; i++) {
        
        FNFlexNode * content =  [[FNFlexNode alloc] initWithLayer:CALayer.new];
        content.height = 64;
        content.align = FNFlexLayoutAlignTypeFlexCenter;
        
        FNFlexNode* node = [[FNFlexNode alloc] initWithImage:[UIImage imageNamed:@"p"]];
        [content addSubNode:node];
        node.margin = UIEdgeInsetsMake(0, 20, 0, 0);
        FNFlexNode* node2 = [[FNFlexNode alloc] initWithAttributeString:[NSAttributedString.alloc initWithString:@"dddd" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:22],
            NSForegroundColorAttributeName:UIColor.redColor
        }]size:CGSizeMake(128, CGFLOAT_MAX)];
        node2.grow = 1;
        node2.margin = UIEdgeInsetsMake(0, 20, 0, 20);
        
        [content addSubNode:node2];
        
        
        FNFlexNode* node3 = [[FNFlexNode alloc] initWithImage:[UIImage imageNamed:@"p"]];
        [content addSubNode:node3];
        node3.margin = UIEdgeInsetsMake(0, 0, 0, 20);
        [self.nodeView.node addSubNode:content];
    }
}

@end
