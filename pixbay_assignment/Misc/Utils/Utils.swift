//
//  Utils.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    class func showAlertWithMessage(_ message: String, title: String, handler:(()->())? = nil)
       {
           DispatchQueue.main.async {
               //** If any Alert view is alrady presented then do not show another alert
               var viewController : UIViewController!
               if let vc  = UIApplication.currentViewController() {
                   if (vc.isKind(of: UIAlertController.self)) {
                       return
                   }else{
                       viewController = vc
                   }
               }
               let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (_) in
                   handler?()
               }))
               viewController!.present(alert, animated: true, completion: nil)
               
           }
       }
}
