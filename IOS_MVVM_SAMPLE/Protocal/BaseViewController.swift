import UIKit

import RxSwift

class BaseViewController: UIViewController {
    
    // MARK: Initializing
    
    init() { super.init(nibName: nil, bundle: nil) }
    
    required convenience init?(coder aDecoder: NSCoder) { self.init() }
    
    
    // MARK: Rx
    
    var disposeBag = DisposeBag()
    
    // MARK: Layout Constraints
    
    private(set) var didSetupConstraints = false
    
    override func viewDidLoad() {
        self.view.setNeedsUpdateConstraints()
        self.setupAction()
    }
    
    override func updateViewConstraints() {
        if !self.didSetupConstraints {
            self.setupViews()
            self.setupConstraints()
            self.didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    func setupViews() {
        // Override point
    }
    
    func setupConstraints() {
        // Override point
    }
    
    func setupAction() {
        // Override point
    }
}
