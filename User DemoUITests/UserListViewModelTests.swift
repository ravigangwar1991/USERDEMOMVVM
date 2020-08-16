//
//  UserListViewModelTests.swift
//  User DemoUITests
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import XCTest

class UserListViewModelTests: XCTestCase {

    var userService:UserAPIService!
    var listVm:UserListVM!
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        super.setUp()
        self.userService = UserAPIService()
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.userService = nil
    }

    func test_fetchUserList(){
        
        self.listVm = UserListVM()
    }

}
