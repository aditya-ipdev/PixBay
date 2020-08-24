//
//  PreviewContentDataStore.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol PreviewContentDataStoreLogic {
    var data: ContentModel!  {get set}
    var contentHits: [ContentModel.Content] {get set}
}
class PreviewContentDataStore: PreviewContentDataStoreLogic {
    var data: ContentModel!
    var contentHits: [ContentModel.Content] = []
    
}
