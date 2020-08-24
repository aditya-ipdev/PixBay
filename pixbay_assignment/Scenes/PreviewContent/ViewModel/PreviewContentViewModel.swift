//
//  PreviewContentViewModel.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

enum PreviewContent {

    enum ContentDetail {
        
        // Use Cases
        struct Request {
            var params: Parameters?
        }
        
        struct Response {
           // var data: ContentModel?
            var dataHits: [ContentModel.Content]
        }
        
        // to capture only the required data and present on main view.
        struct ViewModel {
            struct DisplayedContent {
                var webformatURL: String
            }
            var contents: [DisplayedContent]
        }
    }
    
    enum SavedFetchedContents {
        struct SavedSearchedResults {
            var name: String
        }
    }

}
