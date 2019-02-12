//
//  UIViewController+MYAdd.h
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/30.
//  Copyright © 2018 admin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TZImagePickerController.h"
typedef void (^SelectPhotoSuccessBlock)(NSArray<UIImage *> *imageArray);
typedef void (^ActionBlock)(NSString *title);
typedef void (^BtnActionBlock)(UIButton *btn);


@interface UIViewController (MYAdd)<TZImagePickerControllerDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
- (void)selectPhotoWithSuccess:(SelectPhotoSuccessBlock)block maxPhotos:(NSInteger)number;
- (void)selectEditedPhotoWithSuccess:(SelectPhotoSuccessBlock)block;



- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags;
@end


