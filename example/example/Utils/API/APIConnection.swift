//
//  APIConnection.swift
//  example
//
//  Created by ThoNX on 5/6/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

protocol Connection {
    typealias Completion = (JSON?, APIError?) -> Void
    
    func makeRequest(_ request: URLRequestConvertible, completion: @escaping Completion) -> DataRequest
}


class APIConnection: Connection {
    
    private let sessionManager: Session
    
    init() {
        let configuration = URLSessionConfiguration.af.default
        let delegate = SessionDelegate(fileManager: .default)
        let queue = DispatchQueue(label: "com.thonx.alamofire.session.rootQueue")
        let logger = APILogger()
        self.sessionManager = Session(configuration: configuration,
                                      delegate: delegate,
                                      rootQueue: queue,
                                      startRequestsImmediately: true,
                                      requestQueue: nil,
                                      serializationQueue: nil,
                                      interceptor: nil,
                                      serverTrustManager: nil,
                                      redirectHandler: nil,
                                      cachedResponseHandler: nil,
                                      eventMonitors: [logger])
    }
    
    @discardableResult
    func makeRequest(_ request: URLRequestConvertible, completion: @escaping Connection.Completion) -> DataRequest {
        let dataRequest = sessionManager.request(request).validate().responseData { (response) in
            if let error = response.error {
                self.handleError(error, completion)
            } else if let data = response.data {
                self.handleSuccessfulResponse(data, completion)
            } else {
                completion(nil, APIError(errorCode: .unknow, message: Constants.Localization.Error.somethingWentWrong.localized))
            }
        }
        
        return dataRequest
    }
    
    private func handleSuccessfulResponse(_ response: Data, _ completion: @escaping Connection.Completion) {
        if let json = try? JSON(data: response) {
            completion(json, nil)
        } else {
            completion(nil, APIError(errorCode: .jsonSerialization, message: Constants.Localization.Error.jsonSerialization.localized))
        }
    }
    
    private func handleError(_ error: Error, _ completion: @escaping Connection.Completion) {
        var code: APIErrorCode = .unknow
        var message = error.localizedDescription
        if let afError = error as? AFError,
            let responseCode = afError.responseCode {
            code = APIErrorCode(rawValue: responseCode) ?? .unknow
        } else {
            let nsError = error as NSError
            switch nsError.code {
            case NSURLErrorNotConnectedToInternet:
                code = .noNetwork
                message = Constants.Localization.Error.noNetwork.localized
            case NSURLErrorTimedOut:
                code = .timeout
                message = Constants.Localization.Error.timeout.localized
            default:
                break
            }
        }
        completion(nil, APIError(errorCode: code, message: message))
    }
}
