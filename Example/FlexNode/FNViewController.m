 

#import "FNViewController.h"
#import <FNFlexNode.h>
#import "FNCoreTextView.h"
#import "FNRunDelegate.h"
@interface FNViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet FNCoreTextView *CoreTextView;

@end

@implementation FNViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

     self.CoreTextView.constraint = UIScreen.mainScreen.bounds.size.width;
     NSMutableAttributedString* att = [[NSMutableAttributedString alloc] init];
     FNRunDelegate* run = [[FNRunDelegate alloc] initWithFont:[UIFont systemFontOfSize:128] withImage:[UIImage imageNamed:@"avatar"]];
     run.cornerRadius = 64;
     NSMutableParagraphStyle * param = [NSMutableParagraphStyle new];
     param.alignment = NSTextAlignmentCenter;
     param.paragraphSpacing = 0;
     NSAttributedString * a = [[NSAttributedString alloc] initWithRunDelegate:run paragraphStyle:param];
     [att appendAttributedString:a];
     NSMutableParagraphStyle * param2 = [NSMutableParagraphStyle new];
     param2.alignment = NSTextAlignmentCenter;
     param2.paragraphSpacing = 64;
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
     param3.lineSpacing = 5;
    param2.alignment = NSTextAlignmentCenter;
     NSAttributedString * desc = [[NSAttributedString alloc] initWithString:@"\n人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的人生如梦  旌啊三等奖及火锅阿斯顿发啊手机的风格旌啊的红色复古啊就是的风格及阿萨德和规范及阿斯顿法国将阿斯顿法国阿加水淀粉啊就是地方啊就是地方啊就是地方叫阿道夫啊就是地方啊就是地方啊觉得舒服是地方啊就是地方啊手机的风格啊手机的风格啊手机地方噶时间地方噶圣诞节发噶时间地方噶圣诞节发过啊手机的风格啊就是的饭噶多少发动机舒服啊手机的饭啊就是的饭是的" attributes:@{
         NSFontAttributeName:[UIFont systemFontOfSize:12],
         NSForegroundColorAttributeName:[UIColor lightGrayColor],
         NSParagraphStyleAttributeName: param3
     }];
     [att appendAttributedString:desc];

     self.CoreTextView.attributeString = att;

}
- (IBAction)change:(UISlider *)sender {

}

@end
