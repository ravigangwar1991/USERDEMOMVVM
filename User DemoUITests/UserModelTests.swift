//
//  UserModelTests.swift
//  User DemoUITests
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import XCTest

class UserModelTests: XCTestCase {
    
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
        guard let data = FileManager.readJson(forResource: "user") else {
            XCTAssert(true, "Can't get data from sample.json")
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
    
}
