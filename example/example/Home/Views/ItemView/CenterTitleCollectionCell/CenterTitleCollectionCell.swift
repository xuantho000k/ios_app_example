//
//  CenterTitleCollectionCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

class CenterTitleCollectionCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UICornerRadiusImageView!
    @IBOutlet weak var gradientView: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    
    static let key = "CenterTitleCollectionCell"
    static let nib = UINib(nibName: "CenterTitleCollectionCell", bundle: nil)

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func loadTitle(_ title: String) {
        lblTitle.text = title
    }

}
