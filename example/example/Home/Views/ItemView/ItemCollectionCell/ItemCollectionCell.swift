//
//  ItemCollectionCell.swift
//  example
//
//  Created by ThoNX on 7/1/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

class ItemCollectionCell: UICollectionViewCell {
    
    static let key = "ItemCollectionCell"
    static let nib = UINib(nibName: "ItemCollectionCell", bundle: nil)

    @IBOutlet weak var imgView: UICornerRadiusImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func loadData(_ title: String, _ path: String) {
        lblTitle.text = title
        let url = Constants.getImageURL(path)
        imgView.setImage(url)
    }

}
