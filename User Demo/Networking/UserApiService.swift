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
    
    public var movies: [UserModel]?

    func fetchUserList(callback: @escaping Handler) {
        
        request(method: .get, url: Domain.baseUrl() + APIEndpoint.userList) { (result) in
            
           callback(result)
        }
        
    }
    
    func getDataFromModel(callback: @escaping Handler){
        
        if let data = FileManager.readJson(forResource: "User"){
            callback(.success(data))
        }else{
            callback(.failure(nil, false))
        }
    }
    
}
