# SDTag
一款简单易用的标签自定义框架

## Demo
### 标签尺寸自适应
![Demo1](https://github.com/xushuduo/SDTag/raw/master/Demo/demo1.gif)
### 代理方法响应
![Demo2](https://github.com/xushuduo/SDTag/raw/master/Demo/demo2.gif)

## Usage
### 1、传入标签字符串数组

#### 方法1：

```objective-c
	NSArray *test = @[@"#蓝天#", @"#铎哥#", @"#Test#", @"#www.xsd.me#", @"#极客小哆#"];
    XSDTagView *tagView = [[XSDTagView alloc] initWithTagArray:test];
```

#### 方法2：

```objective-c
	NSArray *test = @[@"#蓝天#", @"#铎哥#", @"#Test#", @"#www.xsd.me#", @"#极客小哆#"];
	XSDTagView *tagView = [[XSDTagView alloc] init];
	tagView.tagArray = test;
```

### 2、遵守代理协议

```objective-c
	tagView.delegate = self;	// <XSDTagViewDelegate>
```

### 3、实现对应的代理方法

```objective-c
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
```

## DIY
![DIY_Image](https://github.com/xushuduo/SDTag/raw/master/Demo/demo3.png)


## License

[MIT license](https://github.com/xushuduo/SDTag/blob/master/LICENSE)

## About

作者：** xsdCoder **

博客：[www.xsd.me](http://www.xsd.me/)