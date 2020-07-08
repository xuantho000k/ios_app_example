//
//  InputView.swift
//  example
//
//  Created by ThoNX on 3/24/20.
//  Copyright © 2020 ThoNX. All rights reserved.
//

import UIKit

class InputView: UICustomView {

    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var txtInput: UITextField!
    
    override func setupView() {
        super.setupView()
        
        
    }

}

extension InputView: UITextFieldDelegate {
    
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
}
