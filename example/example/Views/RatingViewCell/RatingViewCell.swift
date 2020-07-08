//
//  RatingViewCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

class RatingViewCell: UITableViewCell {
    
    static let key = "RatingViewCell"
    static let nib = UINib(nibName: "RatingViewCell", bundle: nil)

    @IBOutlet weak var titleView: UITitleView!
    @IBOutlet weak var ratingView: UIRatingView!
    @IBOutlet weak var lblRate: UILabel!
    @IBOutlet weak var btnWrite: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblRate.text = "0.0"
        btnWrite.layer.cornerRadius = Constants.cornerRadius
        btnWrite.setTitle(Constants.Localization.Detail.writeAComment.localized, for: .normal)
        titleView.setTitle(Constants.Localization.Detail.yourRate.localized)
    }

    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
