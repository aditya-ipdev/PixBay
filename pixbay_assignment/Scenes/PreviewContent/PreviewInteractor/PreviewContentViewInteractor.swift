//
//  PreviewContentViewInteractor.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol PreviewContentViewBuisnessLogic {
    func requestContentDetail() 
}

class PreviewContentViewInteractor: PreviewContentViewBuisnessLogic {
    var dataStore: PreviewContentDataStoreLogic
    var presenter: PreviewViewContentPresenterLogic?
    
    init(dataStore: PreviewContentDataStoreLogic) {
        self.dataStore = dataStore
    }
    
    func requestContentDetail() {
        let response = PreviewContent.ContentDetail.Response(dataHits: self.dataStore.contentHits)
        presenter?.presentFetchedContent(response: response)
    }
     
}
