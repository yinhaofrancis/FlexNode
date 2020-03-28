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
    self.node = [[FNFlexNode alloc] initWithRenderMode:FNFlexFrameRenderModeDynamic];
    self.node.width = 200;
    self.node.backgroundColor = UIColor.blackColor;
    self.node.height = 400;
    [self.view addSubview:self.node.view];
    self.node.isWrap = true;
//    self.node.backgroundColor = UIColor.whiteColor;
    
    for (int i = 0; i < 10; i++) {
        UILabel* l = [[UILabel alloc] init];
        FNFlexNode* node  =  [[FNFlexNode alloc] initWithView:l];
        l.text = @"asdadad";
        l.textColor = UIColor.redColor;
        l.font = [UIFont systemFontOfSize:10 + i];
        
        [self.node addSubItem:node];
        
    }
    [self.node layout];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)change:(id)sender {
    self.node.width = 320;
    [UIView animateWithDuration:0.4 animations:^{
        [self.node layout];
    }];
}

@end
