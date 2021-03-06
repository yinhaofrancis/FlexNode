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
        _originText = @"-";
    }
    return self;
}
- (instancetype)initWithSize:(CGSize)size withImage:(UIImage *)image{
    return [self initWithSize:size margin:UIEdgeInsetsZero withImage:image];
}
- (instancetype)initwithImage:(UIImage *)image{
    return [self initWithSize:image.size margin:UIEdgeInsetsZero withImage:image];
}
- (instancetype)initWithSize:(CGSize)size
                      margin:(UIEdgeInsets)margin
                   withImage:(UIImage *)image{
    self = [super init];
    if(self) {
        self.width = size.width + margin.left + margin.right;
        self.ascent = (size.height + margin.top + margin.bottom) / 2;
        self.descent = self.ascent;
        _margin = margin;
        _image = image;
        _originText = @"-";
    }
    return self;
}
- (instancetype)initWithFont:(UIFont *)font withImage:(UIImage *)image{
    self = [self initWithFont:font];
    if (self){
        _image = image;
        _originText = @"-";
    }
    return self;
}

- (instancetype)initWithAttributeString:(NSAttributedString *)attribute{
    return [self initWithSize:CGSizeMake(CGFLOAT_MAX, CGFLOAT_MAX)
                       margin:UIEdgeInsetsZero
          WithAttributeString:attribute];
}

-(instancetype)initWithSize:(CGSize)size
        WithAttributeString:(NSAttributedString *)attribute{
    return [self initWithSize:size
                       margin:UIEdgeInsetsZero
          WithAttributeString:attribute];
}
- (instancetype)initWithSize:(CGSize)size
                      margin:(UIEdgeInsets)margin
         WithAttributeString:(NSAttributedString *)attribute{
    self = [super init];
    if(self) {
        self.frame = [FNFrame createFrame:attribute size:size];
        size = self.frame.frameSize;
        _attributedString = attribute;
        _margin = margin;
        self.width = size.width + margin.left + margin.right;
        self.ascent = size.height + margin.top + margin.bottom;
        self.descent = 0;
        _originText = @"-";
    }
    return self;
}

- (instancetype)initWithEmptyLine:(CGFloat)height{
    self = [super init];
    if(self){
        self.ascent = height;
        self.width = CGFLOAT_MAX;
        _isEmpty = true;
        _originText = @"-";
    }
    return self;
}

- (void)draw:(CGContextRef)ctx rect:(CGRect)rect containerSize:(CGSize)containerSize{
    CGContextSaveGState(ctx);
    rect = CGRectMake(
                      rect.origin.x + self.margin.left,
                      rect.origin.y + self.margin.bottom,
                      rect.size.width - self.margin.left - self.margin.right,
                      rect.size.height - self.margin.top - self.margin.bottom);
    rect = [self calcJustify:rect containerSize:containerSize];
    if(self.isDynamicDisplay){
        CGRect vrect = [self viewFrameFromContextFrame:rect WithContainer:containerSize];
        dispatch_async(dispatch_get_main_queue(), ^{
            if(self.display && self.frame.displayView){
                UIView * v = [self.display runDelegateView];
                [self.frame.displayView addSubview: v];
                v.frame = vrect;
            }
        });
    }else if(self.image){
        CGFloat imageRatio = rect.size.width / self.image.size.width;
        CGFloat h = self.image.size.height * imageRatio;
        CGFloat y = (rect.size.height - h) / 2;
        CGRect drawRect = CGRectMake(rect.origin.x, rect.origin.y + y, rect.size.width, h);
        CGContextDrawImage(ctx, drawRect, self.image.CGImage);
    }else if (self.attributedString){
        CGRect drawRect = rect;
        CGLayerRef layer = [self.frame createLayerInContext:ctx];
        CGContextDrawLayerInRect(ctx, drawRect, layer);
        CGLayerRelease(layer);
    }
    CGContextRestoreGState(ctx);
}
- (CGRect)calcJustify:(CGRect)rect containerSize:(CGSize)size{
    CGFloat delta = (size.width - self.line.frame.size.width);
    
    switch (self.justify) {
            
        case FNRunDelegateJustifyStart:
            delta = 0;
            return rect;
        case FNRunDelegateJustifyCenter:
            delta = delta / 2.0;
            return CGRectMake(rect.origin.x + delta, rect.origin.y, rect.size.width, rect.size.height);
        case FNRunDelegateJustifyEnd:
            delta = delta;
            return CGRectMake(rect.origin.x + delta, rect.origin.y, rect.size.width, rect.size.height);
        case FNRunDelegateJustifyEvenly:
            delta = delta / (self.line.countOfRun + 1);
            return CGRectMake(rect.origin.x + delta * (self.run.index + 1), rect.origin.y, rect.size.width, rect.size.height);
            break;
        case FNRunDelegateJustifyAround:
            delta = delta / (self.line.countOfRun * 2);
            return CGRectMake(rect.origin.x + delta * (self.run.index + 1) + (self.run.index * delta), rect.origin.y, rect.size.width, rect.size.height);
            break;
        case FNRunDelegateJustifyBetween:{
            delta = self.line.countOfRun > 1 ? (delta / (self.line.countOfRun - 1)) : 0;
            return CGRectMake(rect.origin.x + delta * (self.run.index), rect.origin.y, rect.size.width, rect.size.height);
        }
    }
    
}
- (CGRect)viewFrameFromContextFrame:(CGRect)rect WithContainer:(CGSize)containerSize{
    CGFloat y = containerSize.height - rect.origin.y - rect.size.height;
    CGRect r = CGRectMake(rect.origin.x, y, rect.size.width, rect.size.height);
    return r;
}
@end

@implementation NSAttributedString (FNRunDelegate)

- (instancetype)initWithRunDelegate:(FNRunDelegate *)runDelegate{
    CTRunDelegateCallbacks callback = [self createCallback];
    CTRunDelegateRef run = CTRunDelegateCreate(&callback, (__bridge void * _Nullable)(runDelegate));
    return [self initWithRunDelegate:runDelegate attribute:@{
            (NSString *)kCTRunDelegateAttributeName:(__bridge id)run,
                                FNRunDelegateKey:runDelegate,
            NSFontAttributeName:[UIFont systemFontOfSize:0.01],
                     NSForegroundColorAttributeName:[UIColor clearColor]
    }];
}

- (instancetype)initWithRunDelegate:(FNRunDelegate *)runDelegate
                          attribute:(nullable NSDictionary<NSAttributedStringKey,id> *)attribute{
    CTRunDelegateCallbacks callback = [self createCallback];
    CTRunDelegateRef run = CTRunDelegateCreate(&callback, (__bridge void * _Nullable)(runDelegate));
    NSMutableDictionary *m = [attribute mutableCopy];
    if(m){
        m = [NSMutableDictionary new];
    }
    [m addEntriesFromDictionary:@{
        (NSString *)kCTRunDelegateAttributeName:(__bridge id)run,
        FNRunDelegateKey:runDelegate,
        NSFontAttributeName:[UIFont systemFontOfSize:0.01],
        NSForegroundColorAttributeName:[UIColor clearColor]
    }];
    self = [self initWithString:runDelegate.originText attributes:m];
    if(self) {
        
    }
    CFRelease(run);
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


