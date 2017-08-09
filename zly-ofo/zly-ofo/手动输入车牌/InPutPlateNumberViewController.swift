//
//  InPutPlateNumberViewController.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/6/4.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import APNumberPad

class InPutPlateNumberViewController: UIViewController,APNumberPadDelegate ,UITextFieldDelegate{
    var isFlashOn = false
    var isVocie = true
    
    @IBOutlet weak var goBtn: UIButton!
    
    @IBOutlet weak var inputTXF: UITextField!
    @IBOutlet weak var voiceBtn: UIButton!
   
    @IBOutlet weak var flashBtn: UIButton!
    
    @IBAction func flashBtnTap(_ sender: UIButton) {
        isFlashOn = !isFlashOn
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: .normal)
        }else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch"), for: .normal)
        }
    }
    
    @IBAction func goBtnTap(_ sender: UIButton) {
       checkPass()
    }
    
    @IBAction func voiceBtnTap(_ sender: UIButton) {
        isVocie = !isVocie
        if  isVocie {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceopen"), for: .normal)
        }else {
            voiceBtn.setImage(#imageLiteral(resourceName: "voiceclose"), for: .normal)
        }
        
    }
 
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "车辆解锁"
    
        inputTXF.layer.borderWidth = 2
        inputTXF.layer.borderColor = UIColor.ofo.cgColor
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "扫码用车", style: .plain, target: self, action: #selector(backToScan))
        
        
        let NumberPad = APNumberPad.init(delegate: self)
        NumberPad.leftFunctionButton.setTitle("确定", for: .normal)
        inputTXF.inputView = NumberPad
        inputTXF.delegate = self
        
        goBtn.isEnabled = false
        
        
        voiceBtnStatus(voiceBtn:voiceBtn)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    self.navigationController?.isNavigationBarHidden = false
    }
    
    func numberPad(_ numberPad: APNumberPad, functionButtonAction functionButton: UIButton, textInput: UIResponder) {
//        if !inputTXF.text!.isEmpty {
//            //NetworkHelper.getPass(code: <#T##Int#>, completion: <#T##(String?) -> Void#>)
//            
//             performSegue(withIdentifier: "showPassCode", sender: self)
//        }
        checkPass()
        
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let text = textField.text else {
            return true
        }
        
        
        let newLength = text.characters.count + string.characters.count - range.length
        if newLength > 0 {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_enable"), for: .normal)
            goBtn.backgroundColor = UIColor.ofo
            goBtn.isEnabled = true
        }else {
            goBtn.setImage(#imageLiteral(resourceName: "nextArrow_unenable"), for: .normal)
            goBtn.backgroundColor = UIColor.groupTableViewBackground
            goBtn.isEnabled = false
        }

        
        return newLength <= 8
        
        
    }
    
    func backToScan()  {
        navigationController?.popViewController(animated: true)
    }
    
    var passArray:[String] = []
    
    
    func checkPass()  {
        if !inputTXF.text!.isEmpty {
       
            let code  = inputTXF.text!
            
            //desVC.code = code
            
            NetworkHelper.getPass(code: code, completion: { (pass) in
                if let pass = pass {

                    self.passArray = pass.characters.map({  return $0.description
                    })
                    self.performSegue(withIdentifier: "showPassCode", sender: self)
                  //desVC.passArray = pass.characters.map({ return $0.description })
                }else {
                print("无此车辆")
                  
                self.performSegue(withIdentifier: "showErroeView", sender: self)
                    
                    
                }
            })
            
        }
        
    
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        if segue.identifier == "showPassCode" {
            let desVC = segue.destination as! CarUnlockViewController
            desVC.passArray = self.passArray
    
    }
        
    }
    

}
