//
//  Baseres.h
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Baseres : NSObject

@property (nonatomic,assign) NSInteger code;

@property (nonatomic,strong) NSString *message;

@property (nonatomic,strong) id data;
///请求返回数据解析
- (void)unpackReceiveData:(id)res;

@end

