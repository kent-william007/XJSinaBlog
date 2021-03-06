//
//  XJStatusPhotosView.m
//  XJSinaBlog
//
//  Created by kent on 16/6/3.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJStatusPhotosView.h"
#import "XJPhoto.h"
#import "XJStatusPhotoView.h"

#define XJStatusPhotoWH 70
#define XJStatusPhotoMargin 10
#define XJStatusPhotoMaxCol(count) ((count==4)?2:3)


@implementation XJStatusPhotosView

+ (CGSize)sizeWithCount:(int)count
{
    NSInteger maxCols = XJStatusPhotoMaxCol(count);
    NSInteger cols = (count >= maxCols)?maxCols : count;
    CGFloat photosW = cols * XJStatusPhotoWH + (cols - 1) * XJStatusPhotoMargin;
    
    NSInteger rows = (count + maxCols - 1)/maxCols;
    CGFloat photosH = rows * XJStatusPhotoWH + (rows - 1) * XJStatusPhotoMargin;
    
    return CGSizeMake(photosW, photosH);
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    NSInteger photosCount = photos.count;
    
    while (self.subviews.count < photosCount) {
        XJStatusPhotoView *photoview = [[XJStatusPhotoView alloc]init];
        [self addSubview:photoview];
    }
    
    for (int i=0; i< self.subviews.count ; i++) {
        XJStatusPhotoView * photoview = self.subviews[i];
        if (i<photosCount) {
            photoview.photo = photos[i];
            photoview.hidden = NO;
        }else{
            photoview.hidden = YES;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    NSInteger photosCount = self.photos.count;
    int maxCol = XJStatusPhotoMaxCol(photosCount);
    for (int i=0; i<photosCount; i++) {
        XJStatusPhotoView *photoView = self.subviews[i];
        
        int col = i% maxCol;
        
    }
}


@end
