import Foundation
import UIKit


class GradientView: BaseLayoutView {
    
    override func configureView() {
        super.configureView()
        let secondColor = UIColor(red: 40/255, green: 42/255, blue: 42/255, alpha: 1.0).cgColor
        let firstColor = UIColor(red: 20/255, green: 20/255, blue: 30/255, alpha: 1.0).cgColor

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
