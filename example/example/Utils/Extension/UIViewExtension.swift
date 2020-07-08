//
//  UIViewExtension.swift
//  example
//
//  Created by ThoNX on 5/22/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    func viewFromNibForClass() -> UIView {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: String(describing: type(of: self)), bundle: bundle)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        
        return view
    }
    
    func viewFromParentView(parentView: UIView) -> UIView? {
        var view: UIView?
        for child: UIView in parentView.subviews {
            if (String(describing: child.self) == String(describing: self)) {
                view = child
                
                break
            }
        }
        
        return view
    }
    
    func hide(parentView: UIView) {
        
    }
    
    func addFullSubView(child: UIView) {
        child.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(child)
        
        NSLayoutConstraint.activate([
            child.leadingAnchor.constraint(equalTo: leadingAnchor),
            child.trailingAnchor.constraint(equalTo: trailingAnchor),
            child.topAnchor.constraint(equalTo: topAnchor),
            child.bottomAnchor.constraint(equalTo: bottomAnchor)
            ])
    }
    
}
