 

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNRunDelegate.h"
@interface FNViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FNCoreTextView *CoreTextView;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.CoreTextView.constraint = UIScreen.mainScreen.bounds.size.width;
    NSMutableParagraphStyle * paramx = [NSMutableParagraphStyle new];
    paramx.lineSpacing = 0;
    paramx.paragraphSpacing = 0;
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] init];
    FNRunDelegate* run = [[FNRunDelegate alloc] initWithSize:CGSizeMake(128, 128) margin:UIEdgeInsetsMake(0, 0, 0, 0) withImage:[UIImage imageNamed:@"avatar"]];
    run.cornerRadius = 64;
    NSMutableParagraphStyle * param = [NSMutableParagraphStyle new];
    param.alignment = NSTextAlignmentCenter;
    param.paragraphSpacing = 0;
    param.lineSpacing = 0;
    NSAttributedString * a = [[NSAttributedString alloc] initWithRunDelegate:run paragraphStyle:param];
    [att appendAttributedString:a];
    NSMutableParagraphStyle * param2 = [NSMutableParagraphStyle new];
    param2.alignment = NSTextAlignmentCenter;
    param2.paragraphSpacing = 0;
    param2.lineSpacing = 0;
    NSMutableAttributedString* title = [[NSMutableAttributedString alloc] initWithString:@"\nFrancis " attributes:@{
     NSFontAttributeName:[UIFont systemFontOfSize:24 weight:UIFontWeightMedium],
     NSParagraphStyleAttributeName:param2
    }];
    FNRunDelegate* icon = [[FNRunDelegate alloc] initWithFont:[UIFont systemFontOfSize:24] withImage:[UIImage imageNamed:@"p"]];
    NSAttributedString* iconStr = [[NSAttributedString alloc] initWithRunDelegate:icon];
    [title appendAttributedString:iconStr];
    [att appendAttributedString:title];
    NSMutableParagraphStyle * param3 = [NSMutableParagraphStyle new];
    param3.firstLineHeadIndent = 24 + 20;
    param3.headIndent = 20;
    param3.tailIndent = UIScreen.mainScreen.bounds.size.width - 20;
    param3.lineSpacing = 0;
    param2.alignment = NSTextAlignmentCenter;
    NSAttributedString * desc = [[NSAttributedString alloc] initWithString:@"\n人生丰富 收到回复 时间地方合适的。时代符号是的 地方好还是独家发货 如梦" attributes:@{
     NSFontAttributeName:[UIFont systemFontOfSize:12],
     NSForegroundColorAttributeName:[UIColor lightGrayColor],
     NSParagraphStyleAttributeName: param3
    }];
    [att appendAttributedString:desc];
    NSLog(@"%@",att);
    self.CoreTextView.attributeString = att;
    
    NSMutableParagraphStyle * sa = [[NSMutableParagraphStyle alloc] init];
    sa.alignment = NSTextAlignmentNatural;
    NSMutableAttributedString * ma = [[NSMutableAttributedString alloc] initWithString:@"abc" attributes:@{
        NSParagraphStyleAttributeName:sa,
        NSForegroundColorAttributeName:UIColor.blackColor,
    }];
    NSMutableParagraphStyle * sa2 = [[NSMutableParagraphStyle alloc] init];
    sa.alignment = NSTextAlignmentNatural;
    NSAttributedString* b = [[NSAttributedString alloc] initWithString:@"def" attributes:@{
        NSForegroundColorAttributeName:UIColor.blueColor,
        NSParagraphStyleAttributeName:sa2,
//        NSWritingDirectionAttributeName:@[@(NSWritingDirectionLeftToRight | NSWritingDirectionEmbedding)]
    }];
    [ma appendAttributedString:b];
    self.textLabel.attributedText = ma;
}
- (IBAction)change:(UISlider *)sender {

}

@end
