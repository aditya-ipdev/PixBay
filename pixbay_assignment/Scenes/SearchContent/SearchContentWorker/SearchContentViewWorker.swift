//
//  SearchContentViewWorker.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation
import CoreData

class SearchContentViewWorker {
    
    var networkManager: FetcherServiceProtocol!
    var request: Contents.FetchContents.Request?
    var localDBRef: LocalDatabase?
    var searchReqStr: String = ""
    
    init(network: FetcherServiceProtocol? = nil, request: Contents.FetchContents.Request? = nil, localDBRef: LocalDatabase, searchReqStr: String = "") {
        self.networkManager = network
        self.request = request
        self.localDBRef = localDBRef
        self.searchReqStr = searchReqStr
    }
    
    func fetchUsers(completionHandler: @escaping ((ContentModel?) -> ())) {
        networkManager.get(.searchImage(params: self.request?.params)) { (result: ContentModel?, error) in
            if (result?.hits ?? []).count > 0 {
                if LocalDatabase.LocalDBRef.dbList.filter({  self.searchReqStr.lowercased() == $0.searchedKeyword?.lowercased() }).count == 0 {
                    DispatchQueue.main.async {
                        self.saveToCordeData()
                    }
                }
            }
            completionHandler(result)
        }
    }
    
    func saveToCordeData() {
        let context = localDBRef?.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: LocalDatabase.Entity.UserSearchedContent.rawValue, in: context!)
        let newUser = NSManagedObject(entity: entity!, insertInto: context)
        newUser.setValue(searchReqStr, forKey: "searchedKeyword")
        localDBRef?.saveContext()
    }
    
    func loadCoreData(completion: ([UserSearchedContent]?) -> ()) {
        let fetchCD = self.localDBRef?.fetch(with: LocalDatabase.Entity.UserSearchedContent) as? [UserSearchedContent]
        completion(fetchCD)
    }
    
}

