//
//  AboutUsViewController.swift
//  zly-ofo
//
//  Created by HAHA on 2017/5/23.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import UIKit
import SWRevealViewController
class AboutUsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        /**关于我们的页面*/
        if let revealVC = revealViewController () {
            revealVC.rearViewRevealWidth = 290
            navigationItem.leftBarButtonItem?.target = revealVC
            navigationItem.leftBarButtonItem?.action = #selector(SWRevealViewController.revealToggle(_:))
            view.addGestureRecognizer(revealVC.panGestureRecognizer())
        }

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
