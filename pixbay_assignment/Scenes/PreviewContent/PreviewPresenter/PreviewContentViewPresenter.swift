//
//  PreviewContentViewPresenter.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation

protocol PreviewViewContentPresenterLogic {
    func presentFetchedContent(response: PreviewContent.ContentDetail.Response)
}


class PreviewContentViewPresenter: PreviewViewContentPresenterLogic {
    
    weak var viewController: PreviewContentViewController?
    func presentFetchedContent(response: PreviewContent.ContentDetail.Response) {
        
         var viewData: [PreviewContent.ContentDetail.ViewModel.DisplayedContent] = []
        for item in response.dataHits {
            let displayData = PreviewContent.ContentDetail.ViewModel.DisplayedContent(webformatURL: item.webformatURL)
            viewData.append(displayData)
        }
        let viewModel = PreviewContent.ContentDetail.ViewModel(contents: viewData)
        viewController?.displayPreviewContent(result: viewModel)
    }
}
