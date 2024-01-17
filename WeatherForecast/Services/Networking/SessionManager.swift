//
//  SessionManager.swift
//  WeatherForecast
//
//  Created by Sanjeev on 14/01/24.
//

import Foundation
import Alamofire
import RxSwift
import SwiftyJSON
import RxAlamofire

private let logRawHtmlCode = true
private let logAllRequests = true

public extension Reactive where Base: Session {
    func netRequest(_ method: Alamofire.HTTPMethod,
                    _ url: URLConvertible,
                    parameters: [String: Any]? = nil,
                    encoding: ParameterEncoding = JSONEncoding.default,
                    headers: HTTPHeaders? = nil,
                    log: Bool = false,
                    autohandleUnauthorizedError: Bool = true
    ) -> Observable<(HTTPURLResponse, SwiftyJSON.JSON)> {
        var logDetailedResponse = true
        var newHeaders = headers
        var token: String? = nil
        if let token = token {
            if headers == nil {
                newHeaders = HTTPHeaders(["Authorization": "Bearer " + token])
            } else {
                newHeaders?.add(HTTPHeader(name: "Authorization", value: "Bearer " + token))
            }
            print("[Token] \(token)")
        }

        return request(method, url, parameters: parameters, encoding: encoding, headers: newHeaders).flatMap { request -> Observable<(HTTPURLResponse, SwiftyJSON.JSON)> in
            print("[NET] \(request)")
            if log || logAllRequests {
                if let body = request.request?.httpBody, let str = String(data: body, encoding: String.Encoding.utf8) {
                    print("[NET] REQUEST BODY: \(str)")
                }
            }
            var _request = request
                .response { response in
                    let code = response.response?.statusCode ?? 0
                    let url = response.request?.url?.absoluteString ?? "UNKNOWN URL"
                    print("[NET] \(code) \(url)")
            }
            if log || logAllRequests {
                _request = _request.responseJSON(completionHandler: { response in
                    switch response.result {
                    case .success:
                        let json = SwiftyJSON.JSON(response.value ?? "error")
                        if json.error == nil {
                            print("      BODY JSON: \(json)")
                            logDetailedResponse = false
                        }
                    case .failure:
                        break
                    }
                })
                    .responseString(completionHandler: { response in
                        if logDetailedResponse {
                            var str = response.value ?? "epmty response string"
                            if !logRawHtmlCode && str.contains("<!DOCTYPE html>") {
                                str = "html rendered page"
                            }
                            print("      BODY STRING: \(str)")
                        }
                    })
            }

            return _request.rx
                .responseData()
                .map({ (response: HTTPURLResponse, dict: Any) -> (HTTPURLResponse, JSON) in

                    let json = SwiftyJSON.JSON(dict)
                    
                    guard response.statusCode != ErrorCodes.unauthorized.rawValue else {
                        let status = json["error"].string ?? json["message"].string
                        let error = NETError.unathorized(status)
                        throw error
                    }

                    if json["success"].bool == false,
                        let message = json["message"].string {
                        throw NETError.custom(message)
                    }
                    
                    if response.statusCode == ErrorCodes.serverError.rawValue || response.statusCode == ErrorCodes.badRequest.rawValue || response.statusCode == ErrorCodes.badGateway.rawValue || response.statusCode == ErrorCodes.forbidden.rawValue || response.statusCode == ErrorCodes.notFound.rawValue {
                        if let message = json["msg"].string {
                            throw NETError.custom(message)
                        } else if let message = json["message"].string {
                            throw NETError.custom(message)
                        }
                    }

                    if let status = json["status"].string,
                        status == "error",
                        let errors = json["errors"].array,
                        let error = errors.first?.string {
                        throw NETError.custom(error)
                    }

                    if let error = json["error"].string {
                        guard response.statusCode != ErrorCodes.notFound.rawValue else {
                            throw NETError.notFound(error)
                        }
                        
                        guard response.statusCode != ErrorCodes.forbidden.rawValue else {
                            throw NETError.forbidden(error)
                        }

                        throw NETError.custom(error)
                    }

                    guard response.statusCode == ErrorCodes.success.rawValue else {throw NETError.failureResponse(response.statusCode)}

                    guard json.error == nil else {
                        throw NETError.badJSON
                    }

                    return (response, json)
                })
        }

    }
}

