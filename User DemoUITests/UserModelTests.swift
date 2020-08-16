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
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
        self.userService = nil
    }

    
    func testParseEmptyUserData() {
        
        // giving empty data
        let data = Data()
        
        do{
            let mappedModel = try JSONDecoder().decode(UserDataResponse.self, from: data) as UserDataResponse
            
            if mappedModel.userList.isEmpty{
                XCTAssert(false, "Json data is not an array")
            }else{
                XCTAssert(true, "Json data is an array")
            }
        }catch{
            XCTAssert(true, "Json data is not an array")
        }
        
    }
    
    func testParseUserData() {
        
        // giving data
        guard let data = FileManager.readJson(forResource: "User") else {
            XCTAssert(false, "Can't get data from user.json")
            return
        }
        
        do{
            let mappedModel = try JSONDecoder().decode(UserDataResponse.self, from: data) as UserDataResponse
            
            if mappedModel.userList.isEmpty{
                XCTAssert(false, "Json data is not an array")
            }else{
                XCTAssert(true, "Json data is an array")
            }
        }catch{
            XCTAssert(true, "Json data is not an array")
        }
        
    }
    
    func test_fetchUserList(){
        
        self.userService.fetchUserList { (result) in
            switch result {
                
            case .success(let data):
                
                guard (try? JSONDecoder().decode(UserDataResponse.self, from: data) as UserDataResponse) != nil else {
                    XCTAssert(false, "Json data is not an array")
                    return
                }
                
                XCTAssert(true, "Json data is  an array")

            case .failure(let error,_):
                
                XCTAssert(false, error?.localizedDescription ?? "")

            }
        }
        
    }
    
}
