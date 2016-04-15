//
//  PayPsdView.m
//  FineExAPP
//
//  Created by FineexMac on 15/9/6.
//  Copyright (c) 2015年 FineEX-LF. All rights reserved.
//

#import "PayPsdView.h"

#define DEFAULT_COLOR [UIColor colorWithRed:.7 green:.7 blue:.7 alpha:1]
#define MAIN_COLOR [UIColor colorWithRed:237/255.0f green:114/255.0f blue:19/255.0f alpha:1]

@interface PayPsdView ()<UITextViewDelegate>
{
    UIButton *baseView;
    UILabel *titleLabel;
    UILabel *priceLabel;
    UITextView *psdTextView;
    BOOL keyboardIsShow;
    UIView *inputView;
    NSArray *inputCircles;
    UIButton *confirmButton;
}
@end

@implementation PayPsdView

#pragma mark - 便利弹出
+ (void)showTitle:(NSString *)title amount:(float)amount confirmBlock:(PayPsdViewConfirmBlock)block
{
    PayPsdView *payView = [PayPsdView new];
    payView.title = title;
    payView.amount = amount;
    if (block) payView.confirmBlock = block;
    [payView show];
}

#pragma mark - 初始化
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.alpha = 0;
        self.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:.45];
        _psdLenght = 6;
        //键盘监听
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHide) name:UIKeyboardWillHideNotification object:nil];
        //基本视图
        baseView = [UIButton new];
        baseView.userInteractionEnabled = YES;
        baseView.clipsToBounds = YES;
        baseView.layer.cornerRadius = 5;
        baseView.layer.borderWidth = .5;
        baseView.layer.borderColor = DEFAULT_COLOR.CGColor;
        baseView.backgroundColor = [UIColor colorWithWhite:.97 alpha:.95];
        [self addSubview:baseView];
        //主题
        titleLabel = [UILabel new];
        titleLabel.text = @"支付密码";
        titleLabel.textColor = [UIColor colorWithRed:.2 green:.2 blue:.2 alpha:1];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont systemFontOfSize:20];
        [baseView addSubview:titleLabel];
        //金额
        priceLabel = [UILabel new];
        priceLabel.textAlignment = NSTextAlignmentCenter;
        priceLabel.textColor = MAIN_COLOR;
        [baseView addSubview:priceLabel];
        //输入框
        psdTextView = [UITextView new];
        psdTextView.keyboardType = UIKeyboardTypeNumberPad;
        psdTextView.delegate = self;
        [baseView addSubview:psdTextView];
        //输入视图，用于覆盖遮住psdTextView
        inputView = [UIView new];
        inputView.backgroundColor = [UIColor whiteColor];
        inputView.userInteractionEnabled = NO;
        inputView.clipsToBounds = YES;
        inputView.layer.cornerRadius = 5;
        inputView.layer.borderWidth = .5;
        inputView.layer.borderColor = DEFAULT_COLOR.CGColor;
        [baseView addSubview:inputView];
        //确认按钮
        confirmButton = [UIButton new];
        confirmButton.clipsToBounds = YES;
        confirmButton.layer.cornerRadius = 3;
        confirmButton.backgroundColor = DEFAULT_COLOR;
        confirmButton.enabled = NO;
        [confirmButton setTitle:@"确认支付" forState:UIControlStateNormal];
        [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [confirmButton addTarget:self action:@selector(confirm) forControlEvents:UIControlEventTouchUpInside];
        [baseView addSubview:confirmButton];
    }
    return self;
}


#pragma mark - 布局显示
- (void)show
{
    UIWindow *window = [[UIApplication sharedApplication].delegate window];
    self.frame = window.bounds;
    [window addSubview:self];
    //布局
    CGFloat spcing = 10;
    baseView.bounds = CGRectMake(0, 0, self.frame.size.width-spcing*2, 150);
    CGFloat width = baseView.bounds.size.width-2*spcing;
    titleLabel.frame = CGRectMake(spcing, 0, width, 45);
    [self addLine];
    priceLabel.frame = CGRectMake(spcing, CGRectGetMaxY(titleLabel.frame), width, 50);
    inputView.frame = CGRectMake(spcing, CGRectGetMaxY(priceLabel.frame), width, width/((double)_psdLenght)-5);
    [self addLayerForInputView];
    psdTextView.frame = inputView.frame;
    confirmButton.frame = CGRectMake(spcing, CGRectGetMaxY(inputView.frame) + spcing, width, inputView.frame.size.height);
    baseView.bounds = CGRectMake(0, 0, baseView.bounds.size.width, CGRectGetMaxY(confirmButton.frame) + spcing);
    baseView.center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    //动画
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 1;
    }];
}
//添加标题与其它部分的分割线
- (void)addLine
{
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.frame = CGRectMake(titleLabel.frame.origin.x, CGRectGetMaxY(titleLabel.frame), titleLabel.frame.size.width, 1);
    //路径
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathMoveToPoint(path, nil, 0, 0);
    CGPathAddLineToPoint(path, nil, layer.frame.size.width, 0);
    layer.path = path;
    layer.strokeColor = titleLabel.textColor.CGColor;
    layer.lineWidth = 1;
    layer.masksToBounds = YES;
    layer.lineDashPattern = @[@1, @1];//虚线
    [baseView.layer addSublayer:layer];
}
//为输入视图inputView添加分割线和圆圈
- (void)addLayerForInputView
{
    CGFloat px = inputView.bounds.size.width/((double)_psdLenght);
    CGFloat h = inputView.bounds.size.height;
    //分割线
    for (int i=1; i<_psdLenght; i++) {
        CALayer *layer = [CALayer layer];
        layer.backgroundColor = DEFAULT_COLOR.CGColor;
        layer.frame = CGRectMake(i * px, 0, .5, h);
        [inputView.layer addSublayer:layer];
    }
    //圆圈
    NSMutableArray *array = [NSMutableArray array];
    CGFloat radius = 5;
    for (int i=0; i<_psdLenght; i++) {
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.frame = CGRectMake(i * px, 0, px, h);
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathAddArc(path, nil, px*.5l, h*.5l, radius, 0, 2*M_PI, NO);
        layer.path = path;
        layer.fillColor = titleLabel.textColor.CGColor;
        layer.hidden = YES;
        [inputView.layer addSublayer:layer];
        [array addObject:layer];
    }
    inputCircles = array;
}

#pragma mark - 隐藏
- (void)hidden
{
    [psdTextView resignFirstResponder];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [UIView animateWithDuration:.3 animations:^{
        self.alpha = 0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

#pragma mark - 主题
- (void)setTitle:(NSString *)title
{
    _title = title;
    titleLabel.text = title;
}

#pragma mark - 金额
- (void)setAmount:(float)amount
{
    _amount = amount;
    NSString *str = [NSString stringWithFormat:@"¥%.2f", amount];
    NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
    NSDictionary *attr1 = @{NSFontAttributeName : [UIFont systemFontOfSize:20 weight:.30f]};
    NSDictionary *attr2 = @{NSFontAttributeName : [UIFont systemFontOfSize:28 weight:.30f]};
    [attrStr setAttributes:attr1 range:NSMakeRange(0, 1)];
    [attrStr setAttributes:attr2 range:NSMakeRange(1, str.length-1)];
    priceLabel.attributedText = attrStr;
}

#pragma mark - 确定
- (void)confirm
{
    if (psdTextView.text.length != _psdLenght) {
        return;
    }
    if (_confirmBlock) _confirmBlock(psdTextView.text);
    [self hidden];
}


#pragma mark - 触摸空白
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    if (keyboardIsShow) {
        [psdTextView resignFirstResponder];
    }else{
        [self hidden];
    }
}

#pragma mark - 监视键盘弹出收起
//弹出
- (void)keyboardShow:(NSNotification *)notification
{
    //键盘高度
    NSValue *aValue = [[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGFloat height = [aValue CGRectValue].size.height;
    CGFloat y = self.bounds.size.height - height - baseView.bounds.size.height * .5;
    [UIView animateWithDuration:0.2 animations:^{
        baseView.center = CGPointMake(baseView.center.x, y);
    }];
    keyboardIsShow = YES;
}
//收起
- (void)keyboardHide
{
    [UIView animateWithDuration:0.2 animations:^{
        baseView.center = CGPointMake(baseView.center.x, CGRectGetMidY(self.bounds));
    }];
    keyboardIsShow = NO;
}


#pragma mark - <UITextViewDelegate>协议
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    //返回键
    if (text.length == 0) {
        return YES;
    }
    //只能输入数字
    if ([@"0123456789" rangeOfString:text].length <= 0) {
        return NO;
    }
    //最多6位
    if (range.length>1 || range.location>=_psdLenght) {
        return NO;
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    //密码框圆点
    for (int i=0; i<_psdLenght; i++) {
        CALayer *layer = (CALayer *)inputCircles[i];
        layer.hidden = i>=textView.text.length;
    }
    //确认按钮
    if (textView.text.length == _psdLenght) {
        confirmButton.backgroundColor = MAIN_COLOR;
        confirmButton.enabled = YES;
    }else{
        confirmButton.backgroundColor = DEFAULT_COLOR;
        confirmButton.enabled = NO;
    }
}
@end
