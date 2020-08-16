//
//  AppNetworking.swift
//  User Demo
//
//  Created by Ravi on 15/08/20.
//  Copyright © 2020 Ravi. All rights reserved.
//

import Foundation

//MARK:================RESULT TYPE DECLARATION==========================

enum Result<Value: Decodable> {
    case success(Value)
    case failure(Error?,Bool)
}

typealias Handler = (Result<Data>) -> Void

enum NetworkError: Error {
    case nullData
}

//MARK:================API METHOD ENUM==========================

public enum Method {
    case delete
    case get
    case head
    case post
    case put
    case connect
    case options
    case trace
    case patch
    case other(method: String)
}

enum NetworkingError: String, LocalizedError {
    case jsonError = "JSON error"
    case other
    var localizedDescription: String { return NSLocalizedString(self.rawValue, comment: "") }
}

extension Method {
    public init(_ rawValue: String) {
        let method = rawValue.uppercased()
        switch method {
        case "DELETE":
            self = .delete
        case "GET":
            self = .get
        case "HEAD":
            self = .head
        case "POST":
            self = .post
        case "PUT":
            self = .put
        case "CONNECT":
            self = .connect
        case "OPTIONS":
            self = .options
        case "TRACE":
            self = .trace
        case "PATCH":
            self = .patch
        default:
            self = .other(method: method)
        }
    }
}

extension Method: CustomStringConvertible {
    public var description: String {
        switch self {
        case .delete:            return "DELETE"
        case .get:               return "GET"
        case .head:              return "HEAD"
        case .post:              return "POST"
        case .put:               return "PUT"
        case .connect:           return "CONNECT"
        case .options:           return "OPTIONS"
        case .trace:             return "TRACE"
        case .patch:             return "PATCH"
        case .other(let method): return method.uppercased()
        }
    }
}

protocol Requestable {}
//MARK:================PROTOCOL METHODS FOR WEBSERVICE==========================

extension Requestable {

    internal func request(method: Method, url: String, params: [NSString: Any]? = nil, callback: @escaping Handler) {

        guard let url = URL(string: url) else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url,  completionHandler: { (data, response, error) in
      
            DispatchQueue.main.async {
                
                if let error = error {
                    callback(.failure(error,true))
                    print(error.localizedDescription)
                    
                } else if let httpResponse = response as? HTTPURLResponse {
                    
                    if httpResponse.statusCode == 200 {
                        
                        if let jsonData = data{
                            callback(.success(jsonData))
                        }else{
                            callback(.failure(nil,true))
                        }
                        
                    } else {
                        
                        callback(.failure(nil,true))
                    }
                }
            }
        })
        task.resume()
    }
}

