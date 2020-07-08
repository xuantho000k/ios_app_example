//
//  BaseViewController.swift
//  example
//
//  Created by ThoNX on 3/31/19.
//  Copyright © 2019 ThoNX. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    var btnLeft: UIButton?
    var btnRight: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()

        btnLeft = UIButton(frame: CGRect(x: 0,y: 0,width: 40,height: 40))
        btnLeft!.setImage(UIImage(named: Constants.Image.homeUser), for: .normal)
        btnLeft!.contentHorizontalAlignment = .left
        btnLeft!.addTarget(self, action: #selector(tappedAtLeftButton), for: .touchUpInside)
        let left = UIBarButtonItem(customView: btnLeft!)
        
        navigationItem.leftBarButtonItem = left
        
        btnRight = UIButton(frame: CGRect(x: 0,y: 0,width: 40,height: 40))
        btnRight!.setImage(UIImage(named: Constants.Image.search), for: .normal)
        btnRight!.contentHorizontalAlignment = .right
        btnRight!.addTarget(self, action: #selector(tappedAtLeftButton), for: .touchUpInside)
        let right = UIBarButtonItem(customView: btnRight!)
        
        navigationItem.rightBarButtonItem = right
        
    }
    
    @objc func tappedAtLeftButton() {
        
    }
    
    @objc func tappedAtRightButton() {
        
    }

}
