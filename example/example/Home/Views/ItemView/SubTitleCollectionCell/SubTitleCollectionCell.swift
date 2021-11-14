//
//  SubTitleCollectionCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON

class SubTitleCollectionCell: UICollectionViewCell {
    
    static let key = "SubTitleCollectionCell"
    static let nib = UINib(nibName: "SubTitleCollectionCell", bundle: nil)

    @IBOutlet weak var imgView: UICornerRadiusImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblPosition: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func loadData(_ data: JSON) {
        lblName.text = data[Constants.Reponse.name].stringValue
        let url = Constants.getImageURL(data[Constants.Reponse.profilePath].stringValue)
        imgView.setImage(url)
    }

}
