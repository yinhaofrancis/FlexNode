 

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
    
    NSMutableParagraphStyle * ps = [NSMutableParagraphStyle new];
    ps.paragraphSpacing = 0 ;
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] initWithString:@"阿上课对方开始点击 上的纠纷时绝对是 阿萨德肌肤设计的 啊说的话啊快就收到回复啊快就收到 \n" attributes:@{
        NSFontAttributeName:[UIFont systemFontOfSize:20],
        NSForegroundColorAttributeName:UIColor.whiteColor,
        NSParagraphStyleAttributeName:ps
    }];
    
    for (int i = 0; i < 9; i ++) {
        FNRunDelegate* run = [[FNRunDelegate alloc] initWithSize:CGSizeMake(100, 100) margin:UIEdgeInsetsMake(0, 0, 0, 0)  withImage:[UIImage imageNamed:@"avatar"]];
        NSMutableAttributedString* a = [[NSMutableAttributedString alloc] initWithRunDelegate:run attribute:@{
            NSParagraphStyleAttributeName:ps
        }];
        [att appendAttributedString:a];
//        run.display = self;
        run.displayView = _vv;
        run.justify = FNRunDelegateJustifyBetween;
        
    }
    
    NSAttributedString * a = [[NSAttributedString alloc] initWithRunDelegate:[FNRunDelegate.alloc initWithEmptyLine:0]];
//    NSAttributedString * a = [[NSAttributedString alloc] initWithString:@"\n" attributes:@{
//        NSFontAttributeName:[UIFont systemFontOfSize:300]
//    }];
    
    
    [att appendAttributedString:a];
    

    
    NSAttributedString* kk = [[NSAttributedString alloc]
                              initWithString:@"上的纠纷时绝对是 阿萨德肌肤设计的 啊说的话啊快就收到回复啊快就收到 " attributes:@{
                                  NSFontAttributeName:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium],
                                  NSForegroundColorAttributeName:UIColor.whiteColor
                                  
                              }];
    [att appendAttributedString:kk];
    FNFrame * f = [FNFrame createFrame:att size:CGSizeMake(375, 0)];
    
    UIImage * i = [f createUIImage];
    
    self.vv.image = i;
    
    
}
-(UIView *)runDelegateView{
    return [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"avatar"]];
}

@end

