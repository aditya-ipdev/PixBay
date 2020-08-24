//
//  XibContainerView.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 24/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import UIKit


class XibContainerView: UIView {
    
    var contentView: UIView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xibSetup()
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        xibSetup()
    }
    
    private func xibSetup() {
        contentView = loadViewFromNib()
        self.addSubview(contentView!)
        contentView?.createConstraints(
            attributes: [(.leading, 0, self, .leading, 1),
                         (.top, 0, self, .top, 1),
                         (.trailing, 0, self, .trailing, 1),
                         (.bottom, 0, self, .bottom, 1)],
            active: true)
    }
    
    private func loadViewFromNib() -> UIView! {
        let bundle = Bundle.main//(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        return view
    }
    
}
