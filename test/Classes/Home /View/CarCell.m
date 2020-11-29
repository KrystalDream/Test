//
//  CarCell.m
//  test
//
//  Created by 邵梦 on 2020/7/23.
//  Copyright © 2020 ZGH. All rights reserved.
//

#import "CarCell.h"

@implementation CarCell
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
