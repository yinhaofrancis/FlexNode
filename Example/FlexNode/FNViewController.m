//
//  FNViewController.m
//  FlexNode
//
//  Created by yinhaoFrancis on 03/28/2020.
//  Copyright (c) 2020 yinhaoFrancis. All rights reserved.
//

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNXMLParser.h"
#import "FNRunDelegate.h"
@interface FNViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FNCoreTextView *CoreTextView;

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSMutableAttributedString * a = [NSMutableAttributedString new];
    for (int i = 15; i < 96; i++) {
        NSAttributedString* atts = [[NSAttributedString alloc] initWithString:@"天道" attributes:@{
            NSFontAttributeName:[UIFont systemFontOfSize:i],
            NSForegroundColorAttributeName:UIColor.blackColor
        }];
        [a appendAttributedString:atts];
        FNRunDelegate *rund = [[FNRunDelegate alloc] initWithFont:[UIFont systemFontOfSize:i] withImage:[UIImage imageNamed:@"p"]];
    
        NSAttributedString* runda = [[NSAttributedString alloc] initWithRunDelegate:rund];
        [a appendAttributedString:runda];
        
        [a appendAttributedString:[NSAttributedString.alloc initWithString:@"\n"]];
    }
    self.CoreTextView.attributeString = a;
    
}
- (IBAction)change:(UISlider *)sender {

}

@end
