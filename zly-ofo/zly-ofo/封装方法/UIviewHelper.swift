//
//  UIviewHelper.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/6/4.
//  Copyright © 2017年 郑乐银. All rights reserved.
//
extension UIView {
   @IBInspectable var boderwidth: CGFloat {
        get {
            return self.layer.borderWidth
        }
        set {
            self.layer.borderWidth = newValue
        }
    }
    
   @IBInspectable var borderColor: UIColor {
        get {
            return UIColor(cgColor: self.layer.borderColor!)
        }
        set {
            self.layer.borderColor = newValue.cgColor
        }
    }
    
    @IBInspectable var cornerRadius: CGFloat {
        get {
            return self.layer.cornerRadius
        }
        set {
            self.layer.cornerRadius = newValue
            self.layer.masksToBounds = newValue > 0
        }
    }
    
}
@IBDesignable class zlyPreviewLabel:UILabel {
    
}

import AVFoundation


func turnTorch() {
    guard let device = AVCaptureDevice.defaultDevice(withMediaType: AVMediaTypeVideo) else {
        return
    }
    
    if device.hasTorch && device.isTorchAvailable {
        try? device.lockForConfiguration()
        
        if device.torchMode == .off {
            device.torchMode = .on
        }else {
            device.torchMode = .off
        }
        device.unlockForConfiguration()
    }
    
    
}

func voiceBtnStatus(voiceBtn: UIButton) {
    let defauts = UserDefaults.standard
    
    if defauts.bool(forKey: "isVoiceOn") {
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
    }else {
        voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
    }
    
}





