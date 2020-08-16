//
//  UserModel.swift
//  User Demo
//
//  Created by Ravi on 14/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation

//MARK:================MODEL TO PARSE USER API RESPONSE==========================

struct UserDataResponse: Codable {
    
    var userList: [UserModel] = []
    
    init(from decoder: Decoder) throws{
        
        var container = try decoder.unkeyedContainer()
        while !container.isAtEnd{
            let user = try container.decode(UserModel.self)
            self.userList.append(user)
        }
    }
    
    init() {
        
    }
    
}

//MARK:================MODEL FOR USER DATA==========================

struct UserModel : Codable {
    let id : Int?
    let name : String?
    let username : String?
    let email : String?
    let address : Address?
    let phone : String?
    let website : String?
    let company : Company?
    
    var isFav = false
    
    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case name = "name"
        case username = "username"
        case email = "email"
        case address = "address"
        case phone = "phone"
        case website = "website"
        case company = "company"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        username = try values.decodeIfPresent(String.self, forKey: .username)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(Address.self, forKey: .address)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        website = try values.decodeIfPresent(String.self, forKey: .website)
        company = try values.decodeIfPresent(Company.self, forKey: .company)
    }
    
}

//MARK:================MODEL FOR USER ADDRESS==========================

struct Address : Codable {
    let street : String?
    let suite : String?
    let city : String?
    let zipcode : String?
    let geo : Geo?
    
    enum CodingKeys: String, CodingKey {
        
        case street = "street"
        case suite = "suite"
        case city = "city"
        case zipcode = "zipcode"
        case geo = "geo"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        street = try values.decodeIfPresent(String.self, forKey: .street)
        suite = try values.decodeIfPresent(String.self, forKey: .suite)
        city = try values.decodeIfPresent(String.self, forKey: .city)
        zipcode = try values.decodeIfPresent(String.self, forKey: .zipcode)
        geo = try values.decodeIfPresent(Geo.self, forKey: .geo)
    }
    
}

//MARK:================MODEL FOR USER LOCATION GEOCODE==========================


struct Geo : Codable {
    let lat : String?
    let lng : String?
    
    enum CodingKeys: String, CodingKey {
        
        case lat = "lat"
        case lng = "lng"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        lat = try values.decodeIfPresent(String.self, forKey: .lat)
        lng = try values.decodeIfPresent(String.self, forKey: .lng)
    }
    
}

//MARK:================MODEL FOR USER COMPANY DETAILS==========================

struct Company : Codable {
    let name : String?
    let catchPhrase : String?
    let bs : String?
    
    enum CodingKeys: String, CodingKey {
        
        case name = "name"
        case catchPhrase = "catchPhrase"
        case bs = "bs"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        catchPhrase = try values.decodeIfPresent(String.self, forKey: .catchPhrase)
        bs = try values.decodeIfPresent(String.self, forKey: .bs)
    }
    
}
