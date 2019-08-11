//
//  HomepageViewController.m
//  Syswin
//
//  Created by yang.liu on 2019/8/3.
//  Copyright © 2019 syswin. All rights reserved.
//

#import "HomepageViewController.h"


@interface HomepageViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate> {
    id jsRes;
}

@end

@implementation HomepageViewController


-(void)viewDidLoad {
    [super viewDidLoad];
//    NSString *path = kBundleFile(@"htmlPost", @"plist");
//    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
//    NSString *header = dic[@"header"];
//    NSString *content1 = dic[@"content1"];
//    NSString *content2 = dic[@"content2"];
//    NSString *footer1 = dic[@"footer1"];
//    NSString *footer2 = dic[@"footer2"];
//    NSString *post = dic[@"post"];
//    NSString *params = dic[@"params"];
//
//    self.onlineUrl = [NSString stringWithFormat:@"%@://%@%@%@%@%@%@%@",dic[@"main"],dic[@"header"],header.length ? KStringFormat(@".%@",content1) : content1,content2.length ? KStringFormat(@".%@",content2) : content2,footer1.length ? KStringFormat(@".%@",footer1) : footer1,footer2.length ? KStringFormat(@".%@",footer2) : footer2,post.length ? KStringFormat(@":%@",post) : post,params];
    
    self.onlineUrl = kMainHost;
    
}

- (void)jsToNativeType:(NSString *)type data:(id)data {
    
    NSLog(@"%@",data);
    jsRes = data;
    
    if ([type isEqualToString:kJsSaveImage]) {
        if (jsRes) {
            NSURL *url = [NSURL URLWithString:jsRes[@"img"]];
            NSData *data = [NSData dataWithContentsOfURL:url];
            UIImage *image = [UIImage imageWithData: data];
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
            NSString *jsStr = jsRes[@"callback"];
            if (jsStr.length) {
                NSString *JSResult = [NSString stringWithFormat:@"%@()",jsStr];
                __weak typeof(self) _weakself = self;
                [self.webview evaluateJavaScript:JSResult completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                    if (error) {
                        [_weakself showHudText:@"上传图片失败"];
                    }
                }];
            }
        }
    }
    
    else if ([type isEqualToString:kJsCamera]) {
        [self actionSheetphoto];
    }
    
    else if ([type isEqualToString:kJsWechatPay]) {
        if ([jsRes isKindOfClass:[NSDictionary class]]) {
            
//            NSString *urlString   = @"https://wxpay.wxutil.com/pub_v2/app/app_pay.php?plat=ios";
//            //解析服务端返回json数据
//            NSError *error;
//            //加载一个NSURL对象
//            NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
//            //将请求的url数据放到NSData对象中
//            NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
//            if ( response != nil) {
//                NSMutableDictionary *dict = NULL;
//                //IOS5自带解析类NSJSONSerialization从response中解析出数据放到字典中
//                dict = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
//
//                NSLog(@"url:%@",dict);
//                if(dict != nil){
//                    NSMutableString *retcode = [dict objectForKey:@"retcode"];
//                    if (retcode.intValue == 0){
//                        NSMutableString *stamp  = [dict objectForKey:@"timestamp"];
//
//                        //调起微信支付
//                        PayReq* req             = [[PayReq alloc] init];
//                        req.partnerId           = [dict objectForKey:@"partnerid"];
//                        req.prepayId            = [dict objectForKey:@"prepayid"];
//                        req.nonceStr            = [dict objectForKey:@"noncestr"];
//                        req.timeStamp           = stamp.intValue;
//                        req.package             = [dict objectForKey:@"package"];
//                        req.sign                = [dict objectForKey:@"sign"];
//                    }
//                }
//            }
            
            NSDictionary *dicRes = jsRes;
            PayReq *request = [[PayReq alloc] init] ;
            request.partnerId = dicRes[@"mch_id"];
            request.prepayId= dicRes[@"prepay_id"];
            request.package = @"Sign=WXPay";
            request.nonceStr = dicRes[@"nonceStr"];
            NSInteger num = [dicRes[@"timeStamp"] integerValue];
            request.timeStamp = (UInt32)num;
            request.sign= dicRes[@"signType"];
            if ([WXApi isWXAppInstalled]) {
                BOOL isWx = [WXApi sendReq:request];
                if (!isWx) {
                    [self alertTitle:@"温馨提示" message:@"无商户信息" leftTitle:nil actionLeft:nil rightTitle:@"确定" actionRight:nil addView:self];
                }
            } else {
                [self alertTitle:@"温馨提示" message:@"请先安装微信" leftTitle:nil actionLeft:nil rightTitle:@"确定" actionRight:nil addView:self];
            }
        }
    }
    
}

#pragma 图片

-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    [self showHudText:msg];
}

#pragma 相机

- (void)actionSheetphoto {
    UIAlertController *alertcontrol = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
    
    __weak typeof(self) weakSelf = self;
    UIAlertAction *pzAc = [UIAlertAction actionWithTitle:@"相册" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf imagePickerType:UIImagePickerControllerSourceTypePhotoLibrary];
    }];
    UIAlertAction *xcAc = [UIAlertAction actionWithTitle:@"拍照" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf imagePickerType:UIImagePickerControllerSourceTypeCamera];
    }];
    UIAlertAction *cancelaction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
    [alertcontrol addAction:pzAc];
    [alertcontrol addAction:xcAc];
    [alertcontrol addAction:cancelaction];
    [self presentViewController:alertcontrol animated:YES completion:nil];
}

- (void)imagePickerType:(UIImagePickerControllerSourceType)sourceType {
    UIImagePickerController *ip = [[UIImagePickerController alloc] init];
    ip.delegate = self;
    ip.allowsEditing = YES;
    ip.sourceType = sourceType;
    [self presentViewController:ip animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = info[UIImagePickerControllerEditedImage];
    NSData *data = UIImageJPEGRepresentation(image, 0.3);
    
    // 处理图片转换成base64传给H5
    NSString *image64 = [data base64EncodedStringWithOptions:NSDataBase64EncodingEndLineWithCarriageReturn];
    if (((NSString *)jsRes).length) {
        NSString *JSResult = [NSString stringWithFormat:@"%@('%@')",jsRes,image64];
        
        __weak typeof(self)  _weakself = self;
        [self.webview evaluateJavaScript:JSResult completionHandler:^(id data, NSError * _Nullable error) {
            if (error) {
                [_weakself showHudText:@"上传图片失败"];
            }
        }];
    }
}

#pragma mark ---- 支付

-(void)onResp:(BaseResp*)resp{
    if ([resp isKindOfClass:[PayResp class]]){
        PayResp *response=(PayResp *)resp;
        switch(response.errCode){
            case WXSuccess:
                //服务器端查询支付通知或查询API返回的结果再提示成功
                {
                    NSString *jsStr = jsRes[@"callback"];
                    if (jsStr.length) {
                        NSString *JSResult = [NSString stringWithFormat:@"%@()",jsStr];
                        __weak typeof(self) _weakself = self;
                        [self.webview evaluateJavaScript:JSResult completionHandler:^(id _Nullable data, NSError * _Nullable error) {
                            if (error) {
                                [_weakself showHudText:@"调js方法失败"];
                            }
                        }];
                    }
                }
                break;
            default:
                [self alertTitle:@"温馨提示" message:@"支付失败" leftTitle:nil actionLeft:nil rightTitle:@"确定" actionRight:nil addView:self];
                break;
        }
    }
}

@end
