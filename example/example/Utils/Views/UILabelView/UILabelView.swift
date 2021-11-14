//
//  UILabelView.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/7/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

@IBDesignable class UILabelView: UICustomView {

    @IBOutlet weak var lblTitle: UILabel!
    
    override func setupView() {
        super.setupView()
        
    }
    
    override func draw(_ rect: CGRect) {
        layer.masksToBounds = true
        layer.cornerRadius = rect.height/2
    }
    
    func setTitle(_ title: String) {
        lblTitle.text = title
    }

}
