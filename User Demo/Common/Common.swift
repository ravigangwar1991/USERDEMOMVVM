//
//  Common.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation

//MARK:================FILE TO GET DATA FROM BUNDLE==========================


final class FileDataService  {

    static let shared = FileDataService()
}

extension FileManager {
    
    static func readJson(forResource fileName: String ) -> Data? {
        
        let bundle = Bundle.main
        
        if let path = bundle.url(forResource:fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf:path)
                return data
            } catch {
                // handle error
            }
        }
        
        return nil
    }
}
