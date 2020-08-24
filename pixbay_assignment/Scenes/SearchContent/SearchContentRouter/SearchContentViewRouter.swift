//
//  SearchContentViewRouter.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation
import UIKit

 protocol ContentDataPassing {
    var dataStore: SearchContentDataStoreLogic? {get set}
}

@objc protocol ContentListRoutingLogic {
    func routeToPreviewContent(selectedIndexPath: IndexPath)
}



class SearchContentViewRouter: NSObject, ContentListRoutingLogic, ContentDataPassing {
    
    var dataStore: SearchContentDataStoreLogic?
    weak var viewController: SearchContentViewController?
    
    
    func routeToPreviewContent(selectedIndexPath: IndexPath) {
        let destinationVC = viewController?.storyboard?.instantiateViewController(withIdentifier: "PreviewContentViewController") as! PreviewContentViewController
        destinationVC.selectedIndexPath = selectedIndexPath
        var destinationDS = destinationVC.router!.dataStore!
        passDataToPreviewDetail(source: dataStore!, destination: &destinationDS)
        navigateToPreviewDetail(source: viewController!, destination: destinationVC)
        
    }
    
    // MARK: Navigation
     
     func navigateToPreviewDetail(source: SearchContentViewController, destination: PreviewContentViewController)
     {
       source.present(destination, animated: true, completion: nil)
     }
    
    func passDataToPreviewDetail(source: SearchContentDataStoreLogic, destination: inout PreviewContentDataStoreLogic)
    {
        destination.contentHits = source.contentHits
    }
}
