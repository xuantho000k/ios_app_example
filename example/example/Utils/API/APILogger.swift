//
//  APILogger.swift
//  example
//
//  Created by ThoNX on 3/16/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Alamofire

final class APILogger: EventMonitor {
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
        debugPrint("\(request.description)")
    }
}
