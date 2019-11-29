//
//  TSessionManager.swift
//  TencentAiBase
//
//  Created by Louis.B on 2019/11/29.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation

public typealias TDataCallback = (TResult, Data?) -> ()

let TAPI_TIMEOUT = 15.0

open class TSessionManager: TBaseSessionManager, URLSessionDelegate {
    
    public static var `default` = TSessionManager()
    
    public func request(api: TBaseApi, callback: @escaping TDataCallback) {
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
                callback(TResult(code: .requestFailed, error: err), nil)
            } else {
                self.handleResponse(url: request.url!.absoluteString,
                                    data: data!,
                                    callback: callback)
            }
        }
        TLog.d("httpHeader: \(request.allHTTPHeaderFields!)")
        task.resume()
    }
    
    public func handleResponse(url: String, data: Data, callback: @escaping TDataCallback) {
        let rspString = String(data: data, encoding: .utf8)
        guard let string = rspString else {
            TLog.d("\(url) rsp: data is not utf8 encoding")
            return
        }
        TLog.d("\(url) rsp: \(string)")
        callback(TResult(code: .success, error: nil), data)
    }
    
    public func bodyData(api: TBaseApi) -> Data {
        var body = [String : Paramable]()
        var bodyString = ""
        for (key, value) in api.commonParams() {
            body[key] = value
            bodyString += "\(key)=\(value)&"
        }
        
        for (key, value) in api.businessParams() {
            body[key] = value
            bodyString += "\(key)=\(value)&"
        }
        
        let sign = TencentAiSignature.signatureWith(params: body)
        if let signature = sign {
            bodyString += "\(kSIGNATURE)=\(signature)"
        }
//        TLog.d("TRequest body : \(bodyString)")
        return bodyString.data(using: .utf8)!
    }
}
