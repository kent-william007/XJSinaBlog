//
//  XJComposeViewController.m
//  XJSinaBlog
//
//  Created by kent on 2016/12/11.
//  Copyright © 2016年 kent. All rights reserved.
//

#import "XJComposeViewController.h"
#import "XJTextView.h"
#import "XJOAuthTool.h"
#import "XJComposeToolBar.h"

@interface XJComposeViewController ()<UITextViewDelegate,XJComposeToolBarDeletate>
{
    XJTextView *text;
    UIBarButtonItem *rightItem;

}
@property(nonatomic,strong)XJComposeToolBar *toolbar;
@end

@implementation XJComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self setupNavigationBar];
    [self setupTextView];
    [self setupToolbar];
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [text becomeFirstResponder];
}
- (void)setupToolbar
{
    _toolbar = [[XJComposeToolBar alloc]init];
    _toolbar.frame = CGRectMake(0, ScreenHeigth-44, ScreenWidth, 44);
    _toolbar.delegate = self;
    [self.view addSubview:_toolbar];
}
- (void)setupTextView
{
    text = [[XJTextView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 300)];
    [self.view addSubview:text];
    text.delegate = self;
    text.alwaysBounceVertical = YES;
    text.font = [UIFont systemFontOfSize:18];
    text.showsVerticalScrollIndicator = NO;
    text.placeHolder = @"分享新鲜事...";
    text.maxLength = 3;
    text.backgroundColor = [UIColor orangeColor];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardwillchange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [text endEditing:YES];
}
- (void)keyboardwillchange:(NSNotification *)noti
{
    NSDictionary *dic = [noti userInfo];
    CGRect rect = [[dic objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    _toolbar.y = rect.origin.y-_toolbar.height;
}

- (void)setupNavigationBar
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;
    XJOAuthModel *model = [XJOAuthTool account];
    NSString *prefix = @"发微博";
    if (model.name) {
        UILabel *titleLabel = [[UILabel alloc]init];
        titleLabel.size = CGSizeMake(ScreenWidth-100, 60);
        titleLabel.center = self.navigationController.navigationBar.center;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.numberOfLines = 0;
        NSString *string = [NSString stringWithFormat:@"%@\n%@",prefix,model.name];
        NSMutableAttributedString *attributeStr = [[NSMutableAttributedString alloc]initWithString:string];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:14] range:[string rangeOfString:prefix]];
        [attributeStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[string rangeOfString:model.name]];
        titleLabel.attributedText = attributeStr;
        self.navigationItem.titleView = titleLabel;
    }else{
        self.title = prefix;
    }
}
- (void)xjComposeToolBar:(XJComposeToolBar *)toolbar didSelectindex:(composeToolButtonType)type
{

    switch (type) {
        case composeCamerabuttonType:
            NSLog(@"相机");
            break;
        case composeEmoticonbuttonType:
        {
            _toolbar.showKeyboardButton = !_toolbar.showKeyboardButton;
             NSLog(@"表情");
        }
            break;

        case composeMentionbuttonType:
             NSLog(@"提到");
            break;

        case composeToolbar_pictureType:
             NSLog(@"图片");
            break;
        case composeTrendbuttonType:
             NSLog(@"趋势");
            break;

            
        default:
            break;
    }
}
- (void)textViewDidChange:(UITextView *)textView
{
    self.navigationItem.rightBarButtonItem.enabled = textView.hasText;
}
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}
- (void)send
{
    NSLog(@"asfaf");
}

@end
