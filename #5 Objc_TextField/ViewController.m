//
//  ViewController.m
//  #5 Objc_TextField
//
//  Created by ChunYi on 2020/3/2.
//  Copyright © 2020 ES711-apple-2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){
    CGRect originFrame;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //將原始TextField高度存起來，以便後來恢復
    originFrame = _mTextField.frame;
    
    //增加鍵盤出現監聽
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //增加鍵盤消失監聽
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    //新增手勢，用來點擊背景消失鍵盤
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]init];
    [tap addTarget:self action:@selector(keyboardHided:)];
    [self.view addGestureRecognizer:tap];
    
}

- (void)keyboardWillShow:(NSNotification *) notification{
    NSDictionary *userInfo = [notification userInfo];
    NSValue *value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardRect = [value CGRectValue];
    int height = keyboardRect.size.height;
    NSLog(@"鍵盤高度:%d", height);
    
    _mTextField.frame = CGRectMake(originFrame.origin.x, originFrame.origin.y - height, originFrame.size.width, originFrame.size.height);
}

- (void)keyboardWillHide:(NSNotification *) notification{
    _mTextField.frame = originFrame;
}

- (void)keyboardHided:(UITapGestureRecognizer *)tap{
    [_mTextField resignFirstResponder];
}

@end
