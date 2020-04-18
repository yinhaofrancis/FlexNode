//
//  FNLine.h
//  FlexNode
//
//  Created by hao yin on 2020/4/18.
//

#import <Foundation/Foundation.h>
#import <CoreText/CoreText.h>
NS_ASSUME_NONNULL_BEGIN

@interface FNLine : NSObject

@property(nonatomic,assign) CGPoint     position;

@property(nonatomic,assign) CGFloat     ascent;

@property(nonatomic,assign) CGFloat     descent;

@property(nonatomic,assign) CGFloat     leading;

@property(nonatomic,assign) CGFloat     width;

@property(nonatomic,assign) CTLineRef   lineRef;

@property(nonatomic,readonly) CGRect    frame;
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

+(NSArray<FNRun *> *)runsCreateFrom:(FNLine *)line;
@end

NS_ASSUME_NONNULL_END
