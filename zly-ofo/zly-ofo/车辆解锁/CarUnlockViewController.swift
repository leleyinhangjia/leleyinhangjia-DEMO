//
//  CarUnlockViewController.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/6/4.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import SwiftyTimer
import SwiftySound

class CarUnlockViewController: UIViewController {
    var code  = ""
    
    @IBOutlet weak var Label1est: zlyPreviewLabel!
    
    @IBOutlet weak var Label2est: UILabel!
    @IBOutlet weak var Label3est: UILabel!
    
    @IBOutlet weak var Label4est: UILabel!
    
    var passArray : [String] = []
    
    var remindSecond = 110
    
    var istorch  = false
    
    var isVoiceOn = true
    
    let defauts = UserDefaults.standard
    
    @IBOutlet weak var torchBtn: UIButton!
   
    /**闪光灯打开*/
    @IBAction func torchBtnTap(_ sender: UIButton) {
        turnTorch()
        if istorch {
            torchBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
            
             defauts.set(true, forKey: "isVoiceOn")
        }else {
             torchBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
            
             defauts.set(false, forKey: "isVoiceOn")
        }
        istorch = !istorch
    }
    
    /**倒计时*/
    @IBOutlet weak var secondLabel: UILabel!

    /**声音*/
    @IBOutlet weak var voiceBtn: UIButton!
    @IBAction func vocieBtnTap(_ sender: UIButton) {
        if isVoiceOn {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
            
            defauts.set(true, forKey: "isVoiceOn")
            
        }else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
            //Sound.play(file:"骑行结束_LH.m4a")

            
            defauts.set(false, forKey: "isVoiceOn")


        }
        isVoiceOn = !isVoiceOn
        
    }
        /**立即保修*/
      @IBAction func ImmediateWarranty(_ sender: UIButton) {
        //self.navigationController?.isNavigationBarHidden = false
        //self.dismiss(animated: true, completion: nil)
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        Timer.every(1)  { (timer : Timer) in
            self.remindSecond -= 1
            self.secondLabel.text = self.remindSecond.description
            if self.remindSecond == 0 {
                timer.invalidate()
            }
        }
        Sound.play(file: "上车前_LH.m4a")
     
        self.Label1est.text = passArray[0]
        self.Label2est.text = passArray[1]
        self.Label3est.text = passArray[2]
        self.Label4est.text = passArray[3]


    
    }


}
