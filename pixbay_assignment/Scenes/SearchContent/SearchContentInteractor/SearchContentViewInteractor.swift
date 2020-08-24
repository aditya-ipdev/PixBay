//
//  SearchContentViewInteractor.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol SearchContentBuisnessLogic {
    func requestContents(searchStr: String,page: Int)
    var dataStore: SearchContentDataStoreLogic {get}
    func clearFetchedDataStore()
}



class SearchContentViewInteractor: SearchContentBuisnessLogic {
    
    var dataStore: SearchContentDataStoreLogic
    var presenter: SearchContentPresenterLogic?
    var worker: SearchContentViewWorker?
    
    init(dataStore: SearchContentDataStoreLogic) {
        self.dataStore = dataStore
    }
    
    func requestContents(searchStr: String, page: Int) {
        
        let reqParams: Parameters = [ParamterKeys.key.rawValue: EndPoint.Key.value,
                                     ParamterKeys.query.rawValue: searchStr,
                                     ParamterKeys.page.rawValue: page]
        
        let params = Contents.FetchContents.Request(params: reqParams)
        worker = SearchContentViewWorker(network: NetworkManager(), request: params, localDBRef: LocalDatabase(), searchReqStr: searchStr)
        worker?.fetchUsers(completionHandler: { (contents) in
            guard contents != nil else {return}
            self.dataStore.contentData = contents
            self.dataStore.contentHits.append(contentsOf: contents!.hits)
            let response = Contents.FetchContents.Response(data: contents)
            self.presenter?.presentFetchedContent(response: response)
        })
    }
    
}

extension SearchContentViewInteractor {
    
    func clearFetchedDataStore() {
        self.dataStore.contentHits = []
    }
}
