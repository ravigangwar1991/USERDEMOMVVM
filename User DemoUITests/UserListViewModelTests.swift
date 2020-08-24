//
//  UserListViewModelTests.swift
//  User DemoUITests
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import XCTest

class UserListViewModelTests: XCTestCase {

    var detailVM:UserDetailsVM!
    var listVm:UserListVM!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.detailVM = UserDetailsVM()
        
        self.listVm = UserListVM()
        self.listVm.fetchUserList(view: UIView())
        
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.detailVM = nil
        self.listVm = nil
    }

    func test_setUserData(){
        
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.detailVM.getUser(){
                XCTAssert(true, "User is \(user.name ?? "")")
            }else{
                XCTAssert(false, "user not avilable")
            }
        }
    }
    
    func test_getUser(){
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.listVm.getUser(index: 0){
                wSelf.detailVM.setUserData(index: 0, user: user)
                XCTAssert(true, "model setup succesfully")
            }else{
                XCTAssert(false, "user not avilable")
            }
        }
    }
    
    func test_updateFavStatus(){
           
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.detailVM.getUser(){
                wSelf.detailVM.updateFavStatus(index: 0)
                XCTAssert(true, "Fav status updated for user \(user.name ?? "")")
            }else{
                XCTAssert(false, "Fav status not updated")
            }
        }
        
    }

}
