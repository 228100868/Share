//
//  NetworkingTool.m
//  Share
//
//  Created by 禾家木 on 16/8/2.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import "NetworkingTool.h"
#import <AFNetworking.h>

#ifdef DEBUG//DEBUG是程序自带的默认存在的一个宏定义，平时运行都是在这种方式下
//平时开发时都会用一个单独的测试环境
static NSString *baseUrl = @"10.30.152.134";

#else

static NSString *baseUrl = @"https://www.1000phone.tk";
//
#endif

@implementation NetworkingTool
//为了防止我们的应用频繁的获取网络数据的时候，创建sessionManager 过多， 会大量消耗手机资源 ，我们最好封装成一个单例 获取网络数据只用到一个对象
+ (AFHTTPSessionManager *)sharedManager {
    static AFHTTPSessionManager *manager = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //AFNetworking 做网络请求时可以有小优化
        //这里用baseUrl 生成 sessionManager 就相当于告诉AFNetworking 以后我们请求的数据，都是从这个服务器。那么AFNetworking 会把这个服务器缓存 下次不用解析
        manager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
        //设置请求的超时时间
        //设置请求的参数编码方式
        //
        manager.requestSerializer.timeoutInterval = 30.0;
        //    manager.requestSerializer.
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        //返回数据的数列化
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json", @"text/html", @"text/xml", @"application/json", nil];

    });
    return manager;
}

+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void (^)(BOOL, id))complete{

    [[self sharedManager] POST:@"" parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"responseObject:%@",responseObject);
        NSNumber *serviceCode = [responseObject objectForKey:@"ret"];
        if ([serviceCode isEqualToNumber :@200]) {
            //证明没有服务错误
            NSDictionary *retData = [responseObject objectForKey:@"data"];
            NSNumber *dataCode = [retData objectForKey:@"code"];
            if ([dataCode isEqualToNumber:@0]) {
                //证明返回的数据没有错误
                NSDictionary *userInfo = [retData objectForKey:@"data"];
                if(complete) {
                    complete(YES,userInfo);
                }
            }else {
                NSString *dataMessage = [retData objectForKey:@"msg"];
                if (complete) {
                    complete(NO ,dataMessage);
                }
            }
            
        }else {
            NSString *serviecMessage = [responseObject objectForKey:@"msg"];
            if (complete) {
                complete(NO,serviecMessage);
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (complete) {
            complete(NO, error.localizedDescription);
        }
    }];

}
@end
