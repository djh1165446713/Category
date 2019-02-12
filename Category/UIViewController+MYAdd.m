//
//  UIViewController+MYAdd.m
//  NewElectricity
//
//  Created by 51sdgo on 2018/11/30.
//  Copyright © 2018 admin. All rights reserved.
//

#import "UIViewController+MYAdd.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <AVFoundation/AVFoundation.h>
#import "JH_AlertManager.h"

static SelectPhotoSuccessBlock  _photoBlock;
static BOOL needEdit;
static BOOL isTakePhoto;
static NSInteger photoNumber;


@implementation UIViewController (MYAdd)

- (void)selectPhotoWithSuccess:(SelectPhotoSuccessBlock)block maxPhotos:(NSInteger) number {
    needEdit = NO;
    photoNumber = number;
    [self showActionSheet];
    _photoBlock = [block copy];
}
- (void)selectEditedPhotoWithSuccess:(SelectPhotoSuccessBlock)block {
    needEdit = YES;
    photoNumber = 1;
    [self showActionSheet];
    _photoBlock = [block copy];
}
- (void)showActionSheet {
    if ([UIDevice currentDevice].isPad) {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        [alertController addAction:[UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self takePhoto];
        }]];
        [alertController addAction:[UIAlertAction actionWithTitle:@"从相册获取" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self localPhoto];
        }]];
        UIPopoverPresentationController *popPresenter = [alertController
                                                         popoverPresentationController];
        popPresenter.sourceView = self.view;
        popPresenter.sourceRect = CGRectMake(0, self.view.bottom, SCREEN_WIDTH, 0);
        [self presentViewController:alertController animated:YES completion:nil];
    } else {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照", @"从相册获取", nil];
#pragma clang diagnostic pop
        [actionSheet showInView:self.view];
    }
}
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 0) {
        isTakePhoto = YES;
        [self takePhoto];
        return;
    }
    if (buttonIndex == 1) {
        isTakePhoto = NO;
        [self localPhoto];
        return;
    }
#pragma clang diagnostic pop
}
- (void)takePhoto {
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusDenied) {
        [JH_AlertManager showAlertViewWithAction:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
                    [[UIApplication sharedApplication] openURL:url];
#pragma clang diagnostic pop
                }else{
                    DebugLog(@"error");
                }
            }
        } title:@"无法打开相机" message:@"请打开相机权限" cancelButtonTitle:@"去开启" otherButtonTitles:@"取消", nil];
        
        return;
    }
    if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.allowsEditing = YES;
            picker.delegate = self;
            picker.sourceType = sourceType;
            if ([UIDevice currentDevice].isPad) {
                picker.modalInPopover = YES;
                picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            }
            [self presentViewController:picker animated:YES completion:nil];
            return;
        }
    }
    [JH_AlertManager showAlertViewWithAction:^(NSInteger buttonIndex) {
    } title:@"无法打开相机" message:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
}
- (void)localPhoto {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    ALAuthorizationStatus author = [ALAssetsLibrary authorizationStatus];
    if (author == ALAuthorizationStatusDenied) {
        [JH_AlertManager showAlertViewWithAction:^(NSInteger buttonIndex) {
            if (buttonIndex == 0) {
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if ([[UIApplication sharedApplication] canOpenURL:url]) {
                    [[UIApplication sharedApplication] openURL:url];
                }else{
                    DebugLog(@"error");
                }
            }
        } title:@"无法打开相册" message:@"请打开相册权限" cancelButtonTitle:@"去开启" otherButtonTitles:@"取消", nil];
        return;
    }
#pragma clang diagnostic pop
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        if (needEdit) {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            picker.delegate = self;
            if ([UIDevice currentDevice].isPad) {
                picker.modalInPopover = YES;
                picker.modalPresentationStyle = UIModalPresentationCurrentContext;
            }
            [self presentViewController:picker animated:YES completion:nil];
            return;
        }
        else {
            TZImagePickerController *picker = [[TZImagePickerController alloc] initWithMaxImagesCount:photoNumber delegate:self];
            [picker setDidFinishPickingPhotosWithInfosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto,NSArray<NSDictionary *> *infos){
                NSString *imagePath;
                if (infos.count) {
                    
                    for (NSString *key in infos[0].allKeys) {
                        if ([key isEqualToString:@"PHImageFileURLKey"]) {
                            imagePath = [NSString stringWithFormat:@"%@",[infos[0] valueForKey:@"PHImageFileURLKey"]];
                            NSString *str = [imagePath substringFromIndex:8];
                            NSArray * array2 = [str componentsSeparatedByString:@"/"];
                            break;
                        }
                    }
                }
                if (photos.count > 0) {
                    if (_photoBlock) {
                        _photoBlock(photos);
                    }
                }
            }];
            [self presentViewController:picker animated:YES completion:NULL];
            return;
        }
    }
    [JH_AlertManager showAlertViewWithAction:^(NSInteger buttonIndex) {
    } title:@"无法打开相册" message:nil cancelButtonTitle:@"取消" otherButtonTitles:nil, nil];
}
#pragma mark - UIImagePickerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
}
- (void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = [info objectForKey:UIImagePickerControllerMediaType];
    if ([type isEqualToString:@"public.image"]) {
        if (isTakePhoto) {
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            if (_photoBlock) {
                _photoBlock(@[image]);
            }
            [picker dismissViewControllerAnimated:YES completion:nil];
        }
        else {
            if (needEdit) {
                UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            } else {
                UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
                if (_photoBlock) {
                    _photoBlock(@[image]);
                }
                [picker dismissViewControllerAnimated:YES completion:nil];
            }
        }
    }
}




- (void)addNavigationItemWithImageNames:(NSArray *)imageNames isLeft:(BOOL)isLeft target:(id)target action:(SEL)action tags:(NSArray *)tags
{
    NSMutableArray * items = [[NSMutableArray alloc] init];
    //调整按钮位置
    //    UIBarButtonItem* spaceItem = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    //    //将宽度设为负值
    //    spaceItem.width= -5;
    //    [items addObject:spaceItem];
    NSInteger i = 0;
    for (NSString * imageName in imageNames) {
        UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
        btn.frame = CGRectMake(0, 0, 30, 30);
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        
        if (isLeft) {
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
        }else{
            [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 10, 0, -10)];
        }
        
        btn.tag = [tags[i++] integerValue];
        UIBarButtonItem * item = [[UIBarButtonItem alloc] initWithCustomView:btn];
        [items addObject:item];
        
    }
    if (isLeft) {
        self.navigationItem.leftBarButtonItems = items;
    } else {
        self.navigationItem.rightBarButtonItems = items;
    }
}

@end

