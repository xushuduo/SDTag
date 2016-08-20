//
//  XSDTagView.m
//  XSDTag
//
//  Created by 许树铎 on 16/8/16.
//  Copyright © 2016年 XuShuduo. All rights reserved.
//

#import "XSDTagView.h"

// 标签背景颜色
#define tagBGColor [UIColor colorWithRed:241.0/255.0 green:85.0/255.0 blue:98.0/255.0 alpha:1]

// 标签文字默认状态颜色
#define tagTextNormalColor [UIColor whiteColor]

// 标签文字高亮时颜色
#define tagTextHighlightedColor [UIColor whiteColor]

// 标签按钮与关闭按钮间线的颜色
#define tagLineColor [UIColor whiteColor]

// 添加按钮文本颜色
#define addBtnTextColor [UIColor colorWithRed:37.0/255.0 green:37.0/255.0 blue:37.0/255.0 alpha:1]

// 添加按钮边框颜色
#define addBtnBorderColor [UIColor colorWithRed:136.0/255.0 green:136.0/255.0 blue:136.0/255.0 alpha:1]

// 是否显示关闭按钮(0为关闭)
static const BOOL isShowCloseBtnBOOL = 1;

// 是否点击删除按钮执行删除(0为关闭)
static const BOOL isAutoDelete = 1;

// 是否显示添加标签按钮(0为关闭)
static const BOOL isShowAddBtn = 1;

// 标签文字大小
static const NSInteger tagTextFontSize = 15;

// 标签View的圆角度数
static const CGFloat tagViewRadius = 3;

// 标签Btn上(下)空隙
static const CGFloat tagBtnTopMargin = 5;

// 标签Btn左(右)空隙
static const CGFloat tagBtnLeftMargin = 10;

// 标签View左(右)间的间隙
static const CGFloat tagViewLeftMargin = 25;

// 标签View上(下)间的间隙
static const CGFloat tagViewTopMargin = 10;

// 标签View与selfViewX的距离
static const CGFloat tagViewWithselfViewXMargin = 10;

@interface XSDTagView ()

@end

@implementation XSDTagView

- (instancetype)initWithTagArray:(XSDTagArray *)tagArray {
    self = [super init];
    if (self) {
        self.tagArray = tagArray;
    }
    return self;
}

- (void)setTagArray:(XSDTagArray *)tagArray {
    // 赋值
    _tagArray = tagArray;
    
    // 移除所有控件
    for (UIView *subView in self.subviews) {
        [subView removeFromSuperview];
    }
    
    // 文字字体
    UIFont *tagTextFont = [UIFont systemFontOfSize:tagTextFontSize];
    // 遍历tagArray
    for (int i = 0; i < tagArray.count; i++) {
        NSString *tag = tagArray[i];
        // 获取tag的Size
        CGSize tagFontSize = [tag boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : tagTextFont} context:nil].size;
        // 计算tagView的高度
        CGFloat tagViewHeight = tagFontSize.height + 2 * tagBtnTopMargin;
        CGFloat tagViewWidth;  // tagView的宽度
        
        // 创建tagView
        UIView *tagView = [UIView new];
        tagView.backgroundColor = tagBGColor;  // 设置背景颜色
        tagView.layer.cornerRadius = tagViewRadius;  // 设置圆角
        tagView.layer.masksToBounds = YES;  // 裁剪
        
        // 创建tagBtn -> tagView
        UIButton *tagBtn = [UIButton buttonWithType:0];
        [tagBtn setTitle:tag forState:UIControlStateNormal];  // 设置标题
        [tagBtn.titleLabel setFont:tagTextFont]; // 设置文本字体大小
        [tagBtn setTitleColor:tagTextNormalColor forState:UIControlStateNormal];  // 设置默认文字颜色
        [tagBtn setTitleColor:tagTextHighlightedColor forState:UIControlStateHighlighted];  // 设置高亮文字颜色
        tagBtn.frame = CGRectMake(0, 0, tagFontSize.width + 2 * tagBtnLeftMargin, tagViewHeight);  // 设置Btn的Frame
        [tagBtn addTarget:self action:@selector(tagClick:) forControlEvents:UIControlEventTouchUpInside];  // 设置按钮点击事件
        [tagBtn addGestureRecognizer:[[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(tagLongClick:)]];
        tagBtn.tag = 250 + i;  // 用来返回index
        [tagView addSubview:tagBtn];  // tagBtn -> tagView
        tagViewWidth = tagBtn.bounds.size.width;  // 获取当前View的宽度
        
        // 判断是否显示关闭按钮
        if (isShowCloseBtnBOOL) {
            // 创建lineView -> tagView
            UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMaxX(tagBtn.frame), 0, 0.5, tagViewHeight)];
            lineView.backgroundColor = tagLineColor;  // 线的颜色
            [tagView addSubview:lineView];  // lineView -> tagView
            
            // 创建closeBtn -> tagView
            UIButton *closeBtn = [UIButton buttonWithType:0];
            [closeBtn setTitle:@"×" forState:UIControlStateNormal];  // 设置文字
            closeBtn.tag = 666 + i;  // 用来返回index
            closeBtn.frame = CGRectMake(CGRectGetMaxX(lineView.frame), 0, tagViewHeight, tagViewHeight);  // 设置Btn的Frame
            [closeBtn addTarget:self action:@selector(closeBtnClick:) forControlEvents:UIControlEventTouchUpInside];  // 设置按钮的点击事件
            [tagView addSubview:closeBtn];  // closeBtn -> tagView
            tagViewWidth = CGRectGetMaxX(closeBtn.frame);  // 获取当前View的宽度
        }
        
        tagView.frame = CGRectMake(0, 0, tagViewWidth, tagViewHeight);  // 设置tagView的Frame
        [self addSubview:tagView];  // tagView -> self
    }
    
    if (isShowAddBtn) {
        // 创建添加按钮
        UIButton *addBtn = [UIButton buttonWithType:0];
        [addBtn setTitle:@"+ 添加标签" forState:UIControlStateNormal];  // 设置标题
        [addBtn.titleLabel setFont:tagTextFont];  // 设置字体大小
        [addBtn setTitleColor:addBtnTextColor forState:UIControlStateNormal];  // 设置文本颜色
        addBtn.layer.borderColor = addBtnBorderColor.CGColor;  // 设置边框颜色
        addBtn.layer.borderWidth = .5;  // 设置边框宽度
        addBtn.layer.cornerRadius = tagViewRadius;  // 设置圆角
        CGSize addBtnTitleFontSize = [addBtn.titleLabel.text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : tagTextFont} context:nil].size;  // 获取标题尺寸
        addBtn.frame = CGRectMake(0, 0, addBtnTitleFontSize.width + 2 * tagBtnLeftMargin, addBtnTitleFontSize.height + 2 * tagBtnTopMargin);  // 设置Btn的Frame
        [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];  // 设置按钮的点击事件
        [self addSubview:addBtn];  // addBtn -> self
    }
}

- (void)tagClick:(UIButton *)btn {
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(tagView:didSelectRowAtIndex:tagName:)]) {
        [self.delegate tagView:self didSelectRowAtIndex:btn.tag - 250 tagName:btn.titleLabel.text];
    }
}

- (void)tagLongClick:(UILongPressGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateBegan) {
        if ([self.delegate respondsToSelector:@selector(tagView:didLongTouchRowAtIndex:tagName:)]) {
            CGPoint point = [sender locationInView:self];
            UIButton *tagBtn = (UIButton *)[self hitTest:point withEvent:nil];
            [self.delegate tagView:self didLongTouchRowAtIndex:tagBtn.tag - 250 tagName:tagBtn.titleLabel.text];
        }
    }
}

- (void)closeBtnClick:(UIButton *)btn {
    // 通过tag取得index
    NSInteger index = btn.tag - 666;
    // 判断是否开启自动删除
    if (isAutoDelete) {
        // 动画
        [UIView animateWithDuration:0.25 animations:^{
            [btn.superview removeFromSuperview];
            [self layoutSubviews];
        } completion:^(BOOL finished) {
            // 删除操作
            NSMutableArray *temp = [self.tagArray mutableCopy];
            [temp removeObjectAtIndex:index];
            self.tagArray = [temp copy];            
        }];
    }
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(tagView:didClickCloseBtnAtIndex:)]) {
        [self.delegate tagView:self didClickCloseBtnAtIndex:index];
    }
}

- (void)addBtnClick {
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(tagView:didClickAddBtnWithTagArray:)]) {
        [self.delegate tagView:self didClickAddBtnWithTagArray:self.tagArray];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 遍历self里的所有控件
    for (int i = 0; i < self.subviews.count; i++) {
        // 取得控件
        UIView *subView = self.subviews[i];
        CGFloat tagViewX;
        CGFloat tagViewY;
        CGFloat tagViewWidth = subView.bounds.size.width;
        CGFloat tagViewHeight = subView.bounds.size.height;
        // 判断是否第一个控件
        if (i > 0) {
            // 取得tagView的X值
            tagViewX = CGRectGetMaxX(self.subviews[i - 1].frame) + tagViewLeftMargin;
            // 取得tagView的Y值
            tagViewY = self.subviews[i - 1].frame.origin.y;
            // 判断剩余的空位是否可以容纳
            if (self.bounds.size.width - tagViewX < tagViewWidth) {
                tagViewX = tagViewWithselfViewXMargin;
                tagViewY += tagViewHeight + tagViewTopMargin;
            }
        } else {
            // 第一个控件就给个初始值
            tagViewX = tagViewWithselfViewXMargin;
            tagViewY = 0;
        }
        // 设置控件的Frame
        subView.frame = CGRectMake(tagViewX, tagViewY, tagViewWidth, tagViewHeight);
    }
    
    // 调用代理方法
    if ([self.delegate respondsToSelector:@selector(tagView:tagViewHeight:)]) {
        [self.delegate tagView:self tagViewHeight:CGRectGetMaxY(self.subviews.lastObject.frame)];
    }
}

@end
