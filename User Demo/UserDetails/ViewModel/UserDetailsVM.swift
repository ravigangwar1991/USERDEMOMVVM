//
//  UserDetailsVM.swift
//  User Demo
//
//  Created by Ravi on 14/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation


protocol UserDetailsVMProtocol {
    
    var reloadView: (() -> Void)? { get set }
    func markFavorite()
}

class UserDetailsVM{
    
    //MARK:================PROPERTIES==========================

    var reloadView: (() -> Void)?
    
    private var userModel: UserModel? {
        didSet {
            self.reloadView?()
        }
    }
    
    var selectedIndex:Int = 0
    
    //MARK:================CUSTOM METHOD==========================

    func setUserData(index:Int,user:UserModel?){
        self.selectedIndex = index
        userModel = user
    }
    
    func getNumberOfRows()->Int{
        return 1
    }
    
    func getUser()->UserModel?{
        return self.userModel
    }
    
   func updateFavStatus(index:Int){
          self.userModel?.isFav = !(self.userModel?.isFav ?? false)
    }
}
