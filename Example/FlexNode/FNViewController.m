//
//  FNViewController.m
//  FlexNode
//
//  Created by yinhaoFrancis on 03/28/2020.
//  Copyright (c) 2020 yinhaoFrancis. All rights reserved.
//

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNXMLParser.h"
@interface FNViewController ()
@property (nonnull,nonatomic) FNFlexNode *node;
@property (nonatomic,strong) FNXMLParser* parser;
@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.parser = [[FNXMLParser alloc] init];
    __weak FNViewController* wself = self;
    [self.parser parseNode:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"xml"] handle:^(NSError * _Nonnull e, FNFlexNode * _Nonnull node) {
        wself.node = node;
        [wself.view.layer addSublayer:node.layer];
        node.x = 200;
        node.y = 123;
        [wself.node layout];
    }];
}

- (IBAction)change:(UISlider *)sender {
    [[self.node findNodeByName:@"sub"] enumerateObjectsUsingBlock:^(FNFlexNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.width = sender.value;
        obj.wrap = true;
    }];
    [[self.node findNodeByName:@"seed"] enumerateObjectsUsingBlock:^(FNFlexNode * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        obj.width = sender.value / 3;
        obj.height = sender.value / 3;
    }];
    [self.node layout];
}

@end
