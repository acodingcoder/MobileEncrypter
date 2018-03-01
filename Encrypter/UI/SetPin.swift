import Foundation
import UIKit


class SetPinView : GradientView {
    
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
        super.configureView()
        
        titleLabel.text = "Create a 6 digit pin"
        titleLabel.font = UIFont(name: "Helvetica", size: 20)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .center
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        titleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(safeAreaLayoutGuide.snp.top)
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.centerX.equalToSuperview()
        }
        digitView.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom)
            make.height.equalToSuperview().multipliedBy(0.2)
            make.width.equalToSuperview().multipliedBy(0.8)
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
    }
}


class SetPin : BaseViewController {
    
    override var contentView: SetPinView {
        return view as! SetPinView
    }
    
    private var verificationCode = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let textFields = [contentView.digit1.textField, contentView.digit2.textField, contentView.digit3.textField, contentView.digit4.textField, contentView.digit5.textField, contentView.digit6.textField]
        
        for textField in textFields {
            textField.isEnabled = false
            textField.tintColor = .clear
            textField.delegate = self
            textField.addTarget(self, action: #selector(buildVerificationCode(_:)), for: .editingChanged)
        }
        contentView.digit1.textField.isEnabled = true
    }
    @objc
    private func buildVerificationCode(_ textField: UITextField) {
        verificationCode.append(textField.text!)
        //set defaults
    }
    private func textFieldController(current: UITextField, textFieldToChange: UITextField) {
        current.isEnabled = false
        textFieldToChange.isEnabled = true
    }
    override func loadView() {
        view = SetPinView()
    }
    override func viewDidAppear(_ animated: Bool) {
        contentView.digit1.textField.becomeFirstResponder()
    }
    override func viewWillDisappear(_ animated: Bool) {
        contentView.resignFirstResponder()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handleNavigation() {
        
    }
}

extension SetPin : UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        let char = string.cString(using: String.Encoding.utf8)!
        let isBackSpace = strcmp(char, "\\b")
        
        let inverseSet = NSCharacterSet(charactersIn:"0123456789").inverted
        let components = string.components(separatedBy: inverseSet)
        let filtered = components.joined(separator: "")
        
        if textField.text!.count == 1 {
            
            switch(textField) {
            case contentView.digit1.textField:
                if (isBackSpace == Constants.BCK_SPACE){
                    contentView.digit1.textField.text = ""
                    self.verificationCode.removeLast()
                    return false
                }else{
                    textFieldController(current: contentView.digit1.textField, textFieldToChange: contentView.digit2.textField)
                    contentView.digit2.textField.becomeFirstResponder()
                    return true
                }
            case contentView.digit2.textField:
                if(isBackSpace == Constants.BCK_SPACE){
                    contentView.digit2.textField.text = ""
                    textFieldController(current: contentView.digit2.textField, textFieldToChange: contentView.digit1.textField)
                    contentView.digit1.textField.becomeFirstResponder()
                    self.verificationCode.removeLast()
                    return false
                }else{
                    textFieldController(current: contentView.digit2.textField, textFieldToChange: contentView.digit3.textField)
                    contentView.digit3.textField.becomeFirstResponder()
                    return true
                }
            case contentView.digit3.textField:
                if(isBackSpace == Constants.BCK_SPACE) {
                    contentView.digit3.textField.text = ""
                    textFieldController(current: contentView.digit3.textField, textFieldToChange: contentView.digit2.textField)
                    contentView.digit2.textField.becomeFirstResponder()
                    self.verificationCode.removeLast()
                    return false
                }else{
                    textFieldController(current: contentView.digit3.textField, textFieldToChange: contentView.digit4.textField)
                    contentView.digit4.textField.becomeFirstResponder()
                    return true
                }
            case contentView.digit4.textField:
                if (isBackSpace == Constants.BCK_SPACE){
                    contentView.digit4.textField.text = ""
                    textFieldController(current: contentView.digit4.textField, textFieldToChange: contentView.digit3.textField)
                    contentView.digit3.textField.becomeFirstResponder()
                    self.verificationCode.removeLast()
                    return false
                }else{
                    textFieldController(current: contentView.digit4.textField, textFieldToChange: contentView.digit5.textField)
                    contentView.digit5.textField.becomeFirstResponder()
                    return true
                }
            case contentView.digit5.textField:
                if (isBackSpace == Constants.BCK_SPACE){
                    contentView.digit5.textField.text = ""
                    textFieldController(current: contentView.digit5.textField, textFieldToChange: contentView.digit4.textField)
                    contentView.digit4.textField.becomeFirstResponder()
                    self.verificationCode.removeLast()
                    return false
                }else{
                    textFieldController(current: contentView.digit5.textField, textFieldToChange: contentView.digit6.textField)
                    contentView.digit6.textField.becomeFirstResponder()
                    return true
                }
            case contentView.digit6.textField:
                if (isBackSpace == Constants.BCK_SPACE){
                    contentView.digit6.textField.text = ""
                    textFieldController(current: contentView.digit6.textField, textFieldToChange: contentView.digit5.textField)
                    contentView.digit5.textField.becomeFirstResponder()
                    self.verificationCode.removeLast()
                    return false
                } else {
                    return false
                }
            default:
                contentView.digit6.textField.becomeFirstResponder()
                return false
            }
        }
        return string == filtered
    }
}

