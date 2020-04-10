import Foundation
import UIKit

final class Router {
    
    weak var viewController: UIViewController?
    var navigationController: UINavigationController?
    
    init() {}
    
    init(viewController: UIViewController) {
        self.viewController = viewController
        self.navigationController = viewController.navigationController
    }
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // 스플래쉬화면으로 이동
    public func navigateToSplash() {
        let viewController = SplashViewController()
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // 로그인화면으로 이동
    public func navigateToLogin() {
        let viewController = LoginViewController()
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // 메뉴화면으로 이동
    public func navigateToMenu() {
        let viewController = MenuListViewController()
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // 카운터화면으로 이동
    public func navigateToCounter() {
        let viewModel = CouterViewModel()
        let viewController = CounterViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
    
    // 깃검색화면으로 이동
    public func navigateToSearchGit() {
        let viewModel = GitSearchViewModel()
        let viewController = GitSearchViewController(viewModel: viewModel)
        
        self.navigationController?.pushViewController(viewController, animated: false)
    }
}
