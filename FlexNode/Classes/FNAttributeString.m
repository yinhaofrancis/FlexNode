//
//  FNAttributeString.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNAttributeString.h"
#import "FNRunDelegate.h"
@implementation NSAttributedString(FNAttributeString)
- (void)drawInContext:(CGContextRef)ctx{
    CGRect rect = CGRectMake(0, 0, CGBitmapContextGetWidth(ctx) / UIScreen.mainScreen.scale, CGBitmapContextGetHeight(ctx) / UIScreen.mainScreen.scale);

    CGPathRef path = CGPathCreateWithRect(rect, nil);
    
    CTFramesetterRef frameset = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameset, CFRangeMake(0, self.length), path, nil);
    
    NSArray<FNLine *> *lines = [FNLine linesCreateFrom:frame];
    
    for (CFIndex i = 0;  i < lines.count; i++) {
        FNLine *line = lines[i];
        [self drawLine:line frame:frame context:ctx];
    }
    CGPathRelease(path);
    
    CFRelease(frameset);
    
    CFRelease(frame);
}
- (void)drawLine:(FNLine *)line
           frame:(CTFrameRef)frame
         context:(CGContextRef)ctx{
    NSArray<FNRun *>* runs = [FNRun runsCreateFrom:line];
    for (CFIndex i = 0; i < runs.count; i++) {
        [self drawRun:runs[i] line:line frame:frame context:ctx];
    }
}

- (void)drawRun:(FNRun *)run
           line:(FNLine *)line
          frame:(CTFrameRef)frame
        context:(CGContextRef)ctx{
    CGContextSaveGState(ctx);
    CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
    CGContextStrokeRect(ctx, run.frame);
    CGAffineTransform trans = CGContextGetTextMatrix(ctx);
    CGAffineTransform runTrans = CTRunGetTextMatrix(run.runRef);
    CGContextSetTextMatrix(ctx, CGAffineTransformConcat(trans, runTrans));
    CGContextSetTextPosition(ctx, line.position.x, line.position.y);
    CTRunDraw(run.runRef, ctx, CFRangeMake(0, 0));
    CFDictionaryRef attribute = CTRunGetAttributes(run.runRef);
    FNRunDelegate *rund = CFDictionaryGetValue(attribute, (__bridge const void *)(FNRunDelegateKey));
    [rund draw:ctx rect:run.frame];
    CGContextRestoreGState(ctx);
}
@end
