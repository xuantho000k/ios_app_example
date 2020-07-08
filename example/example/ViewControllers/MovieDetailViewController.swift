//
//  MovieDetailViewController.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/5/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON

class MovieDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var id: Int = 0
    var data: [RowModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .lightContent
    }
    
    private func setup() {
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ItemTitleViewCell.nib, forCellReuseIdentifier: ItemTitleViewCell.key)
        tableView.register(HeaderViewCell.nib, forCellReuseIdentifier: HeaderViewCell.key)
        tableView.register(RatingViewCell.nib, forCellReuseIdentifier: RatingViewCell.key)
        tableView.register(CommentViewCell.nib, forCellReuseIdentifier: CommentViewCell.key)
        tableView.contentInsetAdjustmentBehavior = .never
        
        getData()
    }
    
    private func getData() {
        let group = DispatchGroup()
        group.enter()
        APIManager.shared.getMovieDetail(id) { (result, error) in
            _ = self.handleResult(result, 0, .header)
            group.leave()
        }
        
        group.enter()
        APIManager.shared.getSeriesCast(id) { (result, error) in
            _ = self.handleResult(result, 0, .cast)
            group.leave()
        }
        
        group.enter()
        APIManager.shared.getVideos(id) { (result, error) in
            _ = self.handleResult(result, 0, .video)
            group.leave()
        }
        
        group.enter()
        getComments(1) { (isSuccess) in
            group.leave()
        }
        
        group.enter()
        getRecomendations(1) { (isSuccess) in
            group.leave()
        }
        
        group.notify(queue: .main) {
            let r = RowModel(data: JSON(0),
                             totalPages: 0,
                             type: .rate)
            self.data.append(r)
            
            self.data = self.data.sorted(by: { (r1, r2) -> Bool in
                return r1.type.rawValue < r2.type.rawValue
            })

            self.tableView.reloadData()
        }
    }
    
    private func getComments(_ page: Int, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getComments(id, page) { (result, error) in
            completion(self.handleResult(result, page, .comment))
        }
    }
    
    private func getRecomendations(_ page: Int, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getMovieRecomendations(id, page) { (result, error) in
            completion(self.handleResult(result, page, .recomendation))
        }
    }
    
    private func handleResult(_ result: JSON?, _ page: Int, _ type: RowType) -> Bool {
        guard let result = result else { return false }
        if page <= 1 {
            var jsonData: JSON? = nil
            var total = 0
            switch type {
            case .header:
                jsonData = result
            case .cast:
                jsonData = result[Constants.Reponse.cast]
            default:
                jsonData = result[Constants.Reponse.result]
                if type == .comment || type == .recomendation {
                    total = result[Constants.Reponse.totalPage].intValue
                }
            }
            let n = RowModel(data: jsonData!,
                             totalPages: total,
                             type: type)
            self.data.append(n)
        } else {
            let model = self.data[type.rawValue]
            let new = JSON(model.data.arrayValue + result[Constants.Reponse.result].arrayValue)
            model.data = new
            model.currentPage = page
        }
        
        return true
    }
}

extension MovieDetailViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var row = 0
        if data.count > 0 {
            let model = data[section]
            row = (model.type == .comment) ? model.data.arrayValue.count : 1
        }
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        let model = data[indexPath.section]
        switch model.type {
        case .header:
            let temp = tableView.dequeueReusableCell(withIdentifier: HeaderViewCell.key) as! HeaderViewCell
            temp.delegate = self
            temp.loadData(model.data)
            
            cell = temp
        case .rate:
            let temp = tableView.dequeueReusableCell(withIdentifier: RatingViewCell.key) as! RatingViewCell
            
            cell = temp
        case .comment:
            let temp = tableView.dequeueReusableCell(withIdentifier: CommentViewCell.key) as! CommentViewCell
            let row = model.data.arrayValue[indexPath.row]
            temp.loadData(row, indexPath.row != 0)
            
            cell = temp
        default:
            let temp = tableView.dequeueReusableCell(withIdentifier: ItemTitleViewCell.key) as! ItemTitleViewCell
            temp.loadData(model)
            
            cell = temp
        }
        
        return cell!
        
    }
    
}

extension MovieDetailViewController: HeaderViewCellDelegate {
    
    func didTappAtBackButton() {
        navigationController?.popViewController(animated: true)
//        dismiss(animated: true, completion: nil)
    }
    
}
