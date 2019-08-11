//
//  Basereq.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "Basereq.h"

@implementation Basereq

-(NSDictionary *)toDictionary{
    return nil;
}

@end


@implementation BaseFileReq
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.filename = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970]];
        self.mimeType = @"image/png";
        self.reqType = E_Upload;
    }
    return self;
}

- (void)uploadFile:(id<AFMultipartFormData>) formData {
    
}

@end

