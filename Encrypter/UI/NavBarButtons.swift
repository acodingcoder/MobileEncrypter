
import UIKit


class NavbarButton : InteractableView {
    internal func allignLeft() {
        self.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.175)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.left.equalToSuperview()
        }
    }
    
    internal func allignRight() {
        self.snp.makeConstraints { (make) in
            make.width.equalToSuperview().multipliedBy(0.175)
            make.top.equalToSuperview().inset(10)
            make.bottom.equalToSuperview().inset(10)
            make.right.equalToSuperview()
        }
    }
}


class NavbarButtonImage : NavbarButton, Interactable {
    
    var image = UIImageView()
    
    override func configureView() {
        addSubview(image)
        
        image.isUserInteractionEnabled = false
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        image.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().inset(5)
            make.centerX.equalToSuperview()
        }
    }
    
    func touchStart() {
        image.alpha = 0.5
    }
    func didDragOff() {
        image.alpha = 1.0
    }
    func touchEndOnStart() {
        didDragOff()
    }
}


class NavbarButtonText : NavbarButton, Interactable {
    
    var label = UILabel()
    
    override func configureView() {
        addSubview(label)
        super.configureView()
        
        label.textAlignment = .center
        label.textColor = .white
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        label.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
    
    func touchStart() {
        label.alpha = 0.7
    }
    func didDragOff() {
        label.alpha = 1.0
    }
}

class NavbarButtonLock: NavbarButtonImage {
    override func configureView() {
        super.configureView()
        
        image.image = #imageLiteral(resourceName: "lock")
    }
}

class NavbarButtonAdd: NavbarButtonText {
    
    override func configureView() {
        super.configureView()
        
        label.text = "+"
        label.font = UIFont(name: "Futura-Bold", size: 45)
    }
}
