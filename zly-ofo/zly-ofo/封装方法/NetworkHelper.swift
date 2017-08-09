
//
//  NetworkHelper.swift
//  zly-ofo
//
//  Created by 郑乐银 on 2017/6/5.
//  Copyright © 2017年 郑乐银. All rights reserved.
//

import AVOSCloud
struct NetworkHelper {
 
}

extension NetworkHelper {
    /**闭包*/
  static  func getPass(code: String, completion: @escaping(String?) -> Void) {
    let query = AVQuery(className:"code")
    
    query.whereKey("code", equalTo: code)
    query.getFirstObjectInBackground { (code , e) in
        if let e = e {
            print("出错==",e.localizedDescription)
            completion(nil)
        }
        if let code = code,let pass = code["pass"] as? String {
        completion(pass)
        }
    }
    
    
    }
}
