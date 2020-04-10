import UIKit
import RxSwift

class SplashViewController: BaseViewController {
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1000)) {
            router.navigateToLogin()
        }
    }
    
    override func setupViews() {
        
    }
    
    override func setupConstraints() {
        
    }
}

