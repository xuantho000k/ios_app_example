//
//  UITitleView.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

@IBDesignable class UITitleView: UICustomView {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnOpen: UIButton!
    
    @IBInspectable var showOpenButton: Bool = true
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        btnOpen.isHidden = !showOpenButton
    }
    
    func hidenOpenButton(_ hide: Bool) {
        btnOpen.isHidden = hide
    }
    
    func setTitle(_ title: String) {
        lblTitle.text = title
    }

}
