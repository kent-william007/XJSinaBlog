//
//  XJStatusCell.m
//  XJSinaBlog
//
//  Created by kent on 16/6/1.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJStatusCell.h"
#import "XJStatus.h"
#import "XJUser.h"
#import "XJStatusFrame.h"
#import "UIImageView+WebCache.h"
#import "XJPhoto.h"
#import "XJStatusToolbar.h"

@interface XJStatusCell()

/** 原创微博整体 */
@property (nonatomic, weak) UIView *originalView;
/** 头像 */
@property (nonatomic, weak) UIImageView *iconView;
/** 会员图标 */
@property (nonatomic, weak) UIImageView *vipView;
/** 配图 */
@property (nonatomic, weak) UIImageView *photoView;
/** 昵称 */
@property (nonatomic, weak) UILabel *nameLabel;
/** 时间 */
@property (nonatomic, weak) UILabel *timeLabel;
/** 来源 */
@property (nonatomic, weak) UILabel *sourceLabel;
/** 正文 */
@property (nonatomic, weak) UILabel *contentLabel;

/* 转发微博 */
/** 转发微博整体 */
@property (nonatomic, weak) UIView *retweetView;
/** 转发微博正文 + 昵称 */
@property (nonatomic, weak) UILabel *retweetContentLabel;
/** 转发配图 */
@property (nonatomic, weak) UIImageView *retweetPhotoView;

/** 工具条 */
@property (nonatomic, weak) XJStatusToolbar *toolbar;
@end

@implementation XJStatusCell

+ (instancetype)cellWithTableview:(UITableView *)tableview
{
    static NSString *ID = @"status";
    XJStatusCell * cell = [tableview dequeueReusableCellWithIdentifier:ID];
    if (!cell) {
        cell = [[XJStatusCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupOriginal];
        
        [self setupRetweet];
        
        [self setupToolbar];
    }
    return self;
}

/**
 *  初始化原创微博
 */
- (void)setupOriginal
{
    /** 原创微博整体 */
    UIView *originalView = [[UIView alloc]init];
    [self.contentView addSubview:originalView];
    originalView.backgroundColor = [UIColor whiteColor];
    _originalView = originalView;
    
    /** 头像 */
    UIImageView *iconView = [[UIImageView alloc]init];
    iconView.contentMode = UIViewContentModeCenter;
    [_originalView addSubview:iconView];
    _iconView = iconView;
    
    /** 昵称 */
    UILabel *nameLabel = [[UILabel alloc]init];
    nameLabel.font = XJStatusCellNameFont;
    [_originalView addSubview:nameLabel];
    _nameLabel = nameLabel;
    
    
    /** 会员图标 */
    UIImageView *vipView = [[UIImageView alloc]init];
    vipView.contentMode = UIViewContentModeCenter;
    [_originalView addSubview:vipView];
    _vipView = vipView;
    
    /** 配图 */
    UIImageView *photoView = [[UIImageView alloc]init];
    //        photoView.contentMode = UIViewContentModeCenter;
    [_originalView addSubview:photoView];
    _photoView = photoView;
    
    
    /** 时间 */
    UILabel *timeLabel = [[UILabel alloc]init];
    timeLabel.font = XJStatusCellTimeFont;
    [_originalView addSubview:timeLabel];
    _timeLabel = timeLabel;
    
    /** 来源 */
    UILabel *sourceLabel = [[UILabel alloc]init];
    sourceLabel.font = XJStatusCellSourceFont;
    [_originalView addSubview:sourceLabel];
    _sourceLabel = sourceLabel;
    
    /** 正文 */
    UILabel *contentLabel = [[UILabel alloc]init];
    contentLabel.font = XJStatusCellContentFont;
    contentLabel.numberOfLines = 0;
    [_originalView addSubview:contentLabel];
    _contentLabel = contentLabel;

}

/**
 *  初始化转发微博
 */
- (void)setupRetweet
{
    UIView *retweetView = [[UIView alloc]init];
    retweetView.backgroundColor = XJColor(240, 240, 240);
    [self.contentView addSubview:retweetView];
    _retweetView = retweetView;
    
    UILabel *retweetContentLabel = [[UILabel alloc]init];
    retweetContentLabel.numberOfLines = 0;
    retweetContentLabel.font = XJStatusCellRetweetContentFont;
    [retweetView addSubview:retweetContentLabel];
    _retweetContentLabel = retweetContentLabel;
    
    UIImageView *retweetPhotoView = [[UIImageView alloc]init];
    [retweetView addSubview:retweetPhotoView];
    _retweetPhotoView = retweetPhotoView;
    
}

/**
 *  初始化工具条
 */
- (void)setupToolbar
{
    XJStatusToolbar *toolbar = [[XJStatusToolbar alloc]init];
    [self.contentView addSubview:toolbar];
    _toolbar = toolbar;
}

- (void)setStatusFrame:(XJStatusFrame *)statusFrame
{
    _statusFrame = statusFrame;
    XJStatus *status = statusFrame.status;
    XJUser *user = status.user;
    
    self.originalView.frame = statusFrame.originalViewF;
    
    self.iconView.frame = statusFrame.iconViewF;
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    if (user.isVip) {
        self.vipView.hidden = NO;
        self.vipView.frame = statusFrame.vipViewF;
        NSString *vipName = [NSString stringWithFormat:@"common_icon_membership_level%d",user.mbrank];
        self.vipView.image = [UIImage imageNamed:vipName];
        self.nameLabel.textColor = [UIColor orangeColor];
    }else{
        self.nameLabel.textColor = [UIColor blackColor];
        self.vipView.hidden = YES;
    }
    
    /** 配图 */
    if(status.pic_urls.count){
        self.photoView.frame = statusFrame.photoViewF;
        XJPhoto *photo = [status.pic_urls firstObject];
//        photo.thumbnail_pic = [status.pic_urls firstObject][@"thumbnail_pic"];
        [self.photoView sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
        self.photoView.hidden = NO;
        self.photoView.backgroundColor = [UIColor redColor];
    }else{
        self.photoView.hidden = YES;
    }
    
    self.nameLabel.text = user.name;
    self.nameLabel.frame = statusFrame.nameLabelF;
    
    self.timeLabel.text = status.created_at;
    self.timeLabel.frame = statusFrame.timeLabelF;
    
    self.sourceLabel.text = status.source;
    self.sourceLabel.frame = statusFrame.sourceLabelF;
    
    self.contentLabel.text = status.text;
    self.contentLabel.frame = statusFrame.contentLabelF;
    
    
    if (status.retweeted_status) {
        XJStatus *retweeted_status = status.retweeted_status;
        XJUser *retweeted_status_user = retweeted_status.user;
        
        self.retweetView.hidden = NO;
        self.retweetView.frame = statusFrame.retweetViewF;
        
        NSString *retweetContent = [NSString stringWithFormat:@"@%@:%@",retweeted_status_user.name,retweeted_status.text];
        self.retweetContentLabel.text = retweetContent;
        self.retweetContentLabel.frame = statusFrame.retweetContentLabelF;
        
        
        if (retweeted_status.pic_urls.count) {
            self.retweetPhotoView.frame = statusFrame.retweetPhotoViewF;
            XJPhoto *retweetPhotoView = [retweeted_status.pic_urls firstObject];
            [self.retweetPhotoView sd_setImageWithURL:[NSURL URLWithString:retweetPhotoView.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
            self.retweetPhotoView.hidden = NO;
        }else{
            self.retweetPhotoView.hidden = YES;
        }
        
    }else{
        self.retweetView.hidden = YES;
    }
    
    
    
    self.toolbar.frame = statusFrame.toolbarF;
    self.toolbar.status = status;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

@end
