
//
//  ScanViewController.swift
//  zly-ofo
//
//  Created by MPGY on 2017/5/31.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import swiftScan
import FTIndicator
class ScanViewController: LBXScanViewController {
    var isFlashOn = false
    var webView : UIWebView!
    @IBOutlet weak var flashBtn: UIButton!
    
    @IBAction func flashBtnTap(_ sender: Any) {
        
        isFlashOn = !isFlashOn
        
       scanObj?.changeTorch()
        
        if isFlashOn {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_enableTorch"), for: UIControlState.normal)
        }else {
            flashBtn.setImage(#imageLiteral(resourceName: "btn_unenableTorch_w"), for: UIControlState.normal)
        }
    }
    @IBOutlet weak var paneView: UIView!

    
    /**扫到以后处理结果*/
    override func handleCodeResult(arrayResult: [LBXScanResult]) {
        if  let  result  = arrayResult.first {
            let msg  = result.strScanned
            webView = UIWebView();
            webView.frame  = self.view.bounds;
            self.view.addSubview(webView)
            let url = NSURL(string: msg!)
            
            let requst = NSURLRequest(url: url! as URL)
          
            /// WKWebView加载请求
            
            webView.loadRequest(requst as URLRequest)
           
            
            
        }
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "扫码用车"
        
        var style = LBXScanViewStyle()
        style.anmiationStyle = .NetGrid
        style.animationImage = UIImage(named:"CodeScan.bundle/qrcode_scan_part_net")
        scanStyle = style
       
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .blackTranslucent
        navigationController?.navigationBar.tintColor = .white
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.bringSubview(toFront: paneView)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = UIColor.black
        
        
        navigationItem.backBarButtonItem = UIBarButtonItem.init(title: "", style: .plain, target: self, action: nil)
    }

    
    
    
    
    
}
