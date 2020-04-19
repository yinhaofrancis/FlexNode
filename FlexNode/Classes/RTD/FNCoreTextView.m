//
//  FNCoreTextView.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNCoreTextView.h"
#import "FNAttributeString.h"
@implementation FNCoreTextView

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.estimatedSize = CGSizeZero;
    }
    return self;
}

- (CGSize)intrinsicContentSize{
    CGSize esSize = CGSizeMake(self.estimatedSize.width ? self.estimatedSize.width : CGFLOAT_MAX, self.estimatedSize.height ? self.estimatedSize.height : CGFLOAT_MAX);
    return [self.string contentSize:esSize];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self asyncLoadString];
}

- (void)asyncLoadString{
    CGRect rect = self.bounds;
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        CGImageRef img = [self.string createImageInRect:rect];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.layer.contents = (__bridge id _Nullable)(img);
            CGImageRelease(img);
        });
    });
}
@end
