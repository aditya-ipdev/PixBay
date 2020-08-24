//
//  SearchContentModel.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation
import UIKit

struct ContentModel: Decodable {
    
    var total: Int
    var totalHits: Int
    var hits: [Content]
    
    struct Content: Decodable {
        
        var id: Int
        var type: String
        var tags: String
        var webformatURL: String
    
    }
    
}


