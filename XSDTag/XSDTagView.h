//
//  XSDTagView.h
//  XSDTag
//
//  Created by 许树铎 on 16/8/16.
//  Copyright © 2016年 XuShuduo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NSArray XSDTagArray;

@class XSDTagView;

@protocol XSDTagViewDelegate <NSObject>

@optional

/**
 *  标签被点击时
 */
- (void)tagView:(XSDTagView *)tagView didSelectRowAtIndex:(NSInteger)index tagName:(NSString *)tagName;

/**
 *  标签被长按时
 */
- (void)tagView:(XSDTagView *)tagView didLongTouchRowAtIndex:(NSInteger)index tagName:(NSString *)tagName;

/**
 *  标签的删除按钮被点击时
 */
- (void)tagView:(XSDTagView *)tagView didClickCloseBtnAtIndex:(NSInteger)index;

/**
 *  点击添加按钮时响应
 */
- (void)tagView:(XSDTagView *)tagView didClickAddBtnWithTagArray:(XSDTagArray *)tagArray;

/**
 *  返回tagView的总高度
 */
- (void)tagView:(XSDTagView *)tagView tagViewHeight:(CGFloat)tagViewHeight;

@end

@interface XSDTagView : UIView

- (instancetype)initWithTagArray:(XSDTagArray *)tagArray;

@property (nonatomic, strong) XSDTagArray *tagArray;

@property (nonatomic, weak) id <XSDTagViewDelegate>delegate;

@end
