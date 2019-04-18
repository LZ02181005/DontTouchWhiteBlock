//
//  QWMainTabbarController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "QWMainTabbarController.h"
#import "QWMainNavigationController.h"
#import "MineViewController.h"
#import "RepayViewController.h"
#import "FirstViewController.h"
#import "LoginViewController.h"

@interface QWMainTabbarController ()

/**
 * 控制器的数组
 */
@property (nonatomic ,strong) NSArray *vcs;

/**
 * 图形的数组
 */
@property (nonatomic ,strong) NSArray *atts;

@end

@implementation QWMainTabbarController

#pragma mark - Lazy

#pragma mark - init

- (instancetype)init{
    self.tabBarHeight = 60;
    
    NSArray *vcs = [self getViewControllers];
    NSArray *atts = [QWMainTabbarController getItemsAttributes];
    self = [self initWithViewControllers:vcs tabBarItemsAttributes:atts];
    // 设置主题色
    [UITabBar appearance].tintColor = kHEX(@"#F9F9F9");
    [[UITabBar appearance] setBackgroundColor:kHEX(@"#F9F9F9")];
    
    // 设置文字颜色
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kHEX(@"#FA653C") , NSForegroundColorAttributeName, nil] forState:UIControlStateSelected];
    
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kHEX(@"#8E8E93") , NSForegroundColorAttributeName, nil] forState:UIControlStateNormal];
    
    
    // 去除阴影线
    UIImage *image = [UIColor ys_createImageWithColor:kHEX(@"#F9F9F9")];
    [[UITabBar appearance] setShadowImage:image];
    [[UITabBar appearance] setBackgroundImage:image];
    
    return self;
}

#pragma mark - Life Cycle

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //判断是否登录
    if (0) {
        LoginViewController *loginVC = [[LoginViewController alloc] init];
        QWMainNavigationController *loginNav = [[QWMainNavigationController alloc] initWithRootViewController:loginVC];
        [self presentViewController:loginNav animated:YES completion:nil];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

#pragma mark - Private

- (NSArray *)getViewControllers{
    
    
    FirstViewController *firstVC = [FirstViewController new];
    QWMainNavigationController *firstNav = [[QWMainNavigationController alloc] initWithRootViewController:firstVC];
    
    RepayViewController *repayVC = [RepayViewController new];
    QWMainNavigationController *repayNav = [[QWMainNavigationController alloc] initWithRootViewController:repayVC];
    
    MineViewController *mineVC = [MineViewController new];
    QWMainNavigationController *mineNav = [[QWMainNavigationController alloc] initWithRootViewController:mineVC];
    
    
    NSMutableArray *tmp = [@[firstNav, repayNav, mineNav] mutableCopy];
    
    
    return [tmp copy];
    
}

+ (NSArray *)getItemsAttributes{
    
    NSArray *titles = @[@"首页", @"还款", @"我的"];
    NSArray *images = @[@"首页",
                        @"还款",
                        @"我的",
                        ];
    
    
    NSMutableArray *tmp = [@[] mutableCopy];
    
    [titles enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *normalImg = [NSString stringWithFormat:@"%@未选", images[idx]];
        
        NSString *selectImg = [NSString stringWithFormat:@"%@已选", images[idx]];
        
        
        
        NSDictionary *att   = @{
                                CYLTabBarItemTitle : obj,
                                CYLTabBarItemImage : normalImg,
                                CYLTabBarItemSelectedImage : selectImg,
                                };
        [tmp addObject:att];
    }];
    
    
    return [tmp copy];
    
}


#pragma mark - Public

#pragma mark - Event

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get


@end
