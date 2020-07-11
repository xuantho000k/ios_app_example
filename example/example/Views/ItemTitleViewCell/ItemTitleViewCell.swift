//
//  ItemTitleViewCell.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/1/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

protocol ItemTitleViewCellDelegate: AnyObject {

    func didTapAtCell(withItemId id: Int)
    func loadMoreDataForCell(_ cell: ItemTitleViewCell)
    
}

class ItemTitleViewCell: UITableViewCell {
    
    static let key = "ItemTitleViewCell"
    static let nib = UINib(nibName: "ItemTitleViewCell", bundle: nil)

    @IBOutlet weak var titleView: UITitleView!
    @IBOutlet weak var itemView: ItemView!
    @IBOutlet weak var lcHeight: NSLayoutConstraint!
    
    weak var delegate: ItemTitleViewCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        itemView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func loadData(_ data: RowModel) {
        var height: CGFloat = 0
        var hideOpenButton = false
        var backgroundColor = UIColor(red: 248/255.0, green: 248/255.0, blue: 248/255.0, alpha: 1)
        switch data.type {
        case .nowPlaying:
            height = 166
            backgroundColor = UIColor.white
        case .category:
            height = 83
            backgroundColor = UIColor.white
        case .cast:
            height = 135
            hideOpenButton = true
        case .video:
            height = 120
            hideOpenButton = true
        default:
            if data.type != .recomendation {
                backgroundColor = UIColor.white
            }
            height = 245
        }
        titleView.hidenOpenButton(hideOpenButton)
        titleView.backgroundColor = backgroundColor
        lcHeight.constant = height
        titleView.setTitle(data.title)
        itemView.loadData(data)
    }
    
    func reloadView() {
        itemView.reloadData()
    }
    
}

extension ItemTitleViewCell: ItemViewDelegate {
    
    func didTapAtItem(_ id: Int) {
        delegate?.didTapAtCell(withItemId: id)
    }
    
    func willLoadMore() {
        delegate?.loadMoreDataForCell(self)
    }
    
}
