//
//  FDTCell.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/23.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "FDTCell.h"
#import "UIImageView+WebCache.h"

@implementation FDTCell


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
//    _icon.layer.cornerRadius = 20;
//    _icon.layer.masksToBounds  = YES;
//    
    _icon.image = [_icon.image cutCircleImage];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)fill:(FDTModel *)model{
    [_icon sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"iconDefault"]];
    _lblTitle.text = model.title;
    _lblDesc.text = model.desc;
    
    
}
@end
