//
//  NetworkingTool.h
//  Share
//
//  Created by 禾家木 on 16/8/2.
//  Copyright © 2016年 hejiamu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkingTool : NSObject
//需求分析
//我们一般在请求网络数据时，需要什么？
//网址参数对
//我们想要得到什么？
//请求到的数据
//因为网络请求是异步操作 所以我们获取的数据不能直接返回 要用block 回调
//则个里面没有失败的回调 需要在外面处理失败后的动作
//这个类只是作为一个帮助类 不需要具体的对象去做某件事
//如果需要请求失败的回调 具体需要什么东西
//1.成功还是失败
//2.如果失败了 失败的原因
//可以封装成像AFNetworking 那样成功和失败分别走两个block 成功的block 返回的是获取到的数据 失败block 返回的是失败的原因
//我们在公司做项目 接口都是一样的 不需要传接口只需要传参数
+ (void)getDataWithParameters:(NSDictionary *)parameters completeBlock:(void(^)(BOOL success, id result))complete;

@end
