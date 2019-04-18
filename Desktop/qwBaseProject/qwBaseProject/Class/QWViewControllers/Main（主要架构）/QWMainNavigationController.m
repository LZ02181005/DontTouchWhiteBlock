//
//  QWMainNavigationController.m
//  qwBaseProject
//
//  Created by L.Ronaldo on 2019/3/28.
//  Copyright © 2019 apple. All rights reserved.
//

#import "QWMainNavigationController.h"

@interface QWMainNavigationController ()<UINavigationControllerDelegate>

@property (nonatomic ,weak) id PopDelegate;

@end

@implementation QWMainNavigationController


#pragma mark - Lazy

#pragma mark - init

#pragma mark - Life Cycle

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.PopDelegate = self.interactivePopGestureRecognizer.delegate;
    self.delegate = self;
    //设置bar颜色
    [self.navigationBar setBarTintColor:kHEX(@"#FD7C32")];
    
    //设置title颜色
    [self.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : kWhiteColor, NSFontAttributeName : [UIFont boldSystemFontOfSize:18]}];
    
    [self.navigationBar setTintColor:kWhiteColor];
    
    // Do any additional setup after loading the view.
}

#pragma mark - Private

#pragma mark - Public

#pragma mark - Event

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.viewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
        
        //重写backbtn
        UIButton *backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [backButton setFrame:CGRectMake(0, 0, 90, 45)];
        [backButton setImage:[UIImage imageNamed:@"Rectangle 1033"] forState:UIControlStateNormal];
        [backButton setImage:[UIImage imageNamed:@"Rectangle 1033"] forState:UIControlStateHighlighted];
        // 让按钮内部的所有内容左对齐
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        [backButton addTarget:self action:@selector(backBarButtonItemAction) forControlEvents:UIControlEventTouchUpInside];
        backButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0); // 这里微调返回键的位置可以让它看上去和左边紧贴
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
        viewController.hidesBottomBarWhenPushed = YES; // 隐藏底部的工具条
        
    }
    [super pushViewController:viewController animated:animated];
}

-(void) backBarButtonItemAction{
    [self popViewControllerAnimated:YES];
}

#pragma mark - ViewDataSource

#pragma mark - ViewDelegate

#pragma mark - RefreshViewDelegate

#pragma mark - Set & Get

@end
