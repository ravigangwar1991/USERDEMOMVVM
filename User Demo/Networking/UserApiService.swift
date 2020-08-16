//
//  UserApiService.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation

//MARK:================USER WEBSERIVE METHOD==========================

class UserAPIService: NSObject, Requestable {

    static let instance = UserAPIService()
    
    public var movies: [UserModel]?

    func fetchMovies(callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.userList) { (result) in
            
           callback(result)
        }
        
    }
    
}
