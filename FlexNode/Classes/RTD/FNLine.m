//
//  FNLine.m
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import "FNLine.h"

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
    }
    free(p);
    return [lines copy];
}

- (CGRect)frame{
    return CGRectMake(self.position.x, self.position.y - self.descent,self.width, self.ascent + self.descent);
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
//        CTLineGetOffsetForStringIndex(lineRef, CTRunGetStringRange(runref).location
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
