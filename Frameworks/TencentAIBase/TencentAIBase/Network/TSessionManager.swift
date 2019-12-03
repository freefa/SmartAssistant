//
//  TSessionManager.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public typealias TDataCallback = (Data?, TError?) -> ()

public typealias TResult = (success: Bool, error: TError?)

let TAPI_TIMEOUT = 15.0

open class TSessionManager: TBaseSessionManager, URLSessionDelegate {
    
    public static var `default` = TSessionManager()
    
    private var myCallback: TDataCallback?
    
    public func request(api: TencentAiBaseApi, callback: @escaping TDataCallback) {
        self.myCallback = callback
        // URL
        DispatchQueue.global().async {
            let url = api.baseUrl() + api.urlPath()
            let urlRequest = TBaseRequest(url: URL(string: url)!, uuid: UUID().uuidString)
            urlRequest.httpMethod = "POST"
            urlRequest.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            urlRequest.httpBody = self.bodyData(api: api)
            self.inQueue(request: urlRequest, callback: callback)
        }
    }
    
    public func inQueue(request: TBaseRequest, callback: @escaping TDataCallback) {
        let session = URLSession(configuration: .default, delegate: self, delegateQueue: nil)
        let task = session.dataTask(with: request as URLRequest) { (data, response, error) in
            if let err = error {
                TLog.d("TRequest failed: \(err.localizedDescription)")
                let e = TError(code: -999, description: err.localizedDescription)
                callback(data, e)
            } else {
                let urlRsp = response as! HTTPURLResponse
                if urlRsp.statusCode != HTTP_RESP_CODE_SUCCESS {
                    let e = TError(code: urlRsp.statusCode, description: "HTTP response error")
                    callback(data, e)
                } else {
                    self.handleResponse(url: request.url!.absoluteString,
                                        data: data!,
                                        callback: callback)
                }
            }
        }
        TLog.d("httpHeader: \(request.allHTTPHeaderFields!)")
        task.resume()
    }
    
    public func handleResponse(url: String, data: Data, callback: @escaping TDataCallback) {
        let rspInfo = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
        guard let info = rspInfo else {
            TLog.d("\(url) rsp: data is not valid or null")
            let e = TError(code: -999, description: "response data is invalid json")
            callback(data, e)
            return
        }
        let rspString = String(data: data, encoding: .utf8)
        guard let string = rspString else {
            TLog.d("\(url) rsp: data is not utf8 encoding")
            let e = TError(code: -999, description: "response is not utf8 encoding")
            callback(data, e)
            return
        }
        TLog.d("\(url) rsp: \(string)")
        let dict = info as! Dictionary<String, Any>
        let ret = dict["ret"] as! Int
        if ret != TErrorCode.success.rawValue {
            TLog.d("business error code: \(ret)")
        }
        self.myCallback?(data, nil)
        self.myCallback = nil
    }
    
    public func bodyData(api: TencentAiBaseApi) -> Data {
        var body = [String : Paramable]()
        for (key, value) in api.commonParams() {
            body[key] = value
        }
        
        for (key, value) in api.businessParams() {
            body[key] = value
        }
        
        let bodyString = TencentAiSignature.getSignedEncodedParams(params: body)
        TLog.d("TRequest body :\n\(bodyString!)")
        return bodyString!.data(using: .utf8)!
    }
}
