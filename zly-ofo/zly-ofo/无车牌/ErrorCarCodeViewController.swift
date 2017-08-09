//
//  ErrorCarCodeViewController.swift
//  zly-ofo
//
//  Created by MPGY on 2017/6/6.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import MIBlurPopup

class ErrorCarCodeViewController: UIViewController{

    @IBAction func colseBtnTap(_ sender: Any) {
        colse()
    }
   

    @IBOutlet weak var myPopUpVIew: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func colse() {
        dismiss(animated: true, completion: nil)
    }

    
}

extension ErrorCarCodeViewController: MIBlurPopupDelegate {
   
    var blurEffectStyle: UIBlurEffectStyle {
        return .dark
    }

    var popupView: UIView {
         return myPopUpVIew
    }
   
    var initialScaleAmmount: CGFloat {
        return 0.2
    }
    var animationDuration: TimeInterval {
        return 0.2
    }
   
}
