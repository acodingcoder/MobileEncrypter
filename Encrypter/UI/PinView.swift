

import Foundation
import UIKit

class PinView : GradientView, Keyboardable {
    
    var keyboardComponent = ViewComponent()
    
    var titleLabel  = UILabel()
    
    var digit1      = DigitTextField()
    var digit2      = DigitTextField()
    var digit3      = DigitTextField()
    var digit4      = DigitTextField()
    var digit5      = DigitTextField()
    var digit6      = DigitTextField()
    
    var digitView   = UIView()
    var leftDigits  = UIView()
    var rightDigits = UIView()
    
    var arrow = ArrowButton()
    
    override func configureView() {
        leftDigits.addSubview(digit1)
        leftDigits.addSubview(digit2)
        leftDigits.addSubview(digit3)
        rightDigits.addSubview(digit4)
        rightDigits.addSubview(digit5)
        rightDigits.addSubview(digit6)
        addSubview(digitView)
        digitView.addSubview(leftDigits)
        digitView.addSubview(rightDigits)
        addSubview(titleLabel)
        addSubview(arrow)
        super.configureView()
        
        addKeyboardView()
        
        titleLabel.font = UIFont(name: "Futura", size: 25)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        arrow.isUserInteractionEnabled = false
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top).inset(100)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
        }
        digitView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.75)
            make.centerX.equalToSuperview()
        }
        leftDigits.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.left.equalToSuperview().offset(-5)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        rightDigits.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.height.equalToSuperview()
            make.right.equalToSuperview().offset(5)
            make.width.equalToSuperview().multipliedBy(0.5)
        }
        
        digit1.applyConstraint(rightMultiplier: 0.33333)
        digit2.applyConstraint(rightMultiplier: 0.66666)
        digit3.applyConstraint(rightMultiplier: 1.0)
        digit4.applyConstraint(rightMultiplier: 0.33333)
        digit5.applyConstraint(rightMultiplier: 0.66666)
        digit6.applyConstraint(rightMultiplier: 1.0)
        
        arrow.snp.makeConstraints { (make) in
            make.bottom.equalTo(keyboardView.snp.top)
            make.height.equalTo(60)
            make.width.equalTo(digitView)
            make.centerX.equalToSuperview()
        }
    }
}
