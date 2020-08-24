//
//  PreviewContentViewRouter.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation
import UIKit

 protocol PreviewContentDataPassing {
    var dataStore: PreviewContentDataStoreLogic? {get}
}

class PreviewContentViewRouter: NSObject, PreviewContentDataPassing {
    var dataStore: PreviewContentDataStoreLogic?
    
    // for fututre navigation 
    weak var viewController: UIViewController?
}



