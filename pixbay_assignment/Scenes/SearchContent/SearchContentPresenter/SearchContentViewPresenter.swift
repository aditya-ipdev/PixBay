//
//  SearchContentViewPresenter.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol SearchContentPresenterLogic {
    func presentFetchedContent(response: Contents.FetchContents.Response)
}

class SearchContentViewPresenter: SearchContentPresenterLogic {
    
   weak var contentVC: SearchContentViewController?
    
    func presentFetchedContent(response: Contents.FetchContents.Response) {
       
        guard let response = response.data else {return}
        var viewData : [Contents.FetchContents.ViewModel.DisplayedContent] = []
        for item in response.hits {
            let displayData = Contents.FetchContents.ViewModel.DisplayedContent(webformatURL: item.webformatURL)
            viewData.append(displayData)
        }
        let viewModel = Contents.FetchContents.ViewModel(contents: viewData)
        contentVC?.displayContent(result: viewModel)
    }
    
}
