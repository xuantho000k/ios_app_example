//
//  CommentViewCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON

class CommentViewCell: UITableViewCell {
    
    static let key = "CommentViewCell"
    static let nib = UINib(nibName: "CommentViewCell", bundle: nil)

    @IBOutlet weak var lblAuthor: UILabel!
    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var ratingView: UIRatingView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var titleView: UITitleView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(_ data: JSON, _ hidenTitleView: Bool) {
        titleView.isHidden = hidenTitleView
        if !hidenTitleView {
            titleView.setTitle(Constants.Localization.Detail.comments.localized)
        }
        lblAuthor.text = data[Constants.Reponse.author].stringValue
        lblContent.text = data[Constants.Reponse.content].stringValue
    }
    
}
