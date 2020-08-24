//
//  ContentViewModel.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

enum Contents {
    
    enum FetchContents {
        
        // Use Cases
        struct Request {
            var params: Parameters?
        }
        
        struct Response {
            var data: ContentModel?
        }
        
        // to capture only the required data and present on main view.
        struct ViewModel {
            struct DisplayedContent {
                var webformatURL: String
            }
            var contents: [DisplayedContent]?
        }
    }
    
}

