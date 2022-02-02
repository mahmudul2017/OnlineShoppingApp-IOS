//
//  ApiService.swift
//  OnlineShoppingApp-IOS
//
//  Created by Mahmudul on 27/1/22.
//

import Foundation
import Combine

class ApiService {
    static let webBaseUrl = "https://jsonplaceholder.typicode.com/"
    
    enum APIFailureCondition: Error {
        case InvalidServerResponse
    }
}

func getCommonUrlRequest(url: URL) -> URLRequest {
    let request = URLRequest(url: url)
    return request
}

