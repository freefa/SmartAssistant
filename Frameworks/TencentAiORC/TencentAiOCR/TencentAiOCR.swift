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
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(GeneralOCR.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
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
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(IDCard.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
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
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(BusinessCard.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
        }
    }
    
    public func driverLisenceOCR(image: UIImage, type: DriverLisenceType, callback: @escaping (TResult, DriverLisence?) -> ()) {
        let api = DriverLisenceOCRApi()
        api.image = image
        api.type = type
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(DriverLisence.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
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
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(NumberPlate.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
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
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(BankCard.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
        }
    }
    
    public func businessLicenseOCR(image: UIImage, callback: @escaping (TResult, BusinessLicense?) -> ()) {
        let api = BusinessLicenseOCRApi()
        api.image = image
        TSessionManager.default.request(api: api) { (data, rspError) in
            guard rspError == nil else {
                TLog.d("driverLisenceOCR failed: \(rspError!.description)")
                callback((false, rspError), nil)
                return
            }
            
            let dict = try? JSONSerialization .jsonObject(with: data!, options: .allowFragments)
            if let info = dict as? Dictionary<String, Any> {
                if let code = info[kRESP_CODE] as? Int, code == TErrorCode.success.rawValue {
                    let resultInfo = info[kRESP_DATA] as! Dictionary<String, Any>
                    let resultData = try! JSONSerialization.data(withJSONObject: resultInfo, options: .fragmentsAllowed)
                    do {
                        let model = try JSONDecoder().decode(BusinessLicense.self, from: resultData)
                        callback((true, rspError), model)
                    } catch {
                        TLog.d("decode json to model error: \(error.localizedDescription)")
                        callback((false, rspError), nil)
                    }
                } else {
                    callback((false, rspError), nil)
                }
            }
        }
    }
}
