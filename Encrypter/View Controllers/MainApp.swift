//
//  MainApp.swift
//  Encrypter
//
//  Created by QuickTutor on 3/14/18.
//  Copyright © 2018 CPS410. All rights reserved.
//

import Foundation
import UIKit


class MainAppView : BaseLayoutView {
    
    override func configureView() {
        super.configureView()
        
    }
    
    override func applyConstraints() {
        
    }
}


class MainApp : BaseViewController {
    
    override var contentView: MainAppView {
        return view as! MainAppView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func loadView() {
        view = CreatePinView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
