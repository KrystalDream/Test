//
//  PrivacyViewController.m
//  test
//
//  Created by Krystal on 2020/11/26.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "PrivacyViewController.h"

@interface PrivacyViewController ()<UITextViewDelegate>

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    //欢迎使用中国债券信息网app！为了保护您的隐私和使用安全，请您务必仔细阅读我们的《用户协议》和《隐私政策》。在确认充分理解并同意后再开始使用此应用。感谢！
    NSString *str1 = @"欢迎使用中国债券信息网app！为了保护您的隐私和使用安全，请您务必仔细阅读我们的";
    NSString *str2 = @"《用户协议》";
    NSString *str3 = @"和";
    NSString *str4 = @"《隐私政策》";
    NSString *str5 = @"。在确认充分理解并同意后再开始使用此应用。感谢！";

    NSString *str = [NSString stringWithFormat:@"%@%@%@%@%@",str1,str2,str3,str4,str5];
    
    NSRange range1 = [str rangeOfString:str1];
    NSRange range2 = [str rangeOfString:str2];
    NSRange range3 = [str rangeOfString:str3];
    NSRange range4 = [str rangeOfString:str4];
    NSRange range5 = [str rangeOfString:str5];

    
    UITextView *textView = [[UITextView alloc] init];
    textView.frame = CGRectMake(40, 100, 300, 350);
    textView.editable = NO;
    textView.delegate = self;
    [self.view addSubview:textView];
    
    
    NSMutableAttributedString *mastring = [[NSMutableAttributedString alloc] initWithString:str attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:22.0f]}];
    
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range1];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range2];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range3];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor greenColor] range:range4];
    [mastring addAttribute:NSForegroundColorAttributeName value:[UIColor blackColor] range:range5];

    
    // 1.必须要用前缀（firstPerson，secondPerson），随便写但是要有
    // 2.要有后面的方法，如果含有中文，url会无效，所以转码
    
    NSString *valueString2 = [[NSString stringWithFormat:@"firstPerson://%@",str2] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    NSString *valueString4 = [[NSString stringWithFormat:@"secondPerson://%@",str4] stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    
    [mastring addAttribute:NSLinkAttributeName value:valueString2 range:range2];
    [mastring addAttribute:NSLinkAttributeName value:valueString4 range:range4];
    
    textView.attributedText = mastring;
    
}
- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    
    if ([[URL scheme] isEqualToString:@"firstPerson"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第一个文字:%@",[URL host]];
        [self clickLinkTitle:titleString];
        
        return NO;
        
    } else if ([[URL scheme] isEqualToString:@"secondPerson"]) {
        
        NSString *titleString = [NSString stringWithFormat:@"你点击了第二个文字:%@",[URL host]];
        [self clickLinkTitle:titleString];
        
        return NO;
        
    }
    
    return YES;
    
}
- (void)clickLinkTitle:(NSString *)title {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:title preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *action = [UIAlertAction actionWithTitle:@"好的" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:action];
    
    [self presentViewController:alert animated:YES completion:nil];
    
}


@end
