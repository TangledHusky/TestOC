//
//  FDTMasoryCell.m
//  TestOC
//
//  Created by 李亚军 on 2016/12/23.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "FDTMasoryCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"

@implementation FDTMasoryCell{
    UIImageView *icon;
    UILabel *lblTitle;
    UILabel *lblDesc;
    UILabel *lblDesc2;
    UIView *viewComment;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        [self initViews];
        
    }
    
    return self;
}

-(void)initViews{
    //头像icon
    icon = [[UIImageView alloc] init];
    [self.contentView addSubview:icon];
    //高宽40，顶端和左边距离10px
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.contentView).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.width.and.height.offset(40);
    }];
    
    //标题title
    lblTitle = [UILabel new];
    [self.contentView addSubview:lblTitle];
    //高20，左边距离头像10px，顶部距离contentview10px，右边距离15px（为什么是-15，因为ios内左边原点是左上角，印象右边和底部要负数）
    [lblTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(10);
        make.top.equalTo(self.contentView).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
        make.height.mas_equalTo(20);
    }];
    
    //描述内容1
    lblDesc = [UILabel new];
    lblDesc.backgroundColor = [UIColor redColor];
    lblDesc.numberOfLines = 0;
    [self.contentView addSubview:lblDesc];
    //不定高label，顶端距离title 10px，左边距离icon 10px， 右边距离 15px
    [lblDesc mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblTitle.mas_bottom).offset(10);
        make.left.equalTo(icon.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];

    //描述内容2
    lblDesc2 = [UILabel new];
    lblDesc2.numberOfLines = 0;
    lblDesc2.backgroundColor = [UIColor yellowColor];
    [self.contentView addSubview:lblDesc2];
    //不定高label，顶端距离描述内容1 10px，左边距离icon 10px， 右边距离 15px
    [lblDesc2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblDesc.mas_bottom).offset(10);
        make.left.equalTo(icon.mas_right).offset(10);
        make.right.equalTo(self.contentView).offset(-15);
    }];
    
    //其他
    viewComment = [[UIView alloc] init];
    viewComment.backgroundColor = [UIColor orangeColor];
    [self.contentView addSubview:viewComment];
    //高25，顶端距离内容2 10px，左边距离和内容2齐平， 右边距离 15px
    [viewComment mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(lblDesc2.mas_bottom).offset(10);
        make.left.equalTo(lblDesc2);
        make.height.mas_equalTo(25);
        make.right.bottom.equalTo(self.contentView).offset(-15);
    }];

}



-(void)fill:(FDTModel *)model{
    [icon sd_setImageWithURL:[NSURL URLWithString:model.iconUrl] placeholderImage:[UIImage imageNamed:@"iconDefault"]];
    lblTitle.text = model.title;
    lblDesc.text = model.desc;
    lblDesc2.text = model.desc;

    
}
@end
