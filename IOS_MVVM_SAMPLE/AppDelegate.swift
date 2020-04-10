import UIKit
import SnapKit

var router: Router!

var common: Common = Common.shared

var viewWidth: CGFloat!
var viewHeight: CGFloat!

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupApplication()
        
        return true
    }
}

extension AppDelegate {
    private func setupApplication() {
        let window = UIWindow(frame: UIScreen.main.bounds)
        window.backgroundColor = .white
        window.makeKeyAndVisible()
        
        self.window = window
        
        // 화면사이즈 저장
        viewWidth = self.window?.frame.size.width
        viewHeight = self.window?.frame.size.height
        
        // 스플래시 화면
        let splash = SplashViewController()
        
        let navigationController = UINavigationController(rootViewController: splash)
        self.window?.rootViewController = navigationController

        self.window?.makeKeyAndVisible()
        
        router = Router(navigationController: navigationController)
    }
}

