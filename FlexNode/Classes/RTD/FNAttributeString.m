//
//  FNAttributeString.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNAttributeString.h"
#import "FNRunDelegate.h"
#import <CoreServices/CoreServices.h>
@implementation NSAttributedString(FNAttributeString)
- (void)drawInContext:(CGContextRef)ctx
               inRect:(CGRect)rect{
    
    CGPathRef path = CGPathCreateWithRect(rect, nil);
    
    CTFramesetterRef frameset = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    
    CTFrameRef frame = CTFramesetterCreateFrame(frameset, CFRangeMake(0, self.length), path, nil);
    
    NSArray<FNLine *> *lines = [FNLine linesCreateFrom:frame];
    
    for (CFIndex i = 0;  i < lines.count; i++) {
        FNLine *line = lines[i];
        [self drawLine:line
                 frame:frame
               context:ctx
                  rect:rect];
    }
    CGPathRelease(path);
    
    CFRelease(frameset);
    
    CFRelease(frame);
}

- (void)drawLine:(FNLine *)line
           frame:(CTFrameRef)frame
         context:(CGContextRef)ctx
            rect:(CGRect)rect{
    NSArray<FNRun *>* runs = [FNRun runsCreateFrom:line];
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
    
    [rund draw:ctx rect:renderFrame containerSize:rect.size];
    CGContextRestoreGState(ctx);
}

- (CGSize)contentSize:(CGSize)constraintSize{
    CTFramesetterRef frameset = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)self);
    return CTFramesetterSuggestFrameSizeWithConstraints(frameset, CFRangeMake(0, self.length), nil, constraintSize, nil);
}

- (CGLayerRef)createLayerInContext:(CGContextRef)ctx inRect:(CGRect)rect scale:(CGFloat)scale{
    CGLayerRef layer = CGLayerCreateWithContext(ctx, CGSizeMake(rect.size.width * scale, rect.size.height * scale), nil);
    CGContextRef layerContext = CGLayerGetContext(layer);
    CGContextScaleCTM(layerContext, scale, scale);
    [self drawInContext:layerContext inRect:rect];
    return layer;
}
- (CGImageRef)createImageInRect:(CGRect)rect{
    CGContextRef ctx = [self createContext:rect.size];
    [self drawInContext:ctx inRect:rect];
    CGImageRef img = [self createCGImage:ctx quality:1];
    CGContextRelease(ctx);
    return img;
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
@end
