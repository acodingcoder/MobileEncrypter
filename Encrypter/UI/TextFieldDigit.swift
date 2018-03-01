//
//  TextFieldDigit.swift
//  Encrypter
//
//  Created by QuickTutor on 2/28/18.
//  Copyright © 2018 CPS410. All rights reserved.
//

import Foundation
import UIKit
import SnapKit

class NoPasteTextField: UITextField {
    
    public required init() {
        super.init(frame: .zero)
        configureTextField()
    }
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTextField()
    }
    
    internal func configureTextField() {
        autocorrectionType = .no
        keyboardAppearance = .dark
    }
    
    override public func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(paste(_:)) {
            return false
        }
        return super.canPerformAction(action, withSender: sender)
    }
}

class DigitTextField: BaseView {
    
    var textField = NoPasteTextField()
    var line = UIView()
    
    internal override func configureView() {
        addSubview(textField)
        addSubview(line)
        
        textField.font = UIFont(name: "Helvetica", size: 25)
        textField.keyboardAppearance = .dark
        textField.textColor = .white
        textField.tintColor = .clear
        textField.textAlignment = .center
        textField.keyboardType = .numberPad
        
        line.backgroundColor = .white
    }
    
    internal func applyConstraint(rightMultiplier: ConstraintMultiplierTarget) {
        self.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.33333)
            make.right.equalToSuperview().multipliedBy(rightMultiplier)
        }
        
        textField.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.85)
            make.centerX.equalToSuperview()
        }
        
        line.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.85)
            make.height.equalTo(1)
            make.centerY.equalToSuperview().multipliedBy(1.5)
            make.centerX.equalToSuperview()
        }
    }
}
