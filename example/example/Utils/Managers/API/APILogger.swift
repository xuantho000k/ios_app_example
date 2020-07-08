//
//  APILogger.swift
//  example
//
//  Created by ThoNX on 3/16/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Alamofire

final class APILogger: EventMonitor {
//    let queue = DispatchQueue(label: ...)
    
    // Event called when any type of Request is resumed.
//    func requestDidResume(_ request: Request) {
//        print("Resuming: \(request)")
//    }
    
    // Event called whenever a DataRequest has parsed a response.
    func request<Value>(_ request: DataRequest, didParseResponse response: DataResponse<Value, AFError>) {
//        debugPrint("\(response.debugDescription)")
        debugPrint("\(request.description)")
    }
}
