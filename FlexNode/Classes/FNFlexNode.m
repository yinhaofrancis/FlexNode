//
//  FNFlexLayouter.m
//  FlexNode
//
//  Created by hao yin on 2020/3/29.
//

#import "FNFlexNode.h"

@implementation FNFlexNode{
    NSMutableArray<FNFlexNode *> *_nodes;
    
    __weak FNFlexNode * superNode;
    
    NSMutableArray<FNFlexLine *> *lines;
    
    CGRect backupLocation;

}

- (CGRect)frame{
    return CGRectMake(self.x, self.y, self.width, self.height);
}

- (void)setAxisSize:(CGFloat)size direction:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        self.width = size;
    }else{
        self.height = size;
    }
}
- (void)setNormalSize:(CGFloat)size direction:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        self.height = size;
    }else{
        self.width = size;
    }
}
- (void)setAxisLocation:(CGFloat)location direction:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        self.x = location;
    }else{
        self.y = location;
    }
}
- (void)setNormalLocation:(CGFloat)location direction:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        self.y = location;
    }else{
        self.x = location;
    }
}

- (CGFloat)axisSizeWithDirection:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        return self.width;
    }else{
        return self.height;
    }
}
- (CGFloat)axisLocationWithDirection:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        return self.x;
    }else{
        return self.y;
    }
}
- (CGFloat)normalSizeWithDirection:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        return self.height;
    }else{
        return self.width;
    }
}
- (CGFloat)normalLocationWithDirection:(FNFlexLayoutDirectionType)direction{
    if(direction == FNFlexLayoutDirectionTypeRow){
        return self.y;
    }else{
        return self.x;
    }
}
- (void)addSubNode:(FNFlexNode *)node{
    if(!_nodes){
        _nodes = [[NSMutableArray alloc] init];
    }
    node->superNode = self;
    [_nodes addObject:node];
}
- (NSArray<FNFlexNode *> *)sublines{
    return [lines copy];
}
- (FNFlexNode *)superNode{
    return superNode;
}
- (NSArray<FNFlexNode *> *)subNode{
    return [_nodes copy];
}
- (void)layoutSize {
    [self seperatedLine];
    [self fillSize];
}
- (void)backup{
    for (FNFlexNode *node in self.subNode) {
        [node backup];
    }
    backupLocation = CGRectMake(self.x, self.y, self.width, self.height);
}
- (void)recover{
    for (FNFlexNode *node in self.subNode) {
        [node recover];
    }
    backupLocation = CGRectMake(self.x, self.y, self.width, self.height);
    self.x = backupLocation.origin.x;
    self.y = backupLocation.origin.y;
    self.width = backupLocation.size.width;
    self.height = backupLocation.size.height;
    [lines removeAllObjects];
}

-(void)fillSize{
    for (FNFlexLine *line in self.sublines) {
        [line fillLineSpace];
    }
    
    if(self.lineJustify == FNFlexLayoutJustifyTypeStretch){
        CGFloat sketchSpace = 0;
        for (FNFlexLine *line in self.sublines) {
            sketchSpace += line.normalSize;
        }
        sketchSpace = [self normalSizeWithDirection:self.direction] - sketchSpace;
        sketchSpace = sketchSpace / self.sublines.count;
        for (FNFlexLine *line in self.sublines) {
            line.normalSize += sketchSpace;
        }
    }
   
    for (FNFlexLine *line in self.sublines) {
        [line fillSketch];
    }
    if([self axisSizeWithDirection:self.direction] == 0){
       CGFloat maxAx = 0;
       for (FNFlexLine * line in self.sublines) {
           maxAx = MAX(line.axisSize, maxAx);
       }
       [self setAxisSize:maxAx direction:self.direction];
   }
   if([self normalSizeWithDirection:self.direction] == 0){
       CGFloat sumNor = 0;
       for (FNFlexLine *line in self.sublines) {
           sumNor += line.normalSize;
       }
       [self setNormalSize:sumNor direction:self.direction];
   }
    for (FNFlexNode *node in self.subNode) {
        [node fillSize];
    }

}

- (void)seperatedLine {
    if(self.subNode.count == 0) return;
    for (FNFlexNode *node in self.subNode) {
        [node seperatedLine];
    }
    if(!lines){
        lines = [NSMutableArray new];
    }
    NSMutableArray<FNFlexNode *> *nodes = [NSMutableArray new];
    if(self.wrap && [self axisSizeWithDirection:self.direction] > 0){
        CGFloat sum = 0;
        CGFloat maxNormal = 0;
        CGFloat grows = 0;
        CGFloat shrinks = 0;
        for (int i = 0; i < self.subNode.count; i++) {
            if(sum + [self.subNode[i] axisSizeWithDirection:self.direction]  > [self axisSizeWithDirection:self.direction]){
                if(sum == 0){
                    FNFlexLine* line = [[FNFlexLine alloc] initWithNodes:@[self.subNode[i]]
                                                                axisSize:[self.subNode[i] axisSizeWithDirection:self.direction]
                                                              normalSize:[self.subNode[i] normalSizeWithDirection:self.direction]
                                                                    grow:self.subNode[i].grow
                                                                  shrink:self.subNode[i].shrink];
                    line.ownNode = self;
                    [lines addObject:line];
                    
                }else{
                    FNFlexLine* line = [[FNFlexLine alloc] initWithNodes:nodes
                                                                axisSize:sum
                                                              normalSize:maxNormal
                                                                    grow:grows
                                                                  shrink:shrinks];
                    line.ownNode = self;
                    [lines addObject:line];
                    sum = 0;
                    maxNormal = 0;
                    nodes = [NSMutableArray new];
                    i--;
                    grows = 0;
                    shrinks = 0;
                }
            }else{
                maxNormal = MAX([self.subNode[i] normalSizeWithDirection:self.direction], maxNormal);
                sum += [self.subNode[i] axisSizeWithDirection:self.direction];
                [nodes addObject:self.subNode[i]];
                grows += self.subNode[i].grow;
                shrinks += self.subNode[i].shrink;
            }
        }
        if(nodes.count > 0){
            FNFlexLine* line = [[FNFlexLine alloc] initWithNodes:nodes
                                                        axisSize:sum
                                                      normalSize:maxNormal
                                                            grow:grows
                                                          shrink:shrinks];
            line.ownNode = self;
            [lines addObject:line];
        }
    }else{
        CGFloat sum = 0;
        CGFloat maxNormal = 0;
        CGFloat grows = 0;
        CGFloat shrinks = 0;
        for (FNFlexNode *node in self.subNode) {
            sum += [node axisSizeWithDirection:self.direction];
            maxNormal = MAX([node normalSizeWithDirection:self.direction], maxNormal);
            grows += node.grow;
            shrinks += node.shrink;
        }
        FNFlexLine* line = [[FNFlexLine alloc] initWithNodes:self.subNode
                                                    axisSize:sum
                                                  normalSize:maxNormal
                                                        grow:grows
                                                      shrink:shrinks];
        line.ownNode = self;
        [lines addObject:line];
    }
}

- (void)layout {
    [self backup];
    [self layoutSize];
    NSLog(@"%@",self);
    [self recover];
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"node %@ {%@}", NSStringFromCGRect(self.frame),self.subNode];
}
@end

@implementation FNFlexLine

- (instancetype)initWithNodes:(NSArray<FNFlexNode *> *)nodes
                     axisSize:(CGFloat)axis
                   normalSize:(CGFloat)normal
                         grow:(CGFloat)grows
                       shrink:(CGFloat)shrinks{
    self = [super init];
    if(self){
        self.subNode = nodes;
        self.axisSize = axis;
        self.normalSize = normal;
        self.grows = grows;
        self.shrinks = shrinks;
    }
    return self;
}
- (NSString *)description
{
    return [NSString stringWithFormat:@"line %@ a:%lf n:%lf,sp:%lf", self.subNode,self.axisSize,self.normalSize,self.space];
}

- (CGFloat)space{
    return [self.ownNode axisSizeWithDirection:self.ownNode.direction] - self.axisSize;
}
- (void)fillLineSpace{
    if(self.space > 0 && self.grows > 0){
        for (FNFlexNode *node in self.subNode) {
            CGFloat w = [node axisSizeWithDirection:self.ownNode.direction] + self.space * node.grow / self.grows;
            [node setAxisSize:w direction:self.ownNode.direction];
        }
    }
    if(self.space < 0 && self.shrinks > 0){
        for (FNFlexNode *node in self.subNode) {
            CGFloat w = [node axisSizeWithDirection:self.ownNode.direction] + self.space * node.shrink / self.shrinks;
            [node setAxisSize:w direction:self.ownNode.direction];
        }
    }
    
}
- (void)fillSketch{
    if(self.ownNode.align == FNFlexLayoutAlignTypeStretch){
        for (FNFlexNode *node in self.subNode) {
            if([node normalSizeWithDirection:self.ownNode.direction] == 0){
                [node setNormalSize:self.normalSize direction:self.ownNode.direction];
            }
        }
    }
}
@end
