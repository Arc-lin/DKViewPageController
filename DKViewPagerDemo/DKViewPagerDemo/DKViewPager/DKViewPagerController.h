//
//  DKViewPagerController.h
//  DKViewPagerDemo
//
//  Created by Arclin on 16/4/18.
//  Copyright © 2016年 dankal. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DKViewPagerController : UIViewController

/**
 * 分页标签名
 */
@property (nonatomic,strong) NSArray *pageTitles;

/**
 * 分页控制器数组
 */
@property (nonatomic,strong) NSArray *pageControllers;

/**
 * 标签栏普通状态颜色
 */
@property (nonatomic,strong) UIColor *normalColor;

/**
 *  标签高亮颜色
 */
@property (nonatomic,strong) UIColor *highlightColor;

/**
 * 标签栏背景颜色
 */
@property (nonatomic,strong) UIColor *titleViewBgColor;

/**
 * 主内容视图高度
 */
@property (nonatomic,assign) CGFloat contentViewHeight;

/**
 * 视图y轴的值
 */
@property (nonatomic,assign) CGFloat contentViewY;


- (instancetype)initWithPageTitles:(NSArray *)pageTitles controllers:(NSArray *)pageControllers;

@end
