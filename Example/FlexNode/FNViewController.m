//
//  FNViewController.m
//  FlexNode
//
//  Created by yinhaoFrancis on 03/28/2020.
//  Copyright (c) 2020 yinhaoFrancis. All rights reserved.
//

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextLayer.h"
#import "FNXMLParser.h"
@interface FNViewController ()<UITextFieldDelegate>
@property (nonnull,nonatomic) FNFlexNode *node;
@property (weak, nonatomic) IBOutlet UITextField *tf;
@property (nonatomic,strong) FNXMLParser* parser;
@end

@implementation FNViewController

- (void)viewDidLoad
{
    self.tf.delegate = self;
    [super viewDidLoad];
    
    self.parser = [[FNXMLParser alloc] init];
    __weak FNViewController* wself = self;
    [self.parser parseNode:[NSBundle.mainBundle URLForResource:@"layout" withExtension:@"xml"] handle:^(NSError * _Nonnull e, id _Nonnull node) {
        wself.node = node;
        [wself.view.layer addSublayer:wself.node.layer];
        wself.node.x = 20;
        wself.node.y = 123;
        [wself.node layout];
    }];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    CATextLayer *l =  [[self.node findlayerByName:@"cc"] firstObject];
//    NSAttributedString* a = [[NSAttributedString alloc] initWithString:[textField.text stringByAppendingString:string] attributes:@{
//        NSForegroundColorAttributeName:UIColor.whiteColor,
//        NSFontAttributeName:[UIFont systemFontOfSize:28]
//    }];
    l.string = textField.text;
    [self.node layout];
    return true;
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
