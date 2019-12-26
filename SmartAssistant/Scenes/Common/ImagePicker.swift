//
//  ImagePickerController.swift
//  SmartAssistant
//
//  Created by Louis.B on 2019/12/17.
//  Copyright © 2019 Louis.B. All rights reserved.
//

import UIKit

typealias ImagePickerResult = (UIImage?) -> ()

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public static let `default` = ImagePicker()
    
    private var callback: ImagePickerResult?
    
    private var source: UIImagePickerController.SourceType!
    
    private override init() {
        super.init()
    }
        
    static func pickImage(for controller: UIViewController = UIApplication.shared.keyWindow!.rootViewController!,
                          result: @escaping ImagePickerResult) {
        self.default.callback = result
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            self.selectSourceType(controller)
        } else {
            self.default.source = .photoLibrary
            self.showImagePicker(controller)
        }
    }
    
    private static func selectSourceType(_ controller: UIViewController) {
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let camera = UIAlertAction.init(title: "拍照", style: .default) { (_) in
            self.default.source = .camera
            self.showImagePicker(controller)
        }
        actionSheet.addAction(camera)
        
        let image = UIAlertAction.init(title: "相册", style: .default) { (_) in
            self.default.source = .photoLibrary
            self.showImagePicker(controller)
        }
        actionSheet.addAction(image)
        
        let cancel = UIAlertAction.init(title: "取消", style: .cancel) { (_) in
            self.default.callback = nil
        }
        actionSheet.addAction(cancel)
        controller.present(actionSheet, animated: true, completion: nil)
    }
    
    private static func showImagePicker(_ controller: UIViewController) {
        let picker = UIImagePickerController()
        picker.delegate = self.default
        picker.sourceType = self.default.source
        controller.present(picker, animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        ImagePicker.default.callback?(image)
        ImagePicker.default.callback = nil
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        ImagePicker.default.callback = nil
        picker.dismiss(animated: true, completion: nil)
    }
}
