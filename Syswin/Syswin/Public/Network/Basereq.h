//
//  Basereq.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@interface Basereq : NSObject

@property (nonatomic, assign)  MAIN_FUNC_TYPE Mainfun;              //主功能号
@property (nonatomic, strong)  NSString *reqUrl;               //请求地址
@property (nonatomic, assign)  ReqType reqType;                //请求方式


///请求包体
- (NSDictionary *)toDictionary;

@end


@interface BaseFileReq :Basereq

/**
 *  文件的名称(上传到服务器后，服务器保存的文件名)
 */
@property (nonatomic, copy) NSString *filename;
/**
 *  文件的MIME类型(image/png,image/jpg等)
 */
@property (nonatomic, copy) NSString *mimeType;

- (void)uploadFile:(id<AFMultipartFormData>) formData;

@end
