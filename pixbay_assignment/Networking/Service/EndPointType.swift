//
//  EndPointType.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 21/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation


protocol EndPointType {
    var baseURL:URL {get}
    var path: String {get}
    var httpTask: HTTPTask {get}
}
