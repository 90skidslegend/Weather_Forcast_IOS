//
//  ErrorCodesEnum.swift
//  Veersky
//
//  Created by vThink on 19/04/23.
//  Copyright © 2023 Veersky. All rights reserved.
//

enum ErrorCodes: Int {
    case success = 200
    case created = 201
    case noContent = 204
    case badRequest = 400
    case unauthorized = 401
    case paymentRequired = 402
    case forbidden = 403
    case notFound = 404
    case serverError = 500
    case notImplemented = 501
    case badGateway = 502
    
    var message: String {
        switch self {
        case .success:
            return "Successfull"
        case .created:
            return "Created"
        case .noContent:
            return "No Content"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .paymentRequired:
            return "Payment Required"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .serverError:
            return "Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .badGateway:
            return "Bad Gateway"
        }
    }
}
