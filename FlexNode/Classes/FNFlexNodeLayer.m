//
//  FNFlexNodeLayer.m
//  FlexNode
//
//  Created by hao yin on 2020/3/29.
//

#import "FNFlexNodeLayer.h"

@implementation FNFlexNodeLayer
- (void)layoutSublayers {
    [self.node layout];
}
@end
