//
//  UserListVM.swift
//  User Demo
//
//  Created by Ravi on 14/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation
import UIKit

protocol UserListVMProtocol {
    
    var reloadView: (() -> Void)? { get set }
    func fetchUserList(view:UIView)
}

class UserListVM:UserListVMProtocol{
    
    //MARK:================PROPERTIES==========================

    var reloadView: (() -> Void)?
    var userService:UserAPIService!
    
    var userList: [UserModel]? {
        didSet {
            self.reloadView?()
        }
    }
    
    init() {
        self.userService = UserAPIService()
    }
    
    //MARK:================CUSTOM METHOD==========================

    func getNumberOfRows()->Int{
        self.userList?.count ?? 0
    }
    
    func getUser(index:Int)->UserModel?{
        return self.userList?[index]
    }
    
    func updateDataAtIndex(index:Int,user:UserModel){
        self.userList?[index] = user
        self.reloadView?()
    }
    
    func updateFavStatus(index:Int){
        self.userList?[index].isFav = !(self.userList?[index].isFav ?? false)
    }
    
    //MARK:================METHOD TO FETCH USER LIST FROM API==========================
    
    func fetchUserList(view:UIView) {
        
        self.userList = [UserModel]()
        showActivityLoader(view: view)
        self.userService.fetchUserList { (result) in
            hideActivityLoader()
            switch result {
                
            case .success(let data):
                
                let mappedModel = try? JSONDecoder().decode(UserDataResponse.self, from: data) as UserDataResponse
                
                self.userList = mappedModel?.userList ?? []
                
            case .failure(let error,_):
                
                print(error?.localizedDescription ?? "")
            }
        }
    }
}
