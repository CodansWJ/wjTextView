//
//  WJTextView.swift
//  MyDemo
//
//  Created by 汪俊 on 16/4/1.
//  Copyright © 2016年 wangjun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TextViewImagePickerDelegate;


@interface UITextView (Helper)

// 在长按菜单设置添加图片
- (void)addSelectImageMenuText:(NSString *)selectImageMenuText;


- (void)addSelectImageMenuText:(NSString *)selectImageMenuText
                cameraMenuText:(NSString *)cameraMenuText;


@property (nonatomic, assign) id<TextViewImagePickerDelegate> imagePickerDelegate;


- (NSArray *)attachedImages;


// 添加图片的方法
- (void)_selectImageWithAlertForGalleryOrCamera:(id)sender;

@end


@protocol TextViewImagePickerDelegate <NSObject>

@optional

- (void)textViewWillShowImageSelecteController:(UITextView *)textView;


- (void)textViewDidShowImageSelecteController:(UITextView *)textView;


- (void)textViewWillHideImageSelecteController:(UITextView *)textView;


- (void)textViewDidHideImageSelecteController:(UITextView *)textView;

@end