//
//  CommonExtension.swift
//  example
//
//  Created by ThoNX on 7/6/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        
        return NSLocalizedString(self, comment: "")
    }
    
    func date(_ dateFormat: String) -> Date? {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        
        return format.date(from: self)
    }
    
}

extension Date {
    
    func string(_ dateFormat: String) -> String {
        let format = DateFormatter()
        format.dateFormat = dateFormat
        
        return format.string(from: self)
    }
    
}
