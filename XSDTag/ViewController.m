//
//  ViewController.m
//  XSDTag
//
//  Created by 许树铎 on 16/8/16.
//  Copyright © 2016年 XuShuduo. All rights reserved.
//

#import "ViewController.h"
#import "XSDTagView.h"

@interface ViewController () <XSDTagViewDelegate>

@property (nonatomic, weak) XSDTagView *tagView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *test = @[@"#蓝天#", @"#铎哥#", @"#Test#", @"#www.xsd.me#", @"#极客小哆#"];
    XSDTagView *tagView = [[XSDTagView alloc] initWithTagArray:test];
    tagView.delegate = self;
    tagView.frame = CGRectMake(0, 20, self.view.bounds.size.width, 100);
    self.tagView = tagView;
    [self.view addSubview:tagView];
}

#pragma mark - <XSDTagViewDelegate>
- (void)tagView:(XSDTagView *)tagView didSelectRowAtIndex:(NSInteger)index tagName:(NSString *)tagName {
    NSLog(@"点击了->%zd", index);
}

- (void)tagView:(XSDTagView *)tagView didLongTouchRowAtIndex:(NSInteger)index tagName:(NSString *)tagName {
    NSLog(@"长按了->%zd", index);
}

- (void)tagView:(XSDTagView *)tagView didClickCloseBtnAtIndex:(NSInteger)index {
    NSLog(@"删除了->%zd", index);
}

- (void)tagView:(XSDTagView *)tagView didClickAddBtnWithTagArray:(XSDTagArray *)tagArray {
    NSLog(@"点击了添加按钮");
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"添加标签" message:@"请输入标签名称[不需要输入#]" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.placeholder = @"请输入标签名称";
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        UITextField *textField = alert.textFields.firstObject;
        if (![textField.text isEqualToString:@""]) {
            if (![textField.text containsString:@"#"]) {
                textField.text = [NSString stringWithFormat:@"#%@#", textField.text];
            }
            NSMutableArray *temp = [self.tagView.tagArray mutableCopy];
            [temp addObject:textField.text];
            self.tagView.tagArray = [temp copy];
        }
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)tagView:(XSDTagView *)tagView tagViewHeight:(CGFloat)tagViewHeight {
    NSLog(@"tagView的高度：%lf", tagViewHeight);
    CGRect tagViewFrame = self.tagView.frame;
    tagViewFrame.size.height = tagViewHeight;
    self.tagView.frame = tagViewFrame;
}

@end
