 

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNRunDelegate.h"
#import "FNAttributeString.h"

@interface FNViewController ()<FNRunDelegateDisplay>
@property (weak, nonatomic) IBOutlet FNCoreTextView *vv;

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:@"阿上课对方开始点击 上的纠纷时绝对是 阿萨德肌肤设计的 啊说的话啊快就收到回复啊快就收到 " attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName:UIColor.whiteColor
    }];
    
    for (int i = 0; i < 3; i ++) {
        FNRunDelegate* run = [[FNRunDelegate alloc] initWithSize:CGSizeMake(100, 100) margin:UIEdgeInsetsMake(50, 0, 0, 0)  withImage:[UIImage imageNamed:@"avatar"]];
        NSMutableAttributedString* a = [[NSMutableAttributedString alloc] initWithRunDelegate:run];
        run.display = self;
        [att appendAttributedString:a];
    
    }

    self.vv.string = att;

    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.vv.estimatedSize = CGSizeMake(500, 0);
        [UIView animateWithDuration:0.3 animations:^{
            [self.vv invalidateIntrinsicContentSize];
            [self.view layoutIfNeeded];
        }];
        
    });
    
    
}


- (BOOL)autoDisplayRunDelegate:(nonnull FNRunDelegate *)rundelegate {
    return false;
}

- (void)runDelegate:(nonnull FNRunDelegate *)rundelegate
       displayFrame:(CGRect)frame
      containerSize:(CGSize)containerSize
            context:(nonnull CGContextRef)ctx {
    dispatch_async(dispatch_get_main_queue(), ^{
        if (!rundelegate.displayView) {
            UIImageView * img = [[UIImageView alloc] initWithImage:rundelegate.image];
            rundelegate.displayView = img;
            [self.vv addSubview:img];
        }
        rundelegate.displayView.frame = [rundelegate viewFrameFromContextFrame:frame WithContainer:containerSize] ;
    });
}

@end
