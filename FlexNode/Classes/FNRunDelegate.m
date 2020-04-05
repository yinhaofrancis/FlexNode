//
//  FNRunDelegate.m
//  FlexNode
//
//  Created by hao yin on 2020/4/5.
//

#import "FNRunDelegate.h"
#import <CoreText/CoreText.h>

NSString * const FNRunDelegateKey = @"FNRunDelegateKey";

CGFloat FunctionCTRunDelegateGetAscentCallback(void * refCon){
    FNRunDelegate * run = (__bridge FNRunDelegate *)(refCon);
    return run.ascent;
}
CGFloat FunctionCTRunDelegateGetWidthCallback(void * refCon){
    FNRunDelegate * run = (__bridge FNRunDelegate *)(refCon);
    return run.width;
}
CGFloat FunctionCTRunDelegateGetDescentCallback(void * refCon){
    FNRunDelegate * run = (__bridge FNRunDelegate *)(refCon);
    return run.descent;
}
void FunctionCTRunDelegateDeallocCallback(void * refCon){

}

@implementation FNRunDelegate
- (instancetype)initWithFont:(UIFont *)font{
    self = [super init];
    if(self) {
        self.width = font.pointSize;
        self.ascent = font.ascender;
        self.descent = -font.descender;
    }
    return self;
}
- (instancetype)initWithFont:(UIFont *)font withImage:(UIImage *)image{
    self = [self initWithFont:font];
    if (self){
        self.image = image;
    }
    return self;
}
- (void)draw:(CGContextRef)ctx rect:(CGRect)rect{
    if(self.image){
        CGFloat imageRatio = rect.size.width / self.image.size.width;
        CGFloat h = self.image.size.height * imageRatio;
        CGFloat y = (rect.size.height - h) / 2;
        CGRect drawRect = CGRectMake(rect.origin.x, rect.origin.y + y, rect.size.width, h);
        CGContextDrawImage(ctx, drawRect, self.image.CGImage);
    }
}
@end

@implementation NSAttributedString (FNRunDelegate)

- (instancetype)initWithRunDelegate:(FNRunDelegate *)runDelegate{
    CTRunDelegateCallbacks callback = [self createCallback];
    CTRunDelegateRef run = CTRunDelegateCreate(&callback, (__bridge void * _Nullable)(runDelegate));
    self = [self.class.alloc initWithString:@"A" attributes:@{
        (NSString *)kCTRunDelegateAttributeName:(__bridge id)run,
        FNRunDelegateKey:runDelegate,
        NSForegroundColorAttributeName:[UIColor clearColor]
    }];
    if(self) {
        
    }
    return self;
}
- (CTRunDelegateCallbacks) createCallback{
    CTRunDelegateCallbacks callback;
    callback.version = kCTRunDelegateCurrentVersion;
    callback.getDescent = FunctionCTRunDelegateGetDescentCallback;
    callback.getAscent = FunctionCTRunDelegateGetAscentCallback;
    callback.getWidth = FunctionCTRunDelegateGetWidthCallback;
    callback.dealloc = FunctionCTRunDelegateDeallocCallback;
    return callback;
}


@end


