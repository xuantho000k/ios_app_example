//
//  ItemView.swift
//  example
//
//  Created by ThoNX on 7/1/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON

protocol ItemViewDelegate: AnyObject {
    
    func didTapAtItem(_ id: Int)
    func willLoadMore()
}

class ItemView: UICustomView {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    weak var delegate: ItemViewDelegate?
    
    private var data: RowModel?
    
    override func setupView() {
        super.setupView()
        
        collectionView.register(ItemCollectionCell.nib, forCellWithReuseIdentifier: ItemCollectionCell.key)
        collectionView.register(CenterTitleCollectionCell.nib, forCellWithReuseIdentifier: CenterTitleCollectionCell.key)
        collectionView.register(ImageCollectionCell.nib, forCellWithReuseIdentifier: ImageCollectionCell.key)
        collectionView.register(VideoCollectionCell.nib, forCellWithReuseIdentifier: VideoCollectionCell.key)
        collectionView.register(SubTitleCollectionCell.nib, forCellWithReuseIdentifier: SubTitleCollectionCell.key)
    }
    
    func loadData(_ data: RowModel) {
        self.data = data
        switch data.type {
        case .video, .cast:
            collectionView.allowsSelection = false
        default:
            collectionView.allowsSelection = true
        }
        reloadData()
    }
    
    func reloadData() {
        collectionView.reloadData()
    }

}

extension ItemView: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var size = CGSize(width: 0, height: 0)
        switch data?.type {
        case .nowPlaying:
            size = CGSize(width: Constants.screenSize.width - 66, height: 166)
        case .category:
            size = CGSize(width: 140, height: 83)
        case .cast:
            size = CGSize(width: 70, height: 135)
        case .video:
            size = CGSize(width: 200, height: 120)
        default:
            size = CGSize(width: 140, height: 245)
        }
        
        return size
    }

}

extension ItemView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let data = data?.data {
            
            return data.arrayValue.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var cell: UICollectionViewCell? = nil
        let json = data?.data
        let item = json![indexPath.row]
            
        switch data?.type {
        case .nowPlaying:
            let temp = collectionView.dequeueReusableCell(withReuseIdentifier: ImageCollectionCell.key, for: indexPath) as! ImageCollectionCell
            temp.loadData(item[Constants.Reponse.poster].stringValue)
            
            cell = temp
        case .category:
            let temp = collectionView.dequeueReusableCell(withReuseIdentifier: CenterTitleCollectionCell.key, for: indexPath) as! CenterTitleCollectionCell
            temp.loadTitle(item.stringValue)
            
            cell = temp
        case .cast:
            let temp = collectionView.dequeueReusableCell(withReuseIdentifier: SubTitleCollectionCell.key, for: indexPath) as! SubTitleCollectionCell
            temp.loadData(item)
            
            cell = temp
        case .video:
            let temp = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCollectionCell.key, for: indexPath) as! VideoCollectionCell
//            temp.loadTitle(item.stringValue)
            
            cell = temp
        default:
            let temp = collectionView.dequeueReusableCell(withReuseIdentifier: ItemCollectionCell.key, for: indexPath) as! ItemCollectionCell
            temp.loadData(item[Constants.Reponse.title].stringValue, item[Constants.Reponse.poster].stringValue)
            
            cell = temp
        }
        
        return cell!
    }
    
}

extension ItemView: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if data?.type != RowType.category {
            let json = data?.data
            let item = json![indexPath.row]
            
            delegate?.didTapAtItem(item[Constants.Reponse.id].intValue)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if data?.type != RowType.category ||
            data?.type != RowType.cast ||
            data?.type != RowType.video{
            let json = data?.data
            if indexPath.row == json!.arrayValue.count - 1 {
                delegate?.willLoadMore()
            }
        }
    }
    
}
