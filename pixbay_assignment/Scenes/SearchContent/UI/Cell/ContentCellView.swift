//
//  ContentCellView.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 21/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit
import Kingfisher

class ContentCellView: UICollectionViewCell {
    
    //MARK: - IBOUTLETS
    @IBOutlet weak var imgView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    
    //MARK: - METHODS
    func setupCellData(data: Contents.FetchContents.ViewModel.DisplayedContent) {
        if URL(string: data.webformatURL) != nil {
            let resource = ImageResource(downloadURL: URL(string: data.webformatURL)!, cacheKey: data.webformatURL)
            imgView.kf.setImage(with: resource, placeholder: UIImage(named: "placeholder"), options: nil, progressBlock: nil)
            
        }
        else{
            imgView.image = UIImage(named: "placeholder")
        }
    }
    
}
