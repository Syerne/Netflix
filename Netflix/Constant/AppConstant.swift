//
//  AppConstant.swift
//  Netflix
//
//  Created by shubam on 05/07/24.
//

import Foundation

class AppConstant: NSObject {
    static let baseURL: String = "http://www.omdbapi.com/"
    static let apikey: String = "a07cf866"
}


enum APIError: Error {
    case failedToGetData
    case invalidURL
}
