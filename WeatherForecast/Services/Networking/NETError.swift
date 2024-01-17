//
//  NetError.swift
//  Veersky
//
//  Created by Boris Sedov on 05.08.2020.
//  Copyright © 2020 Boris Sedov. All rights reserved.
//

import Foundation

let kUnauthorizedDefaultTitle = "Hi!"
let kUnauthorizedDefaultMessage = "Your session has expired. Please log in again."
let kUnauthorizedReviewMessage = "Hi! An email + password signs you up. Thanks!"
let kUnauthorizedErrorNotificationName = Notification.Name("unauthorized_response")
let forbiddenDefaultMessage = "Access Restricted"

enum NETError: Error {
    case unsuccessful
    case failureResponse(_: Int?)
    case badJSON
    case parsingError(_: String)
    case unknown
    case custom(_: String)
    case notFound(_: String)
    case unathorized(_: String?)
    case forbidden(_: String?)
    case silent

    var localizedDescription: String {
        switch self {
        case .unsuccessful: return "Failure response"
        case .failureResponse(let code): return "Failure response (\(code ?? 0))"
        case .badJSON: return "Bad response format"
        case .parsingError(let fieldName): return "Reponse parsing failed (\(fieldName))"
        case .custom(let str): return str
        case .unathorized(let message):
            return message ?? kUnauthorizedDefaultMessage
        case .notFound(let message): return message
        case .forbidden(let message): return message ?? forbiddenDefaultMessage
        default: return "Unknown"
        }
    }

    var code: Int? {
        switch self {
        case .failureResponse(let responseCode): return responseCode
        case .notFound: return 404
        case .forbidden( _): return 403
        default: return nil
        }
    }
}
