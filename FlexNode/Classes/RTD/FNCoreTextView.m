//
//  FNCoreTextView.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNCoreTextView.h"
#import "FNLine.h"
@implementation FNCoreTextView{
    FNFrame * textFrame;
}

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

- (void)asyncLoadString{
    dispatch_async(dispatch_get_global_queue(QOS_CLASS_DEFAULT, 0), ^{
        if (self->textFrame) {
            CGImageRef img = [self->textFrame createCGImage];
            dispatch_async(dispatch_get_main_queue(), ^{
                self.layer.contents = (__bridge id _Nullable)(img);
                CGImageRelease(img);
            });
        }
    });
}

- (CGSize)intrinsicContentSize{
    return textFrame.frameSize;
}
- (void)setString:(NSAttributedString *)string{
    _string = string;
    if(self.estimatedSize.width != 0 || self.estimatedSize.height != 0){
        textFrame = [FNFrame createFrame:string size:self.estimatedSize];
        [self setNeedsDisplay];
    }
}
- (void)setEstimatedSize:(CGSize)estimatedSize{
    _estimatedSize = estimatedSize;
    if(self.string.length > 0){
        textFrame = [FNFrame createFrame:self.string size:self.estimatedSize];
        [self setNeedsDisplay];
    }
}
@end
