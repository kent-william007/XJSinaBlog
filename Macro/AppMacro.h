//
//  AppMacro.h
//  XJSinaBlog
//
//  Created by Kent on 15/12/25.
//  Copyright © 2015年 kent. All rights reserved.
//

#ifndef AppMacro_h
#define AppMacro_h

#define image(s) [UIImage imageNamed:s]
#define GET_STRING(s) s?s:@""

#define ScreenWidth   [[UIScreen mainScreen] bounds].size.width
#define ScreenHeigth  [UIScreen mainScreen].bounds.size.height
#define XJColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]


#endif /* AppMacro_h */
