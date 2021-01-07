//
//  GSFastLoginView.m
//  test
//
//  Created by Krystal on 2021/1/6.
//  Copyright © 2021 ZGH. All rights reserved.
//

#import "GSFastLoginView.h"

@interface GSFastLoginView()
@property (weak, nonatomic) IBOutlet UIButton *qqBtn;
@property (weak, nonatomic) IBOutlet UIButton *weChatBtn;
@property (weak, nonatomic) IBOutlet UIButton *billBtn;


@end

@implementation GSFastLoginView
+(instancetype)fastView{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil]firstObject];

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
