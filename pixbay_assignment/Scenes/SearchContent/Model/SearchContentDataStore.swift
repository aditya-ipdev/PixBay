//
//  SearchContentDataStore.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol SearchContentDataStoreLogic {
    var contentData: ContentModel? {get set}
    var totalHits: Int? {get set}
    var contentHits: [ContentModel.Content] {get set}
}


class SearchContentDataStore: SearchContentDataStoreLogic {
    var totalHits: Int?
    var contentHits: [ContentModel.Content] = []
    var contentData: ContentModel?
}
