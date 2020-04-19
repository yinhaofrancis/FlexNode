 

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNRunDelegate.h"


@interface FNViewController ()<FNRunDelegateDisplay>
@property (weak, nonatomic) IBOutlet UIImageView *vv;

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:@"阿上课对方开始点击 上的纠纷时绝对是 阿萨德肌肤设计的 啊说的话啊快就收到回复啊快就收到 \n" attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName:UIColor.whiteColor
    }];
    
    for (int i = 0; i < 10; i ++) {
        FNRunDelegate* run = [[FNRunDelegate alloc] initWithSize:CGSizeMake(100, 100) margin:UIEdgeInsetsMake(10, 0, 0, 0)  withImage:[UIImage imageNamed:@"avatar"]];
        NSMutableAttributedString* a = [[NSMutableAttributedString alloc] initWithRunDelegate:run];
        [att appendAttributedString:a];
//        run.display = self;
        run.displayView = _vv;
        run.justify = FNRunDelegateJustifyEnd;
        
    }

    FNFrame * f = [FNFrame createFrame:att size:CGSizeMake(480, 0)];
    
    UIImage * i = [f createUIImage];
    
    self.vv.image = i;
    
    
}
-(UIView *)runDelegateView{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
}

@end

