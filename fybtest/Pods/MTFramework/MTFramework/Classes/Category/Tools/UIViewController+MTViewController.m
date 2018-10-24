//
//  UIViewController+MTViewController.m
//  MTFramework
//
//  Created by Jason Li on 2018/4/18.
//

#import "UIViewController+MTViewController.h"

@implementation UIViewController (MTShowAlert)
- (void)showComingSoon {
    [self showAlertNote:@"Coming Soon!"];
}

- (void)showAlertNote:(NSString *)note {
    [self showAlertNote:note doneTitle:@"OK"];
}

- (void)showAlertNote:(NSString *)note doneTitle:(NSString *)done {
    [self showAlertNote:note doneTitle:done actionHandler:nil];
}

- (void)showAlertNote:(NSString *)note doneTitle:(NSString *)done actionHandler:(void (^)(UIAlertAction *))handler {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@""
                                                                             message:note
                                                                      preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:done style:UIAlertActionStyleCancel handler:handler]];
    [self presentViewController:alertController animated:YES completion:nil];
}

@end


@implementation UIViewController (MTChildController)

- (void)addChildController:(UIViewController *)viewController {
    [self addChildController:viewController frame:CGRectZero];
}

- (void)addChildController:(UIViewController *)viewController frame:(CGRect)frame {
    [self addChildViewController:viewController];
    [viewController.view setFrame:frame];
    [self.view addSubview:viewController.view];
    [viewController didMoveToParentViewController:self];
    
}

@end

