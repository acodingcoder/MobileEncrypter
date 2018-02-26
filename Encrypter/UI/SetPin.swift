import Foundation
import UIKit


class SetPinView : GradientView {
    
    
    
    override func configureView() {
        super.configureView()
        
    }
    
    override func applyConstraints() {
        
    }
}


class SetPin : BaseViewController {
    
    override var contentView: SetPinView {
        return view as! SetPinView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func loadView() {
        view = SetPinView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handleNavigation() {
        
    }
}
