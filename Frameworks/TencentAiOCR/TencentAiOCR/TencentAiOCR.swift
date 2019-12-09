//
//  TencentAiOCR.swift
//  TencentAiOCR
//
//  Created by Louis.B on 2019/12/3.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import Foundation
@_exported import UIKit
@_exported import TencentAiBase

open class TencentAiOCR: TBaseManager {
    
    public func generalOCR(image: UIImage, callback: @escaping (TResult, GeneralOCR?) -> ()) {
        let api = GeneralOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = GeneralOCR.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func IDCardOCR(image: UIImage, type: IDCardType, callback: @escaping (TResult, IDCard?) -> ()) {
        let api = IDCardOCRApi()
        api.image = image
        api.type = type
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("IDCardOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = IDCard.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func businessCardOCR(image: UIImage, callback: @escaping (TResult, BusinessCard?) -> ()) {
        let api = BusinessCardOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("businessCardOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = BusinessCard.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func driverLisenceOCR(image: UIImage, type: DriverLicenseType, callback: @escaping (TResult, DriverLicense?) -> ()) {
        let api = DriverLicenseOCRApi()
        api.image = image
        api.type = type
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = DriverLicense.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func numberPlateOCR(image: UIImage, callback: @escaping (TResult, NumberPlate?) -> ()) {
        let api = NumberPlateOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = NumberPlate.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func bankCardOCR(image: UIImage, callback: @escaping (TResult, BankCard?) -> ()) {
        let api = BankCardOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = BankCard.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func businessLicenseOCR(image: UIImage, callback: @escaping (TResult, BusinessLicense?) -> ()) {
        let api = BusinessLicenseOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("businessLicenseOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = BusinessLicense.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
    
    public func handWritingOCR(image: UIImage, callback: @escaping (TResult, HandWriting?) -> ()) {
        let api = HandWritingOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            let parseResult = HandWriting.decodeFrom(data: data!)
            callback((parseResult.success, rspError), parseResult.model)
        }
    }
}
