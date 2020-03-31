//
//  FNViewController.m
//  FlexNode
//
//  Created by yinhaoFrancis on 03/28/2020.
//  Copyright (c) 2020 yinhaoFrancis. All rights reserved.
//

#import "FNViewController.h"
#import <FNFlexNode.h>
@interface FNViewController ()
@property (nonnull,nonatomic) FNFlexNode *node;
@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.node = [[FNFlexNode alloc] initWithView:[UIView new]];
    self.node.width = 600;
    self.node.height = 500;
    self.node.x = 10;
    self.node.y = 20;
    self.node.wrap = true;
    self.node.lineJustify = FNFlexLayoutJustifyTypeStretch;
    [self.view addSubview:self.node.view];
    self.node.align = FNFlexLayoutAlignTypeStretch;
//    self.node.direction = FNFlexLayoutDirectionTypeCol;
    for (int i = 0; i < 4; i ++) {
        CALayer * v = [CALayer new];
//        v.borderColor = UIColor.redColor.CGColor;
//        v.borderWidth = 2;
        v.backgroundColor = [[UIColor alloc] initWithRed:0.25 * i green:1 blue:1 alpha:1].CGColor;
        FNFlexNode * n = [[FNFlexNode alloc] initWithLayer:v];
        [self.node addSubNode:n];
        n.justify = FNFlexLayoutJustifyTypeSpaceEvenly;
        n.align = FNFlexLayoutAlignTypeStretch;
        n.lineJustify = FNFlexLayoutJustifyTypeFlexCenter;
        n.width = 300;
        n.direction = FNFlexLayoutDirectionTypeCol;
//        n.height = 200;
        for (int j = 0; j < 2; j ++) {
            if(i < 2){
                FNFlexNode* node = [[FNFlexNode alloc] initWithAttributeString:[NSAttributedString.alloc initWithString:@"adandas快捷的方式简单是对方开始绝代风华深刻的肌肤瞬间地方的肌肤来说地方了ansdkja sd" attributes:@{
                    NSFontAttributeName:[UIFont systemFontOfSize:16],
                    NSForegroundColorAttributeName:UIColor.blackColor
                }] size:CGSizeMake(128, CGFLOAT_MAX)];
                [n addSubNode:node];
            }else{
                FNFlexNode* node = [[FNFlexNode alloc] initWithImage:[UIImage imageNamed:@"p"]];
                [n addSubNode:node];
            }
        }
    }
}

- (IBAction)change:(id)sender {
    [self.node layout];
    self.node.width = 1000;
    self.node.align = FNFlexLayoutAlignTypeFlexCenter;
    self.node.justify = FNFlexLayoutJustifyTypeFlexCenter;
}

@end
