//
//  UICornerRadiusImageView.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import Kingfisher

class UICornerRadiusImageView: UICustomView {
    
    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var imgView: UIImageView!
    
    override func setupView() {
        super.setupView()
        
        imgView.layer.masksToBounds = true
        backgroundView.layer.masksToBounds = true
        
        backgroundView.layer.shadowOffset = CGSize(width: 3, height: 3)
        backgroundView.layer.shadowColor = UIColor(red: 0.29, green: 0.29, blue: 0.29, alpha: 1.0).cgColor
        backgroundView.layer.shadowOpacity = 0.7
        backgroundView.layer.shadowRadius = Constants.cornerRadius
        backgroundView.layer.cornerRadius = Constants.cornerRadius
        backgroundView.clipsToBounds = false
    }

    override func draw(_ rect: CGRect) {
        setCornerRadius(6)
    }
    
    private func setCornerRadius(_ cornerRadius: CGFloat) {
        imgView.layer.cornerRadius = cornerRadius
    }
    
    func setImage(_ url: String) {
//        debugPrint("Image path: \(url)")
        imgView.kf.indicatorType = .activity
        imgView.kf.setImage(with: URL(string: url))
    }

}
