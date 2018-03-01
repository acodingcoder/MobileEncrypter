import Foundation
import UIKit


class GradientView: BaseLayoutView {
    
    override func configureView() {
        super.configureView()
        
        let secondColor = UIColor(red: 93/255, green: 65/255, blue: 87/255, alpha: 1.0).cgColor
        let firstColor = UIColor(red: 168/255, green: 202/255, blue: 186/255, alpha: 1.0).cgColor
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = frame
        gradientLayer.colors = [ firstColor, secondColor ]

        let x: Double! = 160 / 360.0
        let a = pow(sinf(Float(2.0 * .pi * ((x + 0.75) / 2.0))),2.0);
        let b = pow(sinf(Float(2 * .pi * ((x+0.0)/2))),2);
        let c = pow(sinf(Float(2 * .pi * ((x+0.25)/2))),2);
        let d = pow(sinf(Float(2 * .pi * ((x+0.5)/2))),2);
        
        gradientLayer.endPoint = CGPoint(x: CGFloat(c),y: CGFloat(d))
        gradientLayer.startPoint = CGPoint(x: CGFloat(a),y:CGFloat(b))
        
        gradientLayer.locations = [0, 0.7, 0.9, 1]
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    internal override func applyConstraints() {}
}
