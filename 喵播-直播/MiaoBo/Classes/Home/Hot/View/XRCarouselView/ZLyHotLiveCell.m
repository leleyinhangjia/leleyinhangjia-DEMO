//
//  ZLyHotLiveCell.m
//  MiaoBo
//
//  Created by leleyinhangjia on 2017/3/10.
//  Copyright © 2017年 leleyinhangjia All rights reserved.
//

#import "ZLyHotLiveCell.h"
#import "ZLyLive.h"
#import "UIImage+ALinExtension.h"
#import "UIImageView+WebCache.h"


@interface ZLyHotLiveCell ()
/** 头像 */
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;//头像
/** 主播地址 */
@property (weak, nonatomic) IBOutlet UIButton *locationBtn;//地址
/** 主播名字 */
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;//主播名字
/** 主播等级 */
@property (weak, nonatomic) IBOutlet UIImageView *startView;
/** 观看人数 */
@property (weak, nonatomic) IBOutlet UILabel *chaoyangLabel;
/** 封面 */
@property (weak, nonatomic) IBOutlet UIImageView *bigPicView;

@end

@implementation ZLyHotLiveCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}
- (void)setLive:(ZLyLive *)live
{
    _live = live;
    [self.headImageView sd_setImageWithURL:[NSURL URLWithString:live.smallpic] placeholderImage:[UIImage imageNamed:@"placeholder_head"] options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage  circleImage:image borderColor:[UIColor redColor] borderWidth:1];
        self.headImageView.image = image;
    }];
    
    self.nameLabel.text = live.myname;
    // 如果没有地址, 给个默认的地址
    if (!live.gps.length) {
        live.gps = @"喵星";
    }
    [self.locationBtn setTitle:live.gps forState:UIControlStateNormal];
    [self.bigPicView sd_setImageWithURL:[NSURL URLWithString:live.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    self.startView.image  = live.starImage;
    self.startView.hidden = !live.starlevel;
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", live.allnum];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", live.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:KeyColor range:range];
    self.chaoyangLabel.attributedText = attr;
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
