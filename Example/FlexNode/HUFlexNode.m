//
//  HUFlexBox.m
//  HamUI_Example
//
//  Created by hao yin on 2020/3/25.
//  Copyright © 2020 yinhaofrancis. All rights reserved.
//

#import "FNFlexNode.h"

#import <Ham/Ham.h>
@implementation FNFlexNode{
    NSMutableArray<FNFlexNode *> *_subMItems;
    NSDictionary* dic;
    Class layerClass;
}
@synthesize view = _view;
@synthesize layer = _layer;
@synthesize frame = _frame;
//MARK:property backup
-(NSArray *)backupKey{
    return @[@"width",@"height",@"x",@"y"];
}
- (CGRect)frame{
    return _frame;
}
- (void)setFrame:(CGRect)frame{
    _frame = frame;
    self.layer.frame = frame;
    self.view.frame = frame;
}
- (NSDictionary *)encodeDiction {
    NSArray<NSString *> * array = [HMOCRunTimeTool propertyInClass:self.class];
    NSMutableDictionary* dic = [NSMutableDictionary new];
    for (NSString* key in array) {
        if([[self backupKey] containsObject:key]){
            dic[key] = [self valueForKey:key];
        }
    }
    return  dic;
}

- (void)decoderProperty:(NSDictionary *)dic {
    NSArray<NSString *> * array = [HMOCRunTimeTool propertyInClass:self.class];
    for (NSString* key in array) {
        if([[self backupKey] containsObject:key]){
            [self setValue:dic[key] forKey:key];
        }
    }
}
//MARK:树形结构
- (NSArray<FNFlexNode *> *)subItems{
    return [_subMItems copy];
}


- (void)addSubItem:(FNFlexNode *)item{
    if(!_subMItems){
        _subMItems = [[NSMutableArray alloc] init];
    }
    [_subMItems addObject:item];
    item.superItem = self;
    [self.view addSubview:item.view];
    [self.layer addSublayer:item.layer];
}
- (void)removeSubItemAt:(NSUInteger)index{
    [_subMItems removeObjectAtIndex:index];
}
//MARK:布局
- (void)layout {
    //备份状态
    dic = [self encodeDiction];
    //子节点优先布局
    for (FNFlexNode * item in self.subItems) {
        [item layout];
    }
    NSArray<HUFlexLine *> *lines = [self sepretedLines]; //分行
    [self calcSelfFrameSize:lines]; // 计算自己的大小
    [self layoutLines:lines];
    [self layoutItem:lines];
    
    [self layoutComplete];
}
- (void)layoutComplete{
    self.frame = CGRectMake(self.x, self.y, self.width, self.height);
    for (FNFlexNode * item in self.subItems) {
        item.frame = CGRectMake(item.x, item.y, item.width, item.height);
        [item layoutComplete];
    }
    [self decoderProperty:dic];
}
- (void)layoutLines:(NSArray<HUFlexLine *> *)lines{
    if(lines.count == 0){
        return;
    }
    CGFloat start = 0;
    CGFloat step = 0;
    CGFloat normallineSum = 0;
    for (HUFlexLine *line in lines) {
        normallineSum += line.normalSize;
    }
    // 计算行空余的位置
    CGFloat space = self.normalSize - normallineSum;
    
    switch (self.linejustify) {
        case HUFlexLayoutJustifyTypeFlexStart:
            start = 0;
            step = 0;
            break;
        case HUFlexLayoutJustifyTypeFlexCenter:
            step = 0;
            start = space / 2;
            break;
        case HUFlexLayoutJustifyTypeFlexEnd:
            step = 0;
            start = space;
            break;
        case HUFlexLayoutJustifyTypeSpaceAround:
            start = space / lines.count / 2.0;
            step = 2 * start;
            break;
        case HUFlexLayoutJustifyTypeSpaceEvenly:
            start = space / (lines.count + 1.0);
            step = start;
            break;
        case HUFlexLayoutJustifyTypeSpaceBetween:
            if(lines.count > 1){
                start = 0;
                step = space / (lines.count - 1.0);
            }else{
                start = 0;
                step = 0;
            }
            break;
        case HUFlexLayoutJustifyTypeStretch:
            start = 0;
            step = 0;
            for (HUFlexLine *line in lines) {
                line.normalSize += space / lines.count;
            }
            break;
    }
    CGFloat last = start;
    for (HUFlexLine *line in lines) {
        line.axisLocation = 0;
        line.normalLocation = last;
        last += line.normalSize;
        last += step;
    }
}

- (void)layoutItem:(NSArray<HUFlexLine *> *)lines{
    for (HUFlexLine *line in lines) {
        line.axisSize = self.axisSize;
        [line layout:self];
    }
}
- (HUFlexLine *)classifyStart:(NSInteger)start stopAt:(NSInteger *)end{
    NSMutableArray* array = [[NSMutableArray alloc] init];
    CGFloat sumAxis = 0;
    CGFloat maxnormal = 0;
    for (NSInteger i = start; i < self.subItems.count; i++) {
        FNFlexNode *current  = self.subItems[i];
        if(sumAxis + current.axisSize > self.axisSize){
            if(sumAxis == 0){
                *end = i + 1;
                return [HUFlexLine.alloc initWithItems:array normalSize:current.normalSize axisSize:current.axisSize];
            }else{
                *end = i;
                return [HUFlexLine.alloc initWithItems:array normalSize:maxnormal axisSize:sumAxis];
            }
        }else{
            [array addObject:current];
            sumAxis += current.axisSize;
            maxnormal = MAX(maxnormal, current.normalSize);
        }
    }
    *end = self.subItems.count;
    return [HUFlexLine.alloc initWithItems:array normalSize:maxnormal axisSize:sumAxis];
}

- (NSArray<HUFlexLine *> *)sepretedLines{
    //MARK:分行
    if(self.isWrap){
        NSMutableArray<HUFlexLine *> * lines = [NSMutableArray new];
        NSInteger start = 0,end = self.subItems.count;
        while (start < end) {
            HUFlexLine *line = [self classifyStart:start stopAt:&start];
            [lines addObject:line];
        }
        return lines;
    }else{
        CGFloat axis = 0;
        CGFloat normal = 0;
        for (FNFlexNode * n in self.subItems) {
            axis += n.axisSize;
            normal = MAX(normal, n.normalSize);
        }
        return @[[[HUFlexLine alloc] initWithItems:self.subItems normalSize:normal axisSize:axis]];
    }
    
}
- (void) calcSelfFrameSize:(NSArray<HUFlexLine *> *)lines{
    CGFloat frameNormal = 0;
    CGFloat frameAxis = 0;
    for (HUFlexLine *n in lines) {
        frameNormal += n.normalSize; // 垂直方向累加
        frameAxis = MAX(frameAxis, n.axisSize); // 主轴取最大值;
    }
    if(self.normalSize == 0){
        self.normalSize = frameNormal;
    }
    if(self.axisSize == 0){
        self.axisSize = frameAxis;
    }
}

//MARK:property
- (void)setAxisSize:(CGFloat)axisSize{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        self.width = axisSize;
    }else{
        self.height = axisSize;
    }
}
- (CGFloat)axisSize{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        return self.width;
    }else{
        return self.height;
    }
}
- (void)setNormalSize:(CGFloat)normalSize{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        self.height = normalSize;
    }else{
        self.width = normalSize;
    }
}
- (CGFloat)normalSize{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        return self.height;
    }else{
        return self.width;
    }
}
- (void)setAxisLocation:(CGFloat)axisLocation{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        self.x = axisLocation;
    }else{
        self.y = axisLocation;
    }
}
- (CGFloat)axisLocation{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        return self.x;
    }else{
        return self.y;
    }
}
- (void)setNormalLocation:(CGFloat)normalLocation{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        self.y = normalLocation;
    }else{
        self.x = normalLocation;
    }
}
- (CGFloat)normalLocation{
    HUFlexLayoutDirectionType type = self.superItem ? self.superItem.direction : self.direction;
    if(type == HUFlexLayoutDirectionTypeRow){
        return self.y;
    }else{
        return self.x;
    }
}
- (Class)layerClass{
    if(layerClass){
        return layerClass;
    }
    return [CALayer class];
}
- (Class)viewClass{
    return [UIView class];
}
- (CALayer *)layer{
    if(self.renderMode == HUFlexFrameRenderModeDynamic){
        return self.view.layer;
    }else if (self.renderMode == HUFlexFrameRenderModeStatic){
        if(!_layer){
            _layer = [[self.layerClass alloc] init];
        }
        return _layer;
    }else{
        return nil;
    }
}
- (UIView *)view{
    if(self.renderMode == HUFlexFrameRenderModeDynamic){
        if(!_view){
            _view = [[self.viewClass alloc] init];
        }
        return _view;
    }else if (self.renderMode == HUFlexFrameRenderModeStatic){
        return nil;
    }else{
        return nil;
    }
}
- (void)drawLayer:(CGContextRef)ctx{
    [self layout];
    [self.layer renderInContext:ctx];
}
- (void)setBackgroundColor:(UIColor *)backgroundColor{
    _backgroundColor = backgroundColor;
    self.view.backgroundColor = backgroundColor;
    self.layer.backgroundColor = backgroundColor.CGColor;
}
- (instancetype)initWithRenderMode:(HUFlexFrameRenderMode)mode{
    self = [super init];
    if(self){
        _renderMode = mode;
    }
    return self;
}
- (instancetype)initWithLayerClass:(Class)cls{
    self = [super init];
    if(self){
        layerClass = cls;
        _renderMode = HUFlexFrameRenderModeStatic;
    }
    return self;
}
- (NSString *)description
{
    NSMutableString* string = [[NSMutableString alloc] init];
    for (FNFlexNode *frame in self.subItems) {
        [string appendFormat:@"%@\n",NSStringFromCGRect(frame.frame)];
    }
    return [NSString stringWithFormat:@"%@{\n%@\n}", NSStringFromCGRect(self.frame),string];
}
- (NSString *)debugDescription
{
    NSMutableString* string = [[NSMutableString alloc] init];
    for (FNFlexNode *frame in self.subItems) {
        [string appendFormat:@"%@\n",NSStringFromCGRect(frame.frame)];
    }
    return [NSString stringWithFormat:@"<%@: %p> %@{\n%@\n}", [self class], self, NSStringFromCGRect(self.frame),string];
}
@end

@implementation HUFlexLine

- (instancetype)initWithItems:(NSArray<FNFlexNode *> *)items
                   normalSize:(CGFloat)normalSize
                     axisSize:(CGFloat)axisSize{
    self = [super init];
    
    if(self){
        self.subItems = items;
        self.axisSize = axisSize;
        self.normalSize = normalSize;
    }
    return self;
}


- (void)layout:(FNFlexNode *)container{
    if(self.subItems.count <= 0){
        return;
    }
    CGFloat max = 0;
    CGFloat grows = 0;
    CGFloat shrink = 0;
    for (FNFlexNode *node in self.subItems) {
        max += node.axisSize;
        grows += node.grow;
        shrink += node.shrink;
    }
    CGFloat space = container.axisSize - max;
    
    for (FNFlexNode *node in self.subItems) {
        if(space > 0 && node.grow > 0){
            CGFloat seed = space / grows;
            node.axisSize += seed * node.grow;
        }else if (space < 0 && node.shrink > 0){
            CGFloat seed = space / shrink;
            node.axisSize += seed * node.shrink;
        }else{
            
        }
        if(container.justify == HUFlexLayoutJustifyTypeStretch && node.normalSize == 0){
            node.normalSize = self.normalSize;
        }
    }
    CGFloat start = 0;
    CGFloat step = 0;
    if(space == 0 || (grows > 0 && space > 0) || (shrink > 0 && space < 0)){
        start = 0;
        step = 0;
    }else{
        switch (container.justify) {
            case HUFlexLayoutJustifyTypeFlexStart:
            case HUFlexLayoutJustifyTypeStretch:
                start = 0;
                step = 0;
                break;
            case HUFlexLayoutJustifyTypeFlexCenter:
                step = 0;
                start = space / 2;
                break;
            case HUFlexLayoutJustifyTypeFlexEnd:
                step = 0;
                start = space;
                break;
            case HUFlexLayoutJustifyTypeSpaceAround:
                start = space / self.subItems.count / 2.0;
                step = start * 2;
                break;
            case HUFlexLayoutJustifyTypeSpaceEvenly:
                start = space / (self.subItems.count + 1);
                step = start;
                break;
            case HUFlexLayoutJustifyTypeSpaceBetween:
                if(self.subItems.count == 1){
                    start = 0;
                    step = 0;
                }else{
                    start = 0;
                    step = space / (self.subItems.count - 1);
                }
                break;
        }
    }
    for (FNFlexNode* item in self.subItems) {
        item.axisLocation = start;
        start = start + item.axisSize + step;
    }
    for (FNFlexNode *frame in self.subItems) {
        switch (container.align) {
            case HUFlexLayoutAlignTypeFlexStart:
                frame.normalLocation = self.normalLocation;
                break;
            case HUFlexLayoutAlignTypeFlexCenter:
                frame.normalLocation = self.normalLocation + (self.normalSize - frame.normalSize) / 2;
                break;
            case HUFlexLayoutAlignTypeFlexEnd:
                frame.normalLocation = self.normalLocation + (self.normalSize - frame.normalSize);
                break;
            case HUFlexLayoutAlignTypeStretch:
                frame.normalLocation = self.normalLocation;
                if(frame.normalSize == 0){
                    frame.normalSize = self.normalSize;
                }
                break;
        }
    }
}
- (NSString *)debugDescription
{
    return [NSString stringWithFormat:@"<%@: %p> a:%f,n:%f,as:%f,ns:%f  item %@", [self class], self, self.axisLocation,self.normalLocation,self.axisSize,self.normalSize,self.subItems];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"a:%f,n:%f,as:%f,ns:%f item %@", self.axisLocation,self.normalLocation,self.axisSize,self.normalSize ,self.subItems];
}
@end

