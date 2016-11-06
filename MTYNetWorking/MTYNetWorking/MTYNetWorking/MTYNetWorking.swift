//
//  MTYNetWorking.swift
//  MTYNetWorking
//
//  Created by 马天野 on 2016/11/6.
//  Copyright © 2016年 MTY. All rights reserved.
//  工具类,继承NSObject封装

import UIKit
import AFNetworking

enum RequestType
{
    case Get
    case Post
}

class MTYNetWorking: NSObject {
    
    // 单例
    static let shareInstance = MTYNetWorking()
    
    // 懒加载 - 方式1: 单纯的懒加载
    lazy var mgr = AFHTTPSessionManager()
    
    /* 懒加载 - 方式2: 可以对请求管理者做些初始化的操作
     lazy var mgr = {
     
     // 可以做些初始化的操作
     return $0
     
     }(AFHTTPSessionManager())
     */
    
    /// 基于AFN封装的网络请求接口
    ///
    /// - Parameters:
    ///   - requestType: 发送请求的类型,是个枚举
    ///   - url: 请求路径
    ///   - parameters: 请求参数,字典类型
    ///   - resultBlock: 请求结果
    func request(requestType:RequestType,
                 url:String,
                 parameters:[String: Any],
                 resultBlock:@escaping (_ response: [String: Any]?,_ error: String?) -> ())
    {
        
        // 请求成功的闭包
        let successBlock = { (task: URLSessionDataTask, response: Any?) in
            // 拿到结果
            resultBlock((response as? [String: Any])!, nil)
        }
        
        // 请求失败的闭包
        let failuerBlock = { (task: URLSessionDataTask?, error: Error) in
            // 拿到结果
            resultBlock(nil, error.localizedDescription)
        }
        
        // 发送异步 Get请求
        if requestType == .Get {
            mgr.get (
                url,
                parameters: parameters,
                progress: nil,
                success: successBlock,
                failure: failuerBlock
            )
            
            // 发送异步 Post请求
        }else if requestType == .Post
        {
            mgr.post (
                url,
                parameters: parameters,
                progress: nil,
                success: successBlock,
                failure: failuerBlock
            )
            
        }
        
    }

}
