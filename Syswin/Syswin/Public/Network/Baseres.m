//
//  Baseres.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Baseres.h"

@implementation Baseres

- (void)unpackReceiveData:(id)res {
    NSLog(@"unpackReceiveData=%@",res);
    self.code = [res[@"status"] integerValue];
    self.message = res[@"msg"];
    self.data = res[@"Data"];
}

@end

