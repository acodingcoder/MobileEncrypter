import Foundation
import UIKit


class CreatePinView : PinView {
    override func configureView() {
        super.configureView()
        
        titleLabel.text = "Create a 6 digit pin"
    }
}


class CreatePin : BaseViewController {
    
    override var contentView: CreatePinView {
        return view as! CreatePinView
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
        
        if verificationCode.count == 6 {
            contentView.arrow.isUserInteractionEnabled = true
        }
    }
    
    private func textFieldController(current: UITextField, textFieldToChange: UITextField) {
        current.isEnabled = false
        textFieldToChange.isEnabled = true
    }
    
    override func loadView() {
        view = CreatePinView()
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
        if(touchStartView is ArrowButton) {
            Defaults.pin = verificationCode
            Defaults.userManager.setDefaults()
            
            navController.pushViewController(EnterPin(), animated: true)
        }
    }
}

extension CreatePin : UITextFieldDelegate {
    
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
                    contentView.arrow.isUserInteractionEnabled = false
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

