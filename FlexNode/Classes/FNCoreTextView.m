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
    CGRect last;
}
@dynamic attributeString;

- (void)setAttributeString:(NSAttributedString *)attributeString{
    content.attributeString = attributeString;
}

- (void)layoutSubviews{
    if(!CGRectEqualToRect(self.frame, last)){
        last = self.frame;
        CGSize size;
        if(axis == UILayoutConstraintAxisHorizontal){
            size = [content FlexNodeContentSize:CGSizeMake(CGFLOAT_MAX, self.constraint == 0 ? self.frame.size.height : self.constraint)];
        }else{
            size = [content FlexNodeContentSize:CGSizeMake(self.constraint == 0 ? self.frame.size.width : self.constraint, CGFLOAT_MAX)];
        }
        self.contentSize = size;
        content.frame = CGRectMake(0, 0, size.width, size.height);
    }
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
