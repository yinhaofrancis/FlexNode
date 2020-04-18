 

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNRunDelegate.h"
#import "FNAttributeString.h"
#import <Ham/Ham.h>
@interface FNViewController ()<UITextFieldDelegate>
@property(nonatomic,strong) NSTimer *timer;
@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSMutableParagraphStyle * paramx = [NSMutableParagraphStyle new];
    paramx.lineSpacing = 0;
    paramx.paragraphSpacing = 0;
    NSMutableAttributedString* att = [[NSMutableAttributedString alloc] init];
    FNRunDelegate* run = [[FNRunDelegate alloc] initWithSize:CGSizeMake(128, 128) withImage:[UIImage imageNamed:@"avatar"]];
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
//    FNRunDelegate* icon = [FNRunDelegate.alloc initWithAttributeString:[NSAttributedString.alloc initWithString:@"abc\ncccc" attributes:@{
//        NSFontAttributeName:[UIFont systemFontOfSize:20],
//        NSForegroundColorAttributeName:UIColor.blueColor
//    }]];
//    icon.contentView = self.view;
    NSAttributedString* iconStr = [[NSAttributedString alloc] initWithRunDelegate:icon];
    [title appendAttributedString:iconStr];
    [att appendAttributedString:title];
    NSMutableParagraphStyle * param3 = [NSMutableParagraphStyle new];
    param3.firstLineHeadIndent = 24 + 20;
    param3.headIndent = 20;
    param3.tailIndent = UIScreen.mainScreen.bounds.size.width - 20;
    param3.lineSpacing = 0;
    param2.alignment = NSTextAlignmentCenter;
    NSAttributedString * desc = [[NSAttributedString alloc] initWithString:@"\n人生丰富 收到回复 时间地方合适的。时代符号是的 地方好还是独家发货 如sdkfh skdjhf kasdf dasdhf jasdf asdfaj sdfhsjd hasldkjfha lsjkdha ksdhfjk asdhf jkasdfhakjs jlkdfhaskdlj hasjkda lksjdhfajks dakd ajlksdhfa ksdha ksd akjsdhfl ksajdhfljkasdhfk jasdhfakls djfhas kjdfhajks dfhals kdfals kdfhals kjdfa lsdhfajk sdfha lkjsdhfal ksjdhflkasdjhfk asjdfhas kdjfhaj klsdfh aksdhfal ksjdfls dkjfh aslkdjf slda jdfa ksjldfha lkjsdfha sjkldfh alsjkdflskh lsjkdfh alskjdf梦" attributes:@{
     NSFontAttributeName:[UIFont systemFontOfSize:18],
     NSForegroundColorAttributeName:[UIColor lightGrayColor],
     NSParagraphStyleAttributeName: param3
    }];
    [att appendAttributedString:desc];
    
    self.view.layer.contents = (__bridge id _Nullable)([att createImageInRect:self.view.bounds]);

    
    
}
- (IBAction)change:(UISlider *)sender {

}

@end
