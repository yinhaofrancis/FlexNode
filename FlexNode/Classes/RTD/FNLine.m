//
//  FNLine.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNLine.h"
#import "FNRunDelegate.h"
#import <CoreServices/CoreServices.h>
@implementation FNFrame

+ (FNFrame *)createFrame:(NSAttributedString *)attributeString size:(CGSize)size{
    size = CGSizeMake(size.width <= 0 ? CGFLOAT_MAX : size.width, size.height <= 0 ? CGFLOAT_MAX : size.height);
    
    FNFrame * fme = [[FNFrame alloc] init];
    CTFramesetterRef _frameSetRef = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attributeString);
    size = CTFramesetterSuggestFrameSizeWithConstraints(_frameSetRef, CFRangeMake(0, attributeString.length), nil, size, nil);
    CGPathRef path = CGPathCreateWithRect(CGRectMake(0, 0, size.width,size.height), nil);
    
    fme->_frameRef = CTFramesetterCreateFrame(_frameSetRef,
                                              CFRangeMake(0, attributeString.length),
                                              path,
                                              nil);
    
    fme->_frameSize = size;
    fme->_lines = [FNLine linesCreateFrom:fme->_frameRef];
    CGPathRelease(path);
    CFRelease(_frameSetRef);
    
    return fme;
}
- (void)drawInContext:(CGContextRef)ctx
               inRect:(CGRect)rect{
    CTFrameRef frame = self.frameRef;

    NSArray<FNLine *> *lines = self.lines;
    
    for (CFIndex i = 0;  i < lines.count; i++) {
        FNLine *line = lines[i];
        [self drawLine:line
                 frame:frame
               context:ctx
                  rect:rect];
    }
}

- (void)drawLine:(FNLine *)line
           frame:(CTFrameRef)frame
         context:(CGContextRef)ctx
            rect:(CGRect)rect{
    CGContextSetStrokeColorWithColor(ctx, UIColor.redColor.CGColor);
    CGContextStrokeRect(ctx, line.frame);
    NSArray<FNRun *>* runs = line.runs;
    for (CFIndex i = 0; i < runs.count; i++) {
        [self drawRun:runs[i]
                 line:line
                frame:frame
              context:ctx
                 rect:rect];
    }
}

- (void)drawRun:(FNRun *)run
           line:(FNLine *)line
          frame:(CTFrameRef)frame
        context:(CGContextRef)ctx
           rect:(CGRect)rect{
    CGContextSaveGState(ctx);
    CGRect renderFrame = run.frame;
    CGAffineTransform trans = CGContextGetTextMatrix(ctx);
    CGAffineTransform runTrans = CTRunGetTextMatrix(run.runRef);
    CGContextSetTextMatrix(ctx, CGAffineTransformConcat(trans, runTrans));
    
    CGContextSetTextPosition(ctx,
                             line.position.x + rect.origin.x,
                             line.position.y );
    CTRunDraw(run.runRef, ctx, CFRangeMake(0, 0));
    CFDictionaryRef attribute = CTRunGetAttributes(run.runRef);
    FNRunDelegate *rund = CFDictionaryGetValue(attribute, (__bridge const void *)(FNRunDelegateKey));
    rund.line = line;
    rund.run = run;
    [rund draw:ctx rect:renderFrame containerSize:rect.size];
    CGContextRestoreGState(ctx);
}
- (CGLayerRef)createLayerInContext:(CGContextRef)ctx{
    CGFloat scale = UIScreen.mainScreen.scale;
    CGLayerRef layer = CGLayerCreateWithContext(ctx, CGSizeMake(self.frameSize.width * scale, self.frameSize.height * scale), nil);
    CGContextRef layerContext = CGLayerGetContext(layer);
    CGContextScaleCTM(layerContext, scale, scale);
    [self drawInContext:layerContext inRect:CGRectMake(0, 0, self.frameSize.width, self.frameSize.height)];
    return layer;
}
- (CGImageRef)createCGImage{
    CGContextRef ctx = [self createContext:self.frameSize];
    [self drawInContext:ctx inRect:CGRectMake(0, 0, self.frameSize.width, self.frameSize.height)];
    CGImageRef img = [self createCGImage:ctx quality:1];
    CGContextRelease(ctx);
    return img;
}

- (UIImage *)createUIImage{
    CGImageRef img = [self createCGImage];
    UIImage * ui = [[UIImage alloc] initWithCGImage:img scale:UIScreen.mainScreen.scale orientation:UIImageOrientationUp];
    CGImageRelease(img);
    return ui;
}

- (CGImageRef) createCGImage:(CGContextRef)ctx quality:(CGFloat)quality{
    CGImageRef img = CGBitmapContextCreateImage(ctx);
    CFMutableDataRef data = CFDataCreateMutable(kCFAllocatorSystemDefault, 0);
    CGImageDestinationRef destination = CGImageDestinationCreateWithData(data, kUTTypePNG, 1, NULL);
    CFNumberRef number = CFNumberCreate(kCFAllocatorSystemDefault, kCFNumberFloatType, &quality);
    CFTypeRef v[1];
    CFTypeRef n[1];
    v[0] = kCGImageDestinationLossyCompressionQuality;
    n[0] = number;
    
    CFDictionaryRef property = CFDictionaryCreate(kCFAllocatorSystemDefault, (const void**)&v, (const void**)&n, 1, &kCFTypeDictionaryKeyCallBacks, &kCFTypeDictionaryValueCallBacks);
    
    CGImageDestinationAddImage(destination, img, property);
    CGImageDestinationFinalize(destination);
    
    CGImageSourceRef source = CGImageSourceCreateWithData(data, nil);
    CGImageRef result = CGImageSourceCreateImageAtIndex(source, 0, nil);
    
    CGImageRelease(img);
    CFRelease(data);
    CFRelease(destination);
    CFRelease(number);
    CFAutorelease(property);
    CFRelease(source);
    return result;
}
- (CGContextRef)createContext:(CGSize)size{
    CGFloat scale = UIScreen.mainScreen.scale;
    CGColorSpaceRef space = CGColorSpaceCreateDeviceRGB();
    CGContextRef ctx = CGBitmapContextCreate(nil,
                                             (int) scale* size.width,
                                             (int)scale * size.height,
                                             8,
                                             0,
                                             space,
                                             kCGBitmapByteOrderDefault | kCGImageAlphaPremultipliedLast);
    
    CGContextScaleCTM(ctx, scale, scale);
    CGColorSpaceRelease(space);
    return ctx;
}
- (void)dealloc {
    CFRelease(self.frameRef);
}
@end

@implementation FNLine
+ (NSArray<FNLine *> *)linesCreateFrom:(CTFrameRef)frame{
    
    CFArrayRef array = CTFrameGetLines(frame);
    CGPoint * p = malloc(sizeof(CGPoint) * CFArrayGetCount(array));
    CTFrameGetLineOrigins(frame, CFRangeMake(0, CFArrayGetCount(array)), p);
    
    NSMutableArray<FNLine *> *lines = [NSMutableArray new];
    
    for (CFIndex i = 0; i < CFArrayGetCount(array); i++) {
        FNLine * line = [[FNLine alloc] init];
        [lines addObject:line];
        line.lineRef = CFArrayGetValueAtIndex(array, i);
        line.position = p[i];
        line.width = CTLineGetTypographicBounds(line.lineRef, &line->_ascent, &line->_descent, &line->_leading);
        line->_runs = [FNRun runsCreateFrom:line];
    }
    free(p);
    return [lines copy];
}

- (CGRect)frame{
    return CGRectMake(self.position.x, self.position.y - self.descent,self.width, self.ascent + self.descent);
}
- (CFIndex)countOfRun{
    return CTLineGetGlyphCount(self.lineRef);
}
@end


@implementation FNRun

+ (NSArray<FNRun *> *)runsCreateFrom:(FNLine *)line{
    CFArrayRef array = CTLineGetGlyphRuns(line.lineRef);
    NSMutableArray *runs = [NSMutableArray new];
    for (CFIndex i = 0; i < CFArrayGetCount(array); i++) {
        CTRunRef runref = CFArrayGetValueAtIndex(array, i);
        FNRun * run = [[FNRun alloc] init];
        run.runRef = runref;
        run.index = i;
        CGFloat xOffset = CTLineGetOffsetForStringIndex(line.lineRef,
                                      CTRunGetStringRange(run.runRef).location,
                                      nil);
        run.width = CTRunGetTypographicBounds(run.runRef,
                                             CFRangeMake(0, 0),
                                              &run->_ascent,
                                              &run->_descent,
                                              &run->_leading);
        run.position = CGPointMake(xOffset + line.position.x, line.position.y - run.descent);
        run.runRef = runref;
        [runs addObject:run];
    }
    return [runs copy];
}

- (CGRect)frame{
    return CGRectMake(self.position.x, self.position.y, self.width, self.descent + self.ascent);
}

@end
