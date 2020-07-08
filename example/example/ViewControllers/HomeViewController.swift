//
//  HomeViewController.swift
//  example
//
//  Created by Nguyen Xuan Tho on 7/1/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit
import SwiftyJSON

class HomeViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var refresh: UIRefreshControl = UIRefreshControl()
    
    var data: [RowModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        
        return .default
    }
    
    private func setup() {
        navigationItem.titleView = UIImageView(image: UIImage(named: Constants.Image.logo))
        
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.register(ItemTitleViewCell.nib, forCellReuseIdentifier: ItemTitleViewCell.key)
        
        addPullToRefresh()
        
        getData(false)
    }
    
    private func addPullToRefresh() {
        self.tableView.addSubview(refresh)
        refresh.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    private func getData(_ isRefresh: Bool) {
        let group = DispatchGroup()
        group.enter()
        getNowPlaying(1, isRefresh) { (isSuccess) in
            group.leave()
        }
        group.enter()
        getPopularMovies(1, isRefresh) { (isSuccess) in
            group.leave()
        }
        group.enter()
        getTopRatedMovies(1, isRefresh) { (isSuccess) in
            group.leave()
        }
        group.enter()
        getUpcoming(1, isRefresh) { (isSuccess) in
            group.leave()
        }
        group.notify(queue: .main) {
            if isRefresh {
                self.refresh.endRefreshing()
            } else {
                let c = RowModel(data: [Constants.Localization.Home.discover.localized,
                                        Constants.Localization.Home.tvshow.localized,
                                        Constants.Localization.Home.movie.localized],
                                 totalPages: 0,
                                 type: .category)
                self.data.append(c)
                
                self.data = self.data.sorted(by: { (r1, r2) -> Bool in
                    return r1.type.rawValue < r2.type.rawValue
                })
            }
            self.tableView.reloadData()
        }
    }
    
    private func handleResult(_ result: JSON?, _ page: Int, _ type: RowType, _ isRefresh: Bool) -> Bool {
        guard let result = result else { return false }
        if page == 1 {
            if isRefresh && self.data.count > 0 {
                let model = self.data[type.rawValue]
                model.data = result[Constants.Reponse.result]
                model.currentPage = 1
                model.totalPages = 0
                model.isLoading = false
            } else {
                let n = RowModel(data: result[Constants.Reponse.result],
                                 totalPages: result[Constants.Reponse.totalPage].intValue,
                                 type: type)
                self.data.append(n)
            }
        } else {
            let model = self.data[type.rawValue]
            let new = JSON(model.data.arrayValue + result[Constants.Reponse.result].arrayValue)
            model.data = new
            model.currentPage = page
        }
        return true
    }
    
    private func getNowPlaying(_ page: Int, _ isRefresh: Bool, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getNowPlaying(page) { (result, error) in
             completion(self.handleResult(result, page, .nowPlaying, isRefresh))
        }
    }
    
    private func getPopularMovies(_ page: Int, _ isRefresh: Bool, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getPopularMovies(page) { (result, error) in
            completion(self.handleResult(result, page, .popular, isRefresh))
        }
    }
    
    private func getTopRatedMovies(_ page: Int, _ isRefresh: Bool, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getTopRatedMovies(page) { (result, error) in
            completion(self.handleResult(result, page, .topRated, isRefresh))
        }
    }
    
    private func getUpcoming(_ page: Int, _ isRefresh: Bool, _ completion: @escaping (_ isSuccess: Bool) -> Void) {
        APIManager.shared.getUpcomingMovies(page) { (result, error) in
            completion(self.handleResult(result, page, .upcoming, isRefresh))
        }
    }
    
    //MARK: Action Method
    
    @objc func refreshData() {
        self.refresh.beginRefreshing()
        getData(true)
    }

}

extension HomeViewController: UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: ItemTitleViewCell.key) as! ItemTitleViewCell
        cell.delegate = self
        cell.loadData(model)
        
        return cell
    }
    
}

extension HomeViewController: ItemTitleViewCellDelegate {
    
    func didTapAtCell(withItemId id: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: Constants.Storyboard.Id.movieDetail) as! MovieDetailViewController
        vc.id = id
        self.navigationController?.pushViewController(vc, animated: true)
//        vc?.modalPresentationStyle = .overCurrentContext
//        self.navigationController?.present(vc!, animated: true, completion: nil)
    }
    
    func loadMoreDataForCell(_ cell: ItemTitleViewCell) {
        let indexPath = tableView.indexPath(for: cell)
        if let ip = indexPath {
            let model = data[ip.row]
            if !model.isLoading && model.currentPage + 1 <= model.totalPages {
                switch model.type {
                case .nowPlaying:
                    getNowPlaying(model.currentPage + 1, false) {  (isSuccess) in
                        self.reloadCell(cell, at: ip, isSuccess)
                    }
                case .popular:
                    getPopularMovies(model.currentPage + 1, false) {  (isSuccess) in
                        self.reloadCell(cell, at: ip, isSuccess)
                    }
                case .topRated:
                    getTopRatedMovies(model.currentPage + 1, false) {  (isSuccess) in
                        self.reloadCell(cell, at: ip, isSuccess)
                    }
                case .upcoming:
                    getUpcoming(model.currentPage + 1, false) {  (isSuccess) in
                        self.reloadCell(cell, at: ip, isSuccess)
                    }
                default:
                    break
                }
            }
        }
    }
    
    func reloadCell(_ cell: ItemTitleViewCell, at indexPath: IndexPath, _ isSuccess: Bool) {
        if isSuccess {
            cell.reloadView()
            let model = data[indexPath.row]
            model.isLoading = false
        }
    }
    
}
