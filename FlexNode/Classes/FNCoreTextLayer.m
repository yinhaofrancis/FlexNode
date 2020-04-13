//
//  FNCoreTextLayer.m
//  FlexNode
//
//  Created by hao yin on 2020/4/4.
//

#import "FNCoreTextLayer.h"
#import <CoreText/CoreText.h>
#import "FNRunDelegate.h"

@implementation FNCoreTextLayer {
    CTFramesetterRef frameSet;
    CTFrameRef frameref;
}
-(void)drawInContext:(CGContextRef)ctx{
    CGSize size = [self FlexNodeContentSize:self.bounds.size];
    CGContextScaleCTM(ctx, 1, -1);
    CGContextTranslateCTM(ctx, 0, -size.height);
    CTFrameDraw(frameref, ctx);
    NSArray * lines = (NSArray *)CTFrameGetLines(frameref);
    CGPoint* points = malloc(sizeof(CGPoint) * lines.count);
    CTFrameGetLineOrigins(frameref, CFRangeMake(0, lines.count), points);
    for (int i = 0; i < lines.count; i ++) {
        CTLineRef lineRef = (__bridge CTLineRef)lines[i];
        NSArray *runs = (NSArray *)CTLineGetGlyphRuns(lineRef);
        for (id run in runs) {
            CTRunRef runref = (__bridge CTRunRef)(run);
            CGFloat xOffset = CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runref).location, NULL);
            CGFloat ascent;
            CGFloat descent;
            CGFloat leading;
            CGFloat width = CTRunGetTypographicBounds(runref, CFRangeMake(0, 0), &ascent, &descent, &leading);
            
            CGRect rect = CGRectMake(points[i].x + xOffset, points[i].y - descent, width, ascent + descent);
            NSDictionary * dic = (NSDictionary *)CTRunGetAttributes(runref);
            CFRange range = CTRunGetStringRange(runref);
            NSLog(@"%@ {%ld,%ld}",NSStringFromCGRect(rect),range.location,range.length);
            if(dic[(NSString *)kCTRunDelegateAttributeName]){
                [self drawRunDelegate:frameref
                                 line:lineRef
                                  run:runref
                            attribute:dic
                             runframe:rect
                              context:ctx];
            }
        }
    }
    free(points);
}

- (void)drawRunDelegate:(CTFrameRef)frameref
                   line:(CTLineRef)lineref
                    run:(CTRunRef)runref
              attribute:(NSDictionary *)att
               runframe:(CGRect)frame
                context:(CGContextRef)ctx{
    FNRunDelegate *d = att[FNRunDelegateKey];
    [d draw:ctx rect:frame];
}
- (void)setAttributeString:(NSAttributedString *)attributeString{
    if(frameSet){
        CFRelease(frameSet);
    }
    frameSet = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    _attributeString = attributeString;
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
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, frame.size.width, frame.size.height), nil);
    if (frameref) {
        CFRelease(frameref);
    }
    frameref = CTFramesetterCreateFrame(frameSet, CFRangeMake(0, self.attributeString.length),path , nil);
    CGPathRelease(path);
    [self setNeedsDisplay];
}
- (void)dealloc
{
    if(frameSet){
        CFRelease(frameSet);
    }
    if(frameref){
        CFRelease(frameref);
    }
    
}
@end
