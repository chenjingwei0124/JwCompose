//
//  JwHttpManager.m
//  JwCompose
//
//  Created by 陈警卫 on 2019/9/11.
//  Copyright © 2019 陈警卫. All rights reserved.
//

#import "JwHttpManager.h"
#import "JwHttpHelper.h"
#import "JwServiceDefine.h"

@interface JwHttpManager ()

@property (nonatomic, strong) AFHTTPSessionManager *session;
@property (nonatomic, strong) AFURLSessionManager *URLSession;

@end

@implementation JwHttpManager

+ (JwHttpManager *)sharedManager{
    static JwHttpManager *httpManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        httpManager = [[JwHttpManager alloc] init];
    });
    return httpManager;
}

- (NSString *)basePathWithPoint:(NSString *)point{
    return [NSString stringWithFormat:@"%@%@", kServiceBaseURL, point];
}

- (void)GET:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    point = [self basePathWithPoint:point];
    [self GET:params url:point success:^(id data) {
        //此处可数据处理
        success(data);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)POST:(NSDictionary *)params point:(NSString *)point success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    point = [self basePathWithPoint:point];
    [self POST:params url:point success:^(id data) {
        //此处可数据处理
        success(data);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)upload:(NSDictionary *)params point:(NSString *)point imageDictionary:(NSDictionary *)imageDictionary success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    point = [self basePathWithPoint:point];
    [self upload:params url:point imageDictionary:imageDictionary success:^(id data) {
        //此处可数据处理
        success(data);
    } failure:^(NSError *error) {
        failure(error);
    }];
}

- (void)GET:(NSDictionary *)params url:(NSString *)url success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    DLog(@"%@--%@", url, params);
    [self.session GET:url parameters:params progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@--%@", url, responseObject);
        if ([JwHttpHelper httpManager:self shouldSuccessWithResponse:responseObject]) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@--%@", url, error);
        failure(error);
        [JwHttpHelper httpManager:self didResultWithResponse:nil error:error];
    }];
}

- (void)POST:(NSDictionary *)params url:(NSString *)url success:(void (^)(id data))success failure:(void (^)(NSError * error))failure{
    
    DLog(@"%@--%@", url, params);
    [self.session POST:url parameters:params progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@--%@", url, responseObject);
        if ([JwHttpHelper httpManager:self shouldSuccessWithResponse:responseObject]) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@--%@", url, error);
        failure(error);
        [JwHttpHelper httpManager:self didResultWithResponse:nil error:error];
    }];
}


- (void)upload:(NSDictionary *)params url:(NSString *)url imageDictionary:(NSDictionary *)imageDictionary success:(void(^)(id data))success failure:(void(^)(NSError *error))failure{
    
    DLog(@"%@--%@", url, params);
    //imageDictionary 必须 imageName : image
    [self.session POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSArray *imageKeys = [imageDictionary allKeys];
        for (NSInteger i = 0; i < imageKeys.count; i++) {
            NSData *data = UIImageJPEGRepresentation(imageDictionary[imageKeys[i]], 0.5);
            //上传时使用当前的系统时间做为文件名
            DLog(@"images.data--%lu", (unsigned long)data.length);
            NSDateFormatter *formatter  = [[NSDateFormatter alloc] init];
            formatter.dateFormat  = @"yyyyMMddHHmmssSSS";
            NSString *fileName = [NSString stringWithFormat:@"%@.jpeg", [formatter stringFromDate:[NSDate date]]];
            [formData appendPartWithFileData:data name:imageKeys[i] fileName:fileName mimeType:@"image/jpeg"];
        }
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        DLog(@"%@--%@", url, responseObject);
        if ([JwHttpHelper httpManager:self shouldSuccessWithResponse:responseObject]) {
            success(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        DLog(@"%@--%@", url, error);
        failure(error);
        [JwHttpHelper httpManager:self didResultWithResponse:nil error:error];
    }];
}

- (NSURLSessionDownloadTask *)downloadWithUrl:(NSString *)url progress:(void (^)(NSProgress *downloadProgress))progress success:(void (^)(NSURL * filePath))success failure:(void (^)(NSError * error))failure{
    
    NSURL *URL = [NSURL URLWithString:url];
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSString *cachesPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    [[NSFileManager defaultManager] removeItemAtPath:cachesPath error:nil];
    
    NSURLSessionDownloadTask *task = nil;
    Weak(task);
    task = [self.URLSession downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        //下载进程
        if (progress) {
            progress(downloadProgress);
        }
    } destination:^NSURL * _Nonnull(NSURL * _Nonnull targetPath, NSURLResponse * _Nonnull response) {
        //正在下载
        NSString *path = [cachesPath stringByAppendingPathComponent:response.suggestedFilename];
        return [NSURL fileURLWithPath:path];
        
    } completionHandler:^(NSURLResponse * _Nonnull response, NSURL * _Nullable filePath, NSError * _Nullable error) {
        //下载完成
        if (error) {
            [wtask cancel];
            if (failure) {
                failure(error);
                [[NSFileManager defaultManager] removeItemAtPath:[filePath path] error:nil];
            }
        }else{
            if (success) {
                success(filePath);
            }
        }
    }];
    [task resume];
    return task;
}

- (AFURLSessionManager *)URLSession{
    if (!_URLSession) {
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
        AFURLSessionManager *URLSession = [[AFURLSessionManager alloc] initWithSessionConfiguration:configuration];
        _URLSession = URLSession;
    }
    return _URLSession;
}

- (AFHTTPSessionManager *)session{
    if (!_session) {
        AFHTTPSessionManager *session = [AFHTTPSessionManager manager];
        session.requestSerializer.timeoutInterval = 15;
        //接收类型
        //session.requestSerializer = [AFJSONRequestSerializer serializer];
        session.responseSerializer = [AFJSONResponseSerializer serializer];
        session.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/html", @"text/json", @"application/json", @"text/plain", @"text/javascript", nil];
        //关闭缓存避免干扰测试
        session.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringLocalCacheData;
        //单项验证
        //[session setSecurityPolicy:[self customSecurityPolicy]];
        //双向验证
        //[self checkCredential:session];
        _session = session;
    }
    return _session;
}

- (AFSecurityPolicy *)customSecurityPolicy {
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy policyWithPinningMode:AFSSLPinningModeCertificate];
    //生产
    //NSData *cerData = [[NSData alloc] initWithBase64EncodedString:kHttpsCerData options:0];
    //测试
    //NSString *cerPath = [[NSBundle mainBundle] pathForResource:@"server" ofType:@"cer"];
    //NSData *cerData = [NSData dataWithContentsOfFile:cerPath];
    //NSSet *dataSet = [NSSet setWithArray:@[cerData]];
    //[securityPolicy setPinnedCertificates:dataSet];
    
    [securityPolicy setAllowInvalidCertificates:YES];
    [securityPolicy setValidatesDomainName:NO];
    return securityPolicy;
}

//校验证书
- (void)checkCredential:(AFURLSessionManager *)manager{
    [manager setSessionDidBecomeInvalidBlock:^(NSURLSession * _Nonnull session, NSError * _Nonnull error) {
    }];
    __weak typeof(manager)weakManager = manager;
    [manager setSessionDidReceiveAuthenticationChallengeBlock:^NSURLSessionAuthChallengeDisposition(NSURLSession*session, NSURLAuthenticationChallenge *challenge, NSURLCredential *__autoreleasing*_credential) {
        NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
        __autoreleasing NSURLCredential *credential =nil;
        //NSLog(@"authenticationMethod=%@",challenge.protectionSpace.authenticationMethod);
        //判断是核验客户端证书还是服务器证书
        if([challenge.protectionSpace.authenticationMethod isEqualToString:NSURLAuthenticationMethodServerTrust]) {
            // 基于客户端的安全策略来决定是否信任该服务器，不信任的话，也就没必要响应挑战
            if([weakManager.securityPolicy evaluateServerTrust:challenge.protectionSpace.serverTrust forDomain:challenge.protectionSpace.host]) {
                //创建挑战证书（注：挑战方式为UseCredential和PerformDefaultHandling都需要新建挑战证书）
                //NSLog(@"serverTrust=%@",challenge.protectionSpace.serverTrust);
                credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
                //确定挑战的方式
                if (credential) {
                    //证书挑战  设计policy,none，则跑到这里
                    disposition = NSURLSessionAuthChallengeUseCredential;
                } else {
                    disposition = NSURLSessionAuthChallengePerformDefaultHandling;
                }
            } else {
                disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
            }
        } else {
            // client authentication
            SecIdentityRef identity = NULL;
            SecTrustRef trust = NULL;
            //客户端p12文件
            NSString *p12 = [[NSBundle mainBundle] pathForResource:@"client"ofType:@"p12"];
            NSFileManager *fileManager =[NSFileManager defaultManager];
            
            if(![fileManager fileExistsAtPath:p12]){
                DLog(@"client.p12:not exist");
            } else {
                NSData *PKCS12Data = [NSData dataWithContentsOfFile:p12];
                if ([self extractIdentity:&identity andTrust:&trust fromPKCS12Data:PKCS12Data]){
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
}

//读取p12文件中的密码
- (BOOL)extractIdentity:(SecIdentityRef*)outIdentity andTrust:(SecTrustRef *)outTrust fromPKCS12Data:(NSData *)inPKCS12Data {
    OSStatus securityError = errSecSuccess;
    
    //client certificate password
    //客户端p12文件 密码
    NSDictionary *optionsDictionary = [NSDictionary dictionaryWithObject:@"123456"
                                                                  forKey:(__bridge id)kSecImportExportPassphrase];
    CFArrayRef items = CFArrayCreate(NULL, 0, 0, NULL);
    securityError = SecPKCS12Import((__bridge CFDataRef)inPKCS12Data,(__bridge CFDictionaryRef)optionsDictionary,&items);
    
    if(securityError == 0) {
        CFDictionaryRef myIdentityAndTrust = CFArrayGetValueAtIndex(items,0);
        const void* tempIdentity = NULL;
        tempIdentity = CFDictionaryGetValue (myIdentityAndTrust,kSecImportItemIdentity);
        *outIdentity = (SecIdentityRef)tempIdentity;
        const void* tempTrust = NULL;
        tempTrust = CFDictionaryGetValue(myIdentityAndTrust,kSecImportItemTrust);
        *outTrust = (SecTrustRef)tempTrust;
    }else{
        return NO;
    }
    return YES;
}

@end
