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
    [[[FNXMLParser alloc] init] parseNode:[NSBundle.mainBundle URLForResource:@"string" withExtension:@"xml"] handle:^(NSError * _Nonnull e, NSAttributedString  * _Nonnull element) {
        self.CoreTextView.attributeString = element;
    }];
    
    
}
- (IBAction)change:(UISlider *)sender {

}

@end
