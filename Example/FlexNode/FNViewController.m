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
    self.node = [[FNFlexNode alloc] init];
    self.node.width = 1000;
    self.node.height = 1000;
    self.node.wrap = true;
    self.node.lineJustify = FNFlexLayoutJustifyTypeStretch;
    self.node.align = FNFlexLayoutAlignTypeStretch;
    
//    self.node.direction = FNFlexLayoutDirectionTypeCol;
    for (int i = 0; i < 2; i ++) {
        FNFlexNode * n = [[FNFlexNode alloc] init];
        [self.node addSubNode:n];
        n.width = 10;
//        n.height = 10;
        if(i == 0){
            n.grow = 1;
        }
//        for (int j = 0; j < 2; j ++) {
//            FNFlexNode * nn = [[FNFlexNode alloc] init];
//            [n addSubNode:nn];
//            nn.width = 10;
//            nn.height = 10;
//            if(i == 0){
//                nn.grow = 1;
//            }
//        }
    }
}

- (IBAction)change:(id)sender {
    [self.node layout];
    NSLog(@"%@",self.node);
}

@end
