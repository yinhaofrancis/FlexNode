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
    self.node.width = 200;
    self.node.height = 1000;
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
        n.align = FNFlexLayoutAlignTypeFlexCenter;
        n.lineJustify = FNFlexLayoutJustifyTypeStretch;
        n.width = 100;
        for (int j = 0; j < 2; j ++) {
            CALayer * vd = [CALayer new];
            vd.borderWidth = 1;
            vd.backgroundColor = [[UIColor alloc] initWithRed:1 green:0.25 * i blue:0.25 * j alpha:1].CGColor;
            FNFlexNode * nn = [[FNFlexNode alloc] initWithLayer:vd];
            [n addSubNode:nn];
            nn.width = 20;
            nn.height = 20;
            if(j == 0){
                nn.grow = 1;
            }
          
        }
    }
}

- (IBAction)change:(id)sender {
    [self.node layout];
}

@end
