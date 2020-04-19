//
//  FNLine.h
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN
@class FNRun;
@class FNLine;
@class FNFrame;


@interface FNFrame : NSObject

@property(nonatomic,readonly) NSArray<FNLine *> *lines;

@property(nonatomic,readonly) CTFrameRef frameRef;

@property(nonatomic,readonly) CGSize frameSize;

+(FNFrame *)createFrame:(NSAttributedString *) attributeString size:(CGSize)size;

- (void)drawInContext:(CGContextRef)ctx
               inRect:(CGRect)rect;

- (CGLayerRef)createLayerInContext:(CGContextRef)ctx;

- (UIImage *)createUIImage;

- (CGImageRef)createCGImage;

@end

@interface FNLine : NSObject

@property(nonatomic,assign) CGPoint     position;

@property(nonatomic,assign) CGFloat     ascent;

@property(nonatomic,assign) CGFloat     descent;

@property(nonatomic,assign) CGFloat     leading;

@property(nonatomic,assign) CGFloat     width;

@property(nonatomic,assign) CTLineRef   lineRef;

@property(nonatomic,readonly) CGRect    frame;

@property(nonatomic,readonly) CFIndex countOfRun;

@property(nonatomic,readonly) NSArray<FNRun *> *runs;

+(NSArray<FNLine *> *)linesCreateFrom:(CTFrameRef)frame;

@end


@interface FNRun : NSObject

@property(nonatomic,assign) CGPoint     position;

@property(nonatomic,assign) CGSize      size;

@property(nonatomic,assign) CTRunRef    runRef;

@property(nonatomic,assign) CGFloat     ascent;

@property(nonatomic,assign) CGFloat     descent;

@property(nonatomic,assign) CGFloat     leading;

@property(nonatomic,assign) CGFloat     width;

@property(nonatomic,readonly) CGRect    frame;

@property(nonatomic,assign) NSInteger   index;

+(NSArray<FNRun *> *)runsCreateFrom:(FNLine *)line;
@end

NS_ASSUME_NONNULL_END
