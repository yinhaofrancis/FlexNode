//
//  FNFlexLayouter.h
//  FlexNode
//
//  Created by hao yin on 2020/3/29.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, FNFlexLayoutJustifyType) {
    FNFlexLayoutJustifyTypeFlexStart,
    FNFlexLayoutJustifyTypeFlexCenter,
    FNFlexLayoutJustifyTypeFlexEnd,
    FNFlexLayoutJustifyTypeSpaceAround,
    FNFlexLayoutJustifyTypeSpaceEvenly,
    FNFlexLayoutJustifyTypeSpaceBetween,
    FNFlexLayoutJustifyTypeStretch
};

typedef NS_ENUM(NSUInteger, FNFlexLayoutAlignType) {
    FNFlexLayoutAlignTypeFlexStart,
    FNFlexLayoutAlignTypeFlexCenter,
    FNFlexLayoutAlignTypeFlexEnd,
    FNFlexLayoutAlignTypeStretch,
};

typedef NS_ENUM(NSUInteger, FNFlexLayoutDirectionType) {
    FNFlexLayoutDirectionTypeRow,
    FNFlexLayoutDirectionTypeCol,
};

typedef NS_ENUM(NSUInteger, FNFlexFrameRenderMode) {
    FNFlexFrameRenderModeDynamic,
    FNFlexFrameRenderModeStatic,
};
@class FNFlexLine;

@interface FNFlexNode : NSObject
@property(nonatomic,readonly) UIView *view;
@property(nonatomic,readonly) CALayer *layer;
@property(nonatomic,readonly) CGRect frame;
@property(nonatomic,assign) CGFloat x;
@property(nonatomic,assign) CGFloat y;
@property(nonatomic,assign) CGFloat width;
@property(nonatomic,assign) CGFloat height;
@property(nonatomic,readonly) NSArray<FNFlexNode *> *subNode;
@property(nonatomic,readonly) NSArray<FNFlexLine *> *sublines;
@property(nonatomic,readonly)  FNFlexNode *superNode;
@property(nonatomic,assign) FNFlexLayoutDirectionType direction;
@property(nonatomic,assign) FNFlexLayoutAlignType align;
@property(nonatomic,assign) FNFlexLayoutJustifyType justify;
@property(nonatomic,assign) FNFlexLayoutJustifyType lineJustify;
@property(nonatomic,assign) BOOL wrap;
@property (nonatomic,assign) CGFloat grow;

@property (nonatomic,assign) CGFloat shrink;

- (void) setAxisLocation:(CGFloat)location direction:(FNFlexLayoutDirectionType)direction;

- (void) setNormalLocation:(CGFloat)location direction:(FNFlexLayoutDirectionType)direction;

- (void) setAxisSize:(CGFloat)size direction:(FNFlexLayoutDirectionType)direction;

- (void) setNormalSize:(CGFloat)size direction:(FNFlexLayoutDirectionType)direction;


- (CGFloat) axisLocationWithDirection:(FNFlexLayoutDirectionType)direction;

- (CGFloat) normalLocationWithDirection:(FNFlexLayoutDirectionType)direction;

- (CGFloat) axisSizeWithDirection:(FNFlexLayoutDirectionType)direction;

- (CGFloat) normalSizeWithDirection:(FNFlexLayoutDirectionType)direction;

- (void)addSubNode:(FNFlexNode *)node;

- (void)layout;

- (void)seperatedLine;

- (void)fillSize;

- (void)backup;

- (instancetype)initWithView:(UIView *)view;

- (instancetype)initWithLayer:(CALayer *)layer;

- (instancetype)initWithAttributeString:(NSAttributedString *)aString size:(CGSize)size;

- (instancetype)initWithImage:(UIImage *)image;

@end

@interface FNFlexLine : NSObject

@property (nonatomic, assign) CGFloat axisLocation;

@property (nonatomic, assign) CGFloat normalLocation;

@property (nonatomic, assign) CGFloat axisSize;

@property (nonatomic, assign) CGFloat normalSize;

@property (nonatomic, copy) NSArray<FNFlexNode *> *subNode;

@property (nonatomic,weak) FNFlexNode* ownNode;

@property (nonatomic, readonly) CGFloat space;

@property (nonatomic,assign) CGFloat grows;

@property (nonatomic,assign) CGFloat shrinks;

- (instancetype)initWithNodes:(NSArray<FNFlexNode *> *)nodes
                     axisSize:(CGFloat)axis
                   normalSize:(CGFloat)normal
                         grow:(CGFloat)grows
                       shrink:(CGFloat)shrinks;
- (void)fillLineSpace;

- (void)fillSketch;
@end
NS_ASSUME_NONNULL_END
