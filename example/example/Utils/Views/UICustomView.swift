//
//  UICustomView.swift
//  example
//
//  Created by ThoNX on 6/5/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import UIKit

class UICustomView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    func setupView() {
        let view = viewFromNibForClass()
        addFullSubView(child: view)
    }

}
