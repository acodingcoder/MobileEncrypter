
import UIKit
import SnapKit

protocol BaseViewProtocol {
    func configureView()
    func applyConstraints()
}

public class BaseView: UIView, BaseViewProtocol {
    public required init() {
        super.init(frame: .zero)
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() { isUserInteractionEnabled = false }
    func applyConstraints() {
        print(self)
        fatalError("Override this method")
    }
}


class BaseLayoutView: UIView, BaseViewProtocol {
    public required init() {
        super.init(frame: UIScreen.main.bounds)
        configureView()
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }
    
    func configureView() { isExclusiveTouch = true }
    func applyConstraints() {}
}


protocol Interactable {
    func touchStart()
    func draggingOn()
    func didDragOff()
    func draggingOff()
    func didDragOn()
    func touchEndOnStart()
    func touchEndOffStart()
    func touchCancelled()
}


//Set default behavior for Interactable, they do nothing :)
extension Interactable {
    func touchStart() {}
    func draggingOn() {}
    func didDragOff() {}
    func draggingOff() {}
    func didDragOn() { touchStart() }
    func touchEndOnStart() { didDragOff() }
    func touchEndOffStart() {}
    func touchCancelled() { didDragOff() }
}


//An Interactable that adds an additional view that is the same size as the parent
protocol InteractableBackground: Interactable, HasBackgroundComponent where Self: UIView { }

//Default behaviors for an InteractableBackground, we're essentially "overriding" the default behaviors that was set in the Interactable extension
extension InteractableBackground {
    var backgroundView: UIView {
        get { return backgroundComponent.view }
        set { backgroundComponent.view = newValue }
    }
    
    func addBackgroundView() {
        addSubview(backgroundView)
        
        backgroundView.backgroundColor = .black
        backgroundView.alpha = 0.0
        backgroundView.isUserInteractionEnabled = false
        
        backgroundView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    func touchStart() { backgroundView.fadeIn(withDuration: 0.2, alpha: 0.3) }
    func didDragOff() { backgroundView.fadeOut(withDuration: 0.2) }
}


//Instantiate this when you don't need to make a subclass for an interactable (i.e. when the interactable needs no responsiveness)
public class InteractableObject: UIView, Interactable {}

//Subclass this for a view that is already an Interactable
public class InteractableView: BaseView { override func configureView() { } }

//Subclass this for a view that is already an Interactable and includes a background view
public class InteractableBackgroundView: BaseView, InteractableBackground {
    var backgroundComponent = ViewComponent()
    override func configureView() { addBackgroundView() }
}


//Components
struct ViewComponent {
    var view = UIView()
}

//Component protocols
protocol HasBackgroundComponent { var backgroundComponent: ViewComponent { get set } }
protocol HasKeyboardComponent { var keyboardComponent: ViewComponent { get set } }

//Adds an additional blank view that is the size of the keyboard
protocol Keyboardable: HasKeyboardComponent where Self: UIView { }

extension Keyboardable {
    var keyboardView: UIView {
        get { return keyboardComponent.view }
        set { keyboardComponent.view = newValue }
    }

    func addKeyboardView() {
        addSubview(keyboardView)

        keyboardView.snp.makeConstraints { (make) in
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.bottom.equalTo(0)
            make.height.equalTo(DeviceInfo.keyboardHeight)
        }
    }
}


public class BaseViewController: UIViewController {
    
    var touchStartView : (UIView & Interactable)? = nil
    
    public var contentView: UIView {
        return view
    }
    
    public required init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    public required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override public func loadView() {
        view = contentView
    }
    
    override public func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        if let firstTouch = touches.first {
            let hitView = self.contentView.hitTest(firstTouch.location(in: self.contentView), with: event)
            
            print(hitView)
            
            if (hitView is Interactable) {
                print("BEGAN: INTERACTABLE")
                touchStartView = hitView as? (UIView & Interactable)!
                touchStartView?.touchStart()
            } else {
                print("BEGAN: NOT INTERACTABLE")
            }
        }
    }
    
    override public func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesMoved(touches, with: event)
        
        if(touchStartView == nil) {
            print("DRAGGING ON A NONINTERACTABLE")
        } else {
            if let firstTouch = touches.first {
                let hitView = self.contentView.hitTest(firstTouch.location(in: self.contentView), with: event)
                let previousView = self.contentView.hitTest(firstTouch.previousLocation(in: self.contentView), with: event)
                
                if ((touchStartView == hitView) && (previousView == hitView)) {
                    print("DRAGGING ON START VIEW")
                    touchStartView?.draggingOn()
                } else if (previousView == touchStartView) {
                    print("DID DRAG OFF START VIEW")
                    touchStartView?.didDragOff()
                } else if ((previousView != touchStartView) && (hitView == touchStartView)) {
                    print("DID DRAG ON TO START VIEW")
                    touchStartView?.didDragOn()
                } else {
                    touchStartView?.draggingOff()
                    print("DRAGGING OFF START VIEW")
                }
            }
        }
    }
    
    override public func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        
        if(touchStartView == nil) {
            print("ENDED: NON INTERACTABLE")
        }
        else {
            if let firstTouch = touches.first {
                let hitView = self.contentView.hitTest(firstTouch.location(in: self.contentView), with: event)
                print(hitView)
                if (touchStartView == hitView) {
                    print("ENDED: ON START")
                    touchStartView?.touchEndOnStart()
                } else {
                    touchStartView?.touchEndOffStart()
                    touchStartView = nil
                    print("ENDED: OFF START")
                }
            }
        }
        
        handleNavigation()
    }
    
    override public func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesCancelled(touches, with: event)
        
        if(touchStartView == nil) {
            print("CANCELLED: NON INTERACTABLE")
        } else {
            print("CANCELLED: INTERACTABLE")
            touchStartView?.touchCancelled()
        }
        
        touchStartView = nil
    }
    
    public func handleNavigation() {}
}
