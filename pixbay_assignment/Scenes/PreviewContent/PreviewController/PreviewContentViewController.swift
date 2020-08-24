//
//  PreviewContentViewController.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit

protocol DisplayPreviewContentBuisnessLogic: class {
    func displayPreviewContent(result: PreviewContent.ContentDetail.ViewModel)
}

class PreviewContentViewController: UIViewController, DisplayPreviewContentBuisnessLogic {

    //MARK: - IBOUTLETS
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - PROPERTIES
    private var interactor: PreviewContentViewBuisnessLogic?
    var router: (NSObjectProtocol & PreviewContentDataPassing)?
    var selectedIndexPath: IndexPath!
    private(set) var displayedContents: [PreviewContent.ContentDetail.ViewModel.DisplayedContent] = []
    
    //MARK: - VIEW LIFECYCLE
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.collectionViewLayout = layoutConfig()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestContents()
    }
    
    
    
    // MARK: OBJECT LIFECYCLE
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
      super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
      setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
      super.init(coder: aDecoder)
      setup()
    }
    
    
    
    // MARK: - INITIAL SETUP
    private func setup()
    {
        let viewController = self
        let dataStore = PreviewContentDataStore()
        let interactor = PreviewContentViewInteractor(dataStore: dataStore)
        viewController.interactor = interactor
        let presenter = PreviewContentViewPresenter()
        let router = PreviewContentViewRouter()
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = dataStore
        
    }
    
    
    
    // MARK: - LAYOUT SETUP
    private func layoutConfig() -> UICollectionViewFlowLayout {
        let flowLayout = AnimatedCollectionViewLayout()
        let itemSize = UIScreen.main.bounds.size
        flowLayout.itemSize = itemSize
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
    
    
    
    
    // MARK: - FETCH PREVIEW CONTENT
    private func requestContents() {
        interactor?.requestContentDetail()
    }
    
    
    
    // MARK: - DISPLAY PREVIEW CONTENT
    //// MARK: - POPULATE DATASOURCE AFTER SUCESS
    func displayPreviewContent(result: PreviewContent.ContentDetail.ViewModel) {
        self.displayedContents = result.contents
        self.collectionView.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
    }
}


//MARK: - EXTENSION UITABLEIVEW DATASOURCE, DELEGATES
extension PreviewContentViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.displayedContents.count
    }

    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueCell(cellType: PreviewCellView.self, indexPath: indexPath)
        let content = self.displayedContents[indexPath.row]
        cell.setupCellData(data: content)
        return cell
    }
    
    
}

//MARK: - EXTENSION UITABLEIVEW COLLECTION FLOWLAYOUTDELEGATE
extension PreviewContentViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size 
    }
}
