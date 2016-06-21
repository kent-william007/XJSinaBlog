//
//  XJStatusPhotoView.m
//  XJSinaBlog
//
//  Created by kent on 16/6/3.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJStatusPhotoView.h"
#import "UIImageView+WebCache.h"
#import "XJPhoto.h"

@implementation XJStatusPhotoView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.contentMode = UIViewContentModeScaleAspectFill;
    }
    return self;
}

- (void)setPhoto:(XJPhoto *)photo
{
    _photo = photo;
    [self sd_setImageWithURL:[NSURL URLWithString:photo.thumbnail_pic] placeholderImage:[UIImage imageNamed:@"timeline_image_placeholder"]];
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

@end
