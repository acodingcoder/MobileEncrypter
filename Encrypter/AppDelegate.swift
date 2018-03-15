
import UIKit

var navController = UINavigationController()

public struct Constants {
    static let BCK_SPACE = -92
}

public struct DeviceInfo {
    static var keyboardHeight: Double!
}

func setDeviceInfo() -> Double {
    switch UIScreen.main.bounds.height {
    case 812:
        return 291.0
    case 736:
        return 226.0
    case 667:
        return 216.0
    case 568:
        return 216.0
    default:
        return 216.0
    }
}

class PlaygroundsView : BaseLayoutView {
    
    var origImage = UIImageView()
    var recreatedImage = UIImageView()
    
    override func configureView() {
        addSubview(origImage)
        addSubview(recreatedImage)
        super.configureView()
        
        origImage.image = #imageLiteral(resourceName: "lock")
        
        applyConstraints()
    }
    
    override func applyConstraints() {
        origImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.5)
        }
        
        recreatedImage.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(1.5)
        }
    }
}

class Playgrounds : BaseViewController {
    
    override var contentView: PlaygroundsView {
        return view as! PlaygroundsView
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func loadView() {
        view = PlaygroundsView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func handleNavigation() {
    }

}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //Save keyboard height to DeviceInfo
        DeviceInfo.keyboardHeight = setDeviceInfo()
        
        //Sets statusbar to white
        UIApplication.shared.statusBarStyle = .lightContent
        
        //Check if pin is set
          var controller : UIViewController? = nil
//        let user = UserDefaultData.localDataManager
//
//        if (user.pin.isEmpty) {
//            controller = CreatePin()
//        } else {
//            controller = EnterPin()
//        }
//
        controller = Playgrounds()
        
        navController = UINavigationController(rootViewController: controller!)
        navController.navigationBar.isHidden = true
        self.window?.rootViewController = navController
        self.window?.makeKeyAndVisible()
        
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

