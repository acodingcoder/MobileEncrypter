//
//  ArrowButton.swift
//  Encrypter
//
//  Created by QuickTutor on 3/14/18.
//  Copyright © 2018 CPS410. All rights reserved.
//

import Foundation
import UIKit

class ArrowButton : InteractableView, Interactable {
    
    var image = UIImageView()
    
    override func configureView() {
        addSubview(image)
        super.configureView()
        
        image.image = #imageLiteral(resourceName: "arrow")
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        image.snp.makeConstraints { (make) in
            make.right.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func touchStart() {
        image.alpha = 0.7
    }
    
    func didDragOff() {
        image.alpha = 1.0
    }
}
