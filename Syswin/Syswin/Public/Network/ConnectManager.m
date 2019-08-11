//
//  ConnectManager.m
//  FYD
//
//  Created by mac on 2017/5/19.
//  Copyright © 2017年 mac. All rights reserved.
//

#import "ConnectManager.h"
#import "AFNetworking.h"
#import "InstantiationRes.h"

@implementation ConnectManager

// https证书校验

+ (AFSecurityPolicy*) getCustomHttpsPolicy:(AFHTTPSessionManager*)manager{
    
    //https 公钥证书配置
    
    NSString *certFilePath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    
    NSData *certData = [NSData dataWithContentsOfFile:certFilePath];
    
    NSSet *certSet = [NSSet setWithObject:certData];
    
    AFSecurityPolicy *policy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate withPinnedCertificates:certSet];
    
    policy.allowInvalidCertificates = YES;
    
    policy.validatesDomainName = NO;//是否校验证书上域名与请求域名一致
    
    //https回调 客户端验证
    
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
        
        NSLog(@"setSessionDidBecomeInvalidBlock");
        
    }];
    
    __weak typeof(manager)weakManger = manager;
    
    __weak typeof(self)weakSelf = self;
    
    //客户端请求验证 重写 setSessionDidReceiveAuthenticationChallengeBlock 方法
    
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        
        __autoreleasing NSURLCredential *credential =nil;
        
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            
            if([weakManger.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                
                if(credential) {
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                } else {
                    
                    disposition =NSURLSessionAuthChallengePerformDefaultHandling;
                    
                }
                
            } else {
                
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
                
            }
            
        } else {
            
            // client authentication
            
            SecIdentityRef identity = NULL;
            
            SecTrustRef trust = NULL;
            
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"AppClint"ofType:@"p12"];
            
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12])
                
            {
                
                NSLog(@"client.p12:not exist");
                
            }
            
            else
                
            {
                
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                
                if ([[weakSelf class] extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data])
                    
                {
                    
                    SecCertificateRef certificate = NULL;
                    
                    SecIdentityCopyCertificate(identity, &certificate);
                    
                    const void*certs[] = {certificate};
                    
                    CFArrayRef certArray =CFArrayCreate(kCFAllocatorDefault, certs,1,NULL);
                    
                    credential =[NSURLCredential credentialWithIdentity:identity certificates:(__bridge  NSArray*)certArray persistence:NSURLCredentialPersistencePermanent];
                    
                    disposition =NSURLSessionAuthChallengeUseCredential;
                    
                }
                
            }
            
        }
        
        *_credential = credential;
        
        return disposition;
        
    }];
    
    return policy;
    
}

+ (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    
    OSStatus securityError = errSecSuccess;
    
    //client certificate password
    
    NSDictionary*optionsDictionary = [NSDictionary dictionaryWithObject:@"214018777270948"
                                      
                                                                 forKey:(__bridge id)kSecImportExportPassphrase];
    
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        
        CFDictionaryRef myIdentityAndTrust =CFArrayGetValueAtIndex(items,0);
        
        const void*tempIdentity =NULL;
        
        tempIdentity= CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        
        *outIdentity = (SecIdentityRef)tempIdentity;
        
        const void*tempTrust =NULL;
        
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        
        *outTrust = (SecTrustRef)tempTrust;
        
    } else {
        
        NSLog(@"Failedwith error code %d",(int)securityError);
        
        return NO;
        
    }
    
    return YES;
    
}


+ (void)sendWithReq:(Basereq *)parameters
           success:(ReqSuccess)success
           failure:(ReqFailure)failure {
    
    NSLog(@"请求接口:%@ -- 请求参数为:%@",parameters.reqUrl,parameters.toDictionary);
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    //可以接受的类型
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    //请求队列的最大并发数
    //    manager.operationQueue.maxConcurrentOperationCount = 5;
    
    //*  请求超时的时间
    manager.requestSerializer.timeoutInterval = 10;
//    [manager.requestSerializer setValue:@"application/x-www-form-urlencoded;charset=UTF-8" forHTTPHeaderField:@"Content-Type"];
    
    //设置cookie
    if ($shared(Public_UserDefault).cookieStr.length) {
        [manager.requestSerializer setValue:$shared(Public_UserDefault).cookieStr forHTTPHeaderField:@"Cookie"];
    }

//    if ([parameters.reqUrl hasPrefix:@"https://"]) {
//        //HTTPS SSL的验证，
//        [manager setSecurityPolicy:[ConnectManager getCustomHttpsPolicy:manager]];
//    }
    
    switch (parameters.reqType) {
        case E_Get:{
            
                [manager GET:parameters.reqUrl parameters:parameters.toDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    
                    if (success) {
                        Baseres *res = [InstantiationRes ETS_InstantiationBaseResWithMainfun:parameters.Mainfun];
                        if (res) {
                            [res unpackReceiveData:responseObject];
                            success(res);
                        } else {
                            NSLog(@"没有在 InstantiationRes 中写解析类");
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            }
            break;
        case E_Upload:{
                [manager POST:parameters.reqUrl parameters:parameters.toDictionary constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
                    [(BaseFileReq *)parameters uploadFile:formData];
                } progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
                    if (success) {
                        Baseres *res = [InstantiationRes ETS_InstantiationBaseResWithMainfun:parameters.Mainfun];
                        if (res) {
                            [res unpackReceiveData:responseObject];
                            success(res);
                        } else {
                            NSLog(@"没有在 InstantiationRes 中写解析类");
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    if (failure) {
                        failure(error);
                    }
                }];
            }
            break;
        case E_Post: default:{
                [manager POST:parameters.reqUrl parameters:parameters.toDictionary progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//                    打印请求回执请求头
                    NSLog(@"Response fields = %@",[((NSHTTPURLResponse*)task.response).allHeaderFields description]);
                    if (success) {
                        Baseres *res = [InstantiationRes ETS_InstantiationBaseResWithMainfun:parameters.Mainfun];
                        if (res) {
                            [res unpackReceiveData:responseObject];
                            success(res);
                        } else {
                            NSLog(@"没有在 InstantiationRes 中写解析类");
                        }
                    }
                } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
                    NSLog(@"fields = %@",[((NSHTTPURLResponse*)task.response).allHeaderFields description]);

                    if (failure) {
                        failure(error);
                    }
                }];
            }
            break;
    }
}


@end
