//
//  HeaderViewCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON
import Kingfisher

protocol HeaderViewCellDelegate: AnyObject {
    func didTappAtBackButton()
}

class HeaderViewCell: UITableViewCell {
    
    static let key = "HeaderViewCell"
    static let nib = UINib(nibName: "HeaderViewCell", bundle: nil)
    
    @IBOutlet weak var ivBackdrop: UIImageView!
    @IBOutlet weak var posterView: UICornerRadiusImageView!
    @IBOutlet weak var ratingView: UIRatingView!
    @IBOutlet weak var lblReleaseDate: UILabel!
    @IBOutlet weak var genreView: UILabelView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblOverview: UILabel!
    @IBOutlet weak var lblReadmore: UILabel!
    @IBOutlet weak var lblFavorite: UILabel!
    @IBOutlet weak var actionView: UIView!
    
    
    weak var delegate: HeaderViewCellDelegate?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        actionView.layer.cornerRadius = Constants.cornerRadius
        actionView.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(_ data: JSON) {
        let backdrop = Constants.getImageURL(data[Constants.Reponse.backdrop].stringValue)
        ivBackdrop.kf.setImage(with: URL(string: backdrop))
        let poster = Constants.getImageURL(data[Constants.Reponse.poster].stringValue)
        posterView.setImage(poster)
        lblTitle.text = data[Constants.Reponse.title].stringValue
        lblOverview.text = data[Constants.Reponse.overview].stringValue
        lblFavorite.text = Constants.Localization.Detail.favorite.localized
        lblReadmore.text = Constants.Localization.Detail.readMore.localized
        let strDate = data[Constants.Reponse.releaseDate].stringValue
        let date = strDate.date(Constants.DateFormat.yyyymmdd)
        if let date = date {
            lblReleaseDate.text = date.string(Constants.DateFormat.mmmmyyyy)
        }
        genreView.setTitle(data[Constants.Reponse.genres][0][Constants.Reponse.name].stringValue)
    }
    
    @IBAction func tappedBackButton(_ sender: Any) {
        delegate?.didTappAtBackButton()
    }
    
}
