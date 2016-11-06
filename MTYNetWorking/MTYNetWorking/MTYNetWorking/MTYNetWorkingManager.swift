//
//  MTYNetWorkingManager.swift
//  MTYNetWorking
//
//  Created by 马天野 on 2016/11/6.
//  Copyright © 2016年 MTY. All rights reserved.
//  继承AFHTTPSessionManager 封装

import UIKit
import AFNetworking

// 请求类型
enum RequestType2
{
    case Get
    case Post
}

class MTYNetWorkingManager: AFHTTPSessionManager {
    
    // 单例
    static let shareInstance = MTYNetWorkingManager()
    
    func request(type: RequestType2,
                 url: String,
                 parameters: [String: Any],
                 resultBlock:@escaping ((_ response:[String: Any]?, _ error: Error?) ->())) {
        
        // 成功的闭包
        let successBlock = { (task: URLSessionDataTask, response: Any?) in
            
            resultBlock(response as? [String: Any], nil)
        }
        
        // 失败的闭包
        let failureBlock = { (task: URLSessionDataTask?, error: Error) in
            
            resultBlock(nil, error)
        }
        
        // Get 请求
        if type == .Get {
            
            get(
                url,
                parameters: parameters,
                progress: nil,
                success: successBlock,
                failure: failureBlock
            )
            // Post请求
        }else if type == .Post {
            
            post(
                url,
                parameters: parameters,
                progress: nil,
                success: successBlock,
                failure: failureBlock
            )
            
        }
    }

}
