//
//  SearchContentViewController.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 21/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit

protocol DisplaySearchResultBuisnessLogic: class {
    func displayContent(result: Contents.FetchContents.ViewModel)
}

class SearchContentViewController: UIViewController, DisplaySearchResultBuisnessLogic {
    
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var contentSearchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    //MARK: - PROPERTIES
    private var isLoading: Bool = false
    private var initialFetching: Bool = false
    private var interactor: SearchContentBuisnessLogic?
    var router: (NSObjectProtocol & ContentDataPassing & ContentListRoutingLogic)?
    private(set) var displayedContents: [Contents.FetchContents.ViewModel.DisplayedContent] = []
    private var pageCount: Int = 1
    private var prefetchedTxt: String = ""
    fileprivate var autoSuggetionView: AutoSuggestionSearchView? 
    
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }
    
    // MARK: - INITIAL SETUP
    private func setup() {
        let viewController = self
        let presenter = SearchContentViewPresenter()
        let router = SearchContentViewRouter()
        let dataStore = SearchContentDataStore()
        let interactor = SearchContentViewInteractor(dataStore: dataStore)
        viewController.interactor = interactor
        presenter.contentVC = viewController
        router.viewController = viewController
        viewController.router = router
        interactor.presenter = presenter
        router.dataStore = dataStore
        
    }
    
    // MARK: - FETCH SEARCHED CONTENT
    private func requestContents(searchStr: String, page: Int) {
        prefetchedTxt = searchStr.trimmingCharacters(in: .whitespacesAndNewlines)
        interactor?.requestContents(searchStr: prefetchedTxt, page: page)
    }
    
    // MARK: - RESET DATASOURE
    private func resetDataSource() {
        self.pageCount = 1
        self.prefetchedTxt = ""
        self.displayedContents = []
        interactor?.clearFetchedDataStore()
        self.collectionView.reloadData()
    }
    
    // MARK: - DISPLAY SEARCHED CONTENT
    //// MARK: - POPULATE DATASOURCE AFTER SUCESS
    func displayContent(result: Contents.FetchContents.ViewModel) {
        guard (result.contents ?? []).count > 0 else {
            Utils.showAlertWithMessage("No Recod Found", title: "Alert")
            return
        }
        displayedContents.append(contentsOf: result.contents ?? [])
        self.isLoading = false
        self.initialFetching = false
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
}



//MARK: - EXTENSION TABLEVIEW DATASOURCE, DELEGATES
extension SearchContentViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayedContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: UIScreen.main.bounds.size.width, height: 350)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: ContentCellView.self, indexPath: indexPath)
        cell.layer.masksToBounds = false
        let content = displayedContents[indexPath.row]
        cell.setupCellData(data: content)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToPreviewContent(selectedIndexPath: indexPath)
    }
    
}



extension SearchContentViewController {
    
    // MARK :- PAGINATION
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let endScrolling = scrollView.contentOffset.y + scrollView.frame.size.height
        if endScrolling >= scrollView.contentSize.height  {
            let totalHits = interactor?.dataStore.contentData?.totalHits ?? 1
            let defaultPerPage = interactor?.dataStore.contentData?.hits.count ?? 1
            guard !(pageCount >= totalHits / defaultPerPage) else {return}
            guard !self.isLoading, !self.initialFetching else { return }
            self.isLoading = true
            self.initialFetching = true
            pageCount += 1
            self.requestContents(searchStr: self.contentSearchBar.text ?? "", page: pageCount)
        }
    }
    
    
}





//MARK: - EXTENSION SEARCHBAR DELEGATE
extension SearchContentViewController: UISearchBarDelegate {
    
    // MARK :- CALL API TO GET CONTENT
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard !searchBar.text!.isEmpty  else {return}
        guard !(searchBar.text!.trimmingCharacters(in: .whitespacesAndNewlines) == prefetchedTxt) else {return}
        resetDataSource()
        self.requestContents(searchStr: searchBar.text ?? "", page: pageCount)
    }
    
    // MARK :- CHECK FOR BLANK SPACE
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            self.resetDataSource()
        }
        
    }
    
    // MARK :- SHOW AUTO-SUGGETION VIEW
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        if LocalDatabase.LocalDBRef.dbList.count > 0 {
            if autoSuggetionView != nil {
                autoSuggetionView?.removeFromSuperview()
            }
            autoSuggetionView = AutoSuggestionSearchView(frame: CGRect(x: searchBar.frame.minX, y: searchBar.frame.maxY, width: searchBar.frame.width - 5, height: 120))
            autoSuggetionView?.backgroundColor = .red
            autoSuggetionView?.delegate = self
            self.view.addSubview(autoSuggetionView!)
        }
    }
    
    
    // MARK :- VALIDATION FOR EXTRA SPACES
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if searchBar.text?.count == 0 && text == " " {
            return false
        }else if searchBar.text!.count > 1 {
            if searchBar.text![searchBar.text!.count - 1] == " " && text == " " {
                return false
            }
        }
        return true
    }
    
}


extension SearchContentViewController: AutoSuggestionCellDelegate {
    
    func cellDidTapped(str: String) {
        if autoSuggetionView != nil {
            autoSuggetionView?.removeFromSuperview()
        }
        self.requestContents(searchStr: str, page: pageCount)
    }
    
}
