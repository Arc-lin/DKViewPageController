//
//  DKViewPagerController.m
//  DKViewPagerDemo
//
//  Created by Arclin on 16/4/18.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import "DKViewPagerController.h"
#import "UIView+DKFrame.h"

#define ALRGBColor(r,g,b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

#define ALGlobalBg ALRGBColor(223, 223, 223)

@interface DKViewPagerController ()<UIScrollViewDelegate>
/**
 *  当前选中的按钮
 */
@property (nonatomic,weak) UIButton *selectButton;

/**
 *  标签栏底部的红色指示器
 */
@property (nonatomic,weak) UIView *indicatorView;

/**
 *  顶部的所有标签
 */
@property (nonatomic,weak) UIView *titlesView;

/**
 *  底部的所有内容
 */
@property (nonatomic,weak) UIScrollView *contentView;

@end

@implementation DKViewPagerController

- (instancetype)initWithPageTitles:(NSArray *)pageTitles controllers:(NSArray *)pageControllers
{
    self.pageTitles = pageTitles;
    self.pageControllers = pageControllers;
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = ALGlobalBg;
    
    // 初始化子控制器
    [self setupChildVcs];
    
    // 设置顶部的标签栏
    [self setupTitlesView];
    
    // 设置底部的scrollerView
    [self setupContentView];
}

/**
 *  设置顶部的标签栏
 */
- (void)setupTitlesView
{
    // 标签栏整体
    UIView *titlesView = [[UIView alloc] init];
    if (!self.titleViewBgColor) {
        self.titleViewBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    }
    titlesView.backgroundColor = self.titleViewBgColor;
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 20;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 底部的红色指示器
    UIView *indicatorView = [[UIView alloc] init];
    if (!self.highlightColor) {
        self.highlightColor = [UIColor redColor];
    }
    indicatorView.backgroundColor = self.highlightColor;
    indicatorView.height = 2;
    indicatorView.tag = -1;
    indicatorView.y = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部的子标签
    NSArray *titles = self.pageTitles;
    
    CGFloat width = titlesView.width / titles.count;
    CGFloat height = titlesView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.height =  height;
        button.width = width;
        button.x = i * button.width;
        button.tag = i;
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:self.highlightColor forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        [button addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        
        // 默认点击了第一个按钮
        if (i == 0) {
            button.enabled = NO;
            self.selectButton = button;
            
            // 让按钮内部的label根据文字内容来计算尺寸
            //            [button.titleLabel sizeToFit];
//            self.indicatorView.width = [titles[i] sizeWithAttributes:@{NSFontAttributeName:button.titleLabel.font}].width;
            self.indicatorView.width = button.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    [titlesView addSubview:indicatorView];
}
- (void)titleClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectButton.enabled = YES;
    button.enabled = NO;
    self.selectButton = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
//        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.width = button.width;
        self.indicatorView.centerX  = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
}
/**
 *  初始化子控制器
 */
- (void)setupChildVcs
{
    for (int i = 0; i < _pageControllers.count; i++) {
        UIViewController *vc = _pageControllers[i];
        [self addChildViewController:vc];
    }
}

/**
 *  底部的scrollView
 */
- (void)setupContentView
{
    // 不要自动调整inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    UIScrollView *contentView = [[UIScrollView alloc] init];
    contentView.frame = self.view.bounds;
    contentView.delegate = self;
    contentView.pagingEnabled = YES;
    [self.view insertSubview:contentView atIndex:0]; // 图层位置调整
    
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    self.contentView = contentView;
    
    // 添第一个控制器的View
    [self scrollViewDidEndScrollingAnimation:contentView];
}

#pragma mark - <UIScrollViewDelegate>
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    
    // 取出子控制器
    UITableViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 20; // 设置控制器的View的y值为0 （默认是20）
    vc.view.height = scrollView.height - 20;//设置控制器view的height的值为整个屏幕的高度（默认比屏幕高度少20px）
    // 设置内边距
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame) - 20;
    vc.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 设置滚动条的内边距
    vc.tableView.scrollIndicatorInsets = vc.tableView.contentInset;
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self titleClick:self.titlesView.subviews[index]];
}



@end
