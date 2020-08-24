//
//  UICollectionViewExt.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 22/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func dequeueCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        let cell = self.dequeueReusableCell(withReuseIdentifier: String(describing: cellType), for: indexPath) as! T
        return cell
    }
    
    
}
