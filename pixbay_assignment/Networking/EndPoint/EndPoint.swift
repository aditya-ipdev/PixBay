//
//  EndPoint.swift
//  pixbay_assignment
//
//  Created by Aditya Sharma on 21/08/20.
//  Copyright © 2020 Aditya Sharma. All rights reserved.
//

import Foundation




enum EndPoint {
    case searchImage(params: Parameters?)
}

extension EndPoint: EndPointType {
    
    struct Key{
        static var value: String = "17990157-917fdb4364fbaef8398723392"
    }
    
    var enviornemntURL: String {
        return  "https://pixabay.com/api/?"
    }
    
    var baseURL: URL {
        guard let url = URL(string: enviornemntURL) else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .searchImage:
            return ""
        }
    }
    
    var httpTask: HTTPTask {
        switch self {
        case .searchImage(let params):
//            let urlParametes: [String: Any] = [ParamterKeys.apikey.rawValue: key,
//                                ParamterKeys.query.rawValue: query,
//                                ParamterKeys.perPage.rawValue: page
//                                ]
            return .requestParameters(bodyParameters: nil, bodyEncoding: .urlEncoding, urlParameters: params)
        }
    }
        
    
}



//https://pixabay.com/api/?key=17990157-917fdb4364fbaef8398723392&q=yellow+flowers&image_type=photo
