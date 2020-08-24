//
//  UserModelTests.swift
//  User DemoUITests
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import XCTest

class UserModelTests: XCTestCase {
    
    var userService:UserAPIService!
    var listVm:UserListVM!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.userService = UserAPIService()
        self.listVm = UserListVM()
       
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.userService = nil
    }
    
    func test_fetchUserList(){
        
        self.userService.fetchUserList { (result) in
            switch result {
                
            case .success(let data):
                
                guard let mappedModel = (try? JSONDecoder().decode(UserDataResponse.self, from: data) as UserDataResponse) else {
                    XCTAssert(false, "Json data is not an array")
                    return
                }
                self.listVm.userList = mappedModel.userList
                self.test_getgetNumberOfRows()
                XCTAssert(true, "Json data is  an array")

            case .failure(let error,_):
                
                XCTAssert(false, error?.localizedDescription ?? "")

            }
        }
        
    }
    
    func test_getgetNumberOfRows(){
        
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if wSelf.listVm.getNumberOfRows() == 0{
                XCTAssert(false, "No data available")
            }else{
                XCTAssert(true, "item avalible ==\(wSelf.listVm.getNumberOfRows())")
            }
        }
    }
    
    
    func test_getUser(){
        
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.listVm.getUser(index: 0){
                XCTAssert(true, "User is \(user.name ?? "")")
            }else{
                XCTAssert(false, "user not avilable")
            }
        }
    }
    
    
    
    func test_updateDataAtIndex(){
        
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.listVm.getUser(index: 0){
                self?.listVm.updateDataAtIndex(index: 0, user: user)
                XCTAssert(true, "update data at index 0")
            }else{
                XCTAssert(false, "user data not updated")
            }
        }
    }
    
    func test_updateFavStatus(){
        
        self.listVm.reloadView = {[weak self] in
            guard let wSelf = self else {return}
            if let user = wSelf.listVm.getUser(index: 0){
                wSelf.listVm.updateFavStatus(index: 0)
                XCTAssert(true, "Fav status updated for user \(user.name ?? "")")
            }else{
                XCTAssert(false, "Fav status not updated")
            }
        }

    }
    
}
