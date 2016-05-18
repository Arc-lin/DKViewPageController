#DKViewPageController


####还没做完。。研究中。。。


****

###模仿安卓的ViewPageFragment

<br/>
**使用方法**

1.创建子控制器

```
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    ViewController2 *vc3 = [[ViewController3 alloc] init];
```

2.调用主方法


- titles：标题
- controllers：子控制器


```
	DKViewPagerController *vc = [[DKViewPagerController alloc] initWithPageTitles:@[@"视图1",@"视图2",@"视图3"] controllers:@[vc1,vc2,vc3]];
```

3.附加属性

- highlightColor 标签高亮颜色 
- normalColor 标签默认颜色
- titleViewBgColor 标签栏背景颜色
- contentViewY y方向的值
- contentViewHeight 视图高度

```
    vc.contentViewY = 200;
    vc.contentViewHeight = 200;
	vc.highlightColor = [UIColor redColor];
    vc.titleViewBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    vc.normalColor = [UIColor grayColor];
```
4.完整代码示例（AppDelegate.m）

```
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    UIWindow *window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    ViewController1 *vc1 = [[ViewController1 alloc] init];
    ViewController2 *vc2 = [[ViewController2 alloc] init];
    ViewController2 *vc3 = [[ViewController3 alloc] init];
    DKViewPagerController *vc = [[DKViewPagerController alloc] initWithPageTitles:@[@"视图1",@"视图2",@"视图3"] controllers:@[vc1,vc2,vc3]];
    vc.contentViewY = 200;
    vc.contentViewHeight = 200;
    vc.highlightColor = [UIColor redColor];
    vc.titleViewBgColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    vc.normalColor = [UIColor grayColor];
    window.rootViewController = vc;
    
    self.window = window;
    [self.window makeKeyAndVisible];
    
    return YES;
}
```