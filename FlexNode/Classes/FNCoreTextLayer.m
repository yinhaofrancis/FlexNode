//
//  FNCoreTextLayer.m
//  FlexNode
//
//  Created by hao yin on 2020/4/4.
//

#import "FNCoreTextLayer.h"
#import <CoreText/CoreText.h>
#import "CALayer+FlexXml.h"
@implementation FNCoreTextLayer {
    CTFramesetterRef frameSet;
}
-(void)drawInContext:(CGContextRef)ctx{
    CGSize size = [self FlexNodeContentSize:self.bounds.size];
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -size.height);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, size.width, size.height), nil);
    CTFrameRef frame = CTFramesetterCreateFrame(frameSet, CFRangeMake(0, self.attributeString.length),path , nil);
    CTFrameDraw(frame, ctx);
    CGPathRelease(path);
    CFRelease(frame);
    
}
- (void)setAttributeString:(NSAttributedString *)attributeString{
    frameSet = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    _attributeString = attributeString;
}
+ (instancetype)nodeWithXMLAttribute:(nonnull NSDictionary<NSString *,NSString *> *)attribute {
    FNCoreTextLayer* layer = [super nodeWithXMLAttribute:attribute];
    for (NSString * key in attribute) {
        NSString *value = attribute[key];
        if([key isEqualToString:@"constraintSize"]) {
            layer.constraintSize = CGSizeFromString(value);
        }
    }
    return layer;
}

+ (SEL)propertyNode:(nonnull NSString *)name {
    if([name isEqualToString:@"self.AttributeString"]){
        return @selector(setAttributeString:);
    }else{
        return [super propertyNode:name];
    }
}
-(void)setConstraintSize:(CGSize)constraintSize{
    if (constraintSize.width == 0){
        constraintSize.width = CGFLOAT_MAX;
    }
    if (constraintSize.height == 0){
        constraintSize.height = CGFLOAT_MAX;
    }
    _constraintSize = constraintSize;
}

- (CGSize)FlexNodeContentSize:(CGSize)constaintSize { 
    return CTFramesetterSuggestFrameSizeWithConstraints(frameSet, CFRangeMake(0, self.attributeString.length), nil, constaintSize, nil);
}
- (void)setFrame:(CGRect)frame{
    [super setFrame:frame];
    [self setNeedsDisplay];
}
- (instancetype)init
{
    self = [super init];
    if (self) {
//        self.tileSize = CGSizeMake(320 , 320);
    }
    return self;
}

@end
