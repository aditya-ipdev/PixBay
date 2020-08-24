//
//  StringExt.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 23/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation


extension String {
    subscript(indx: Int) -> String {
        return String(self[index(startIndex, offsetBy: indx)])
    }
    
}
