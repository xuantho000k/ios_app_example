//
//  ImageCollectionCell.swift
//  example
//
//  Created by ThoNX on 7/1/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

class ImageCollectionCell: UICollectionViewCell {
    
    static let key = "ImageCollectionCell"
    static let nib = UINib(nibName: "ImageCollectionCell", bundle: nil)

    @IBOutlet weak var imgView: UICornerRadiusImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func loadData(_ path: String) {
        let url = Constants.getImageURL(path)
        imgView.setImage(url)
    }

}
