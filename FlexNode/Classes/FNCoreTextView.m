//
//  FNCoreTextView.m
//  FlexNode
//
//  Created by hao yin on 2020/4/4.
//

#import "FNCoreTextView.h"

@implementation FNCoreTextView{
    FNCoreTextLayer* content;
    UILayoutConstraintAxis axis;
}
@dynamic attributeString;

- (void)setAttributeString:(NSAttributedString *)attributeString{
    content.attributeString = attributeString;
    CGSize size;
    if(axis == UILayoutConstraintAxisHorizontal){
        size = [content FlexNodeContentSize:CGSizeMake(CGFLOAT_MAX, UIScreen.mainScreen.bounds.size.height)];
    }else{
        size = [content FlexNodeContentSize:CGSizeMake(UIScreen.mainScreen.bounds.size.width, CGFLOAT_MAX)];
    }
    self.contentSize = size;
    content.frame = CGRectMake(0, 0, size.width, size.height);
}

- (void)layoutSubviews{
    
}
- (NSAttributedString *)attributeString{
    return content.attributeString;
}

- (instancetype)initWithAxis:(UILayoutConstraintAxis)axis{
    self = [super init];
    if(self) {
        self->axis = axis;
        content = [[FNCoreTextLayer alloc] init];
        content.contentsScale = UIScreen.mainScreen.scale;
        [self.layer addSublayer:content];
    }
    return self;
}
- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        axis = UILayoutConstraintAxisVertical;
        content = [[FNCoreTextLayer alloc] init];
        content.contentsScale = UIScreen.mainScreen.scale;
        [self.layer addSublayer:content];
    }
    return self;
}
@end
