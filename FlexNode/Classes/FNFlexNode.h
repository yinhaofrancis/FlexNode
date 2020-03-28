//
//  FNFlexBox.h
//  HamUI_Example
//
//  Created by hao yin on 2020/3/25.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import <UIKit/UIKit.h>
NS_ASSUME_NONNULL_BEGIN
@class FNFlexLine;
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


@interface FNFlexNode : NSObject
#pragma mark - layout

@property(nonatomic,assign) CGRect frame;

@property(nonatomic,assign) CGFloat width;

@property(nonatomic,assign) CGFloat height;

@property(nonatomic,assign) CGFloat x;

@property(nonatomic,assign) CGFloat y;

@property(nonatomic,assign) CGFloat grow;

@property(nonatomic,assign) CGFloat shrink;

@property(nonatomic,assign) FNFlexLayoutJustifyType justify;

@property(nonatomic,assign) FNFlexLayoutAlignType align;

@property(nonatomic,assign) FNFlexLayoutJustifyType linejustify;

@property(nonatomic,assign) FNFlexLayoutDirectionType direction;

@property(nonatomic,weak)  FNFlexNode * superItem;

@property(nonatomic,readonly) NSArray<FNFlexNode *> *subItems;

@property(nonatomic,assign) CGFloat axisSize;

@property(nonatomic,assign) CGFloat normalSize;

@property(nonatomic,assign) CGFloat axisLocation;

@property(nonatomic,assign) CGFloat normalLocation;

@property(nonatomic,assign) BOOL isWrap;

- (void)addSubItem:(FNFlexNode *)item;

- (void)removeSubItemAt:(NSUInteger)index;

- (void)layout;

- (void)layoutLines:(NSArray<FNFlexLine *> *)lines;

- (FNFlexLine *)classifyStart:(NSInteger)start stopAt:(NSInteger *)end;
 
- (NSArray<FNFlexLine *> *)sepretedLines;

- (void)calcSelfFrameSize:(NSArray<FNFlexLine *> *)lines;

#pragma mark - display
@property(nonatomic,readonly) Class layerClass;

@property(nonatomic,readonly) Class viewClass;

@property(nonatomic,readonly,nullable) CALayer *layer;

@property(nonatomic,readonly,nullable) UIView *view;

- (void)drawLayer:(CGContextRef)ctx;

@property(nonatomic,readonly) FNFlexFrameRenderMode renderMode;

@property(nonatomic,strong) UIColor* backgroundColor;

- (instancetype)initWithRenderMode:(FNFlexFrameRenderMode)mode;

- (instancetype)initWithLayer:(CALayer *)layer;

- (instancetype)initWithView:(UIView *)view;

@end


@interface FNFlexLine:NSObject
    
@property(nonatomic,assign) CGFloat axisSize;

@property(nonatomic,assign) CGFloat normalSize;

@property(nonatomic,assign) CGFloat axisLocation;

@property(nonatomic,assign) CGFloat normalLocation;

@property(nonatomic,copy) NSArray<FNFlexNode *> *subItems;

- (instancetype)initWithItems:(NSArray<FNFlexNode *> *)items normalSize:(CGFloat)normalSize axisSize:(CGFloat)axisSize;
- (void)layout:(FNFlexNode *)container;
    
@end
NS_ASSUME_NONNULL_END

