import UIKit
import RxSwift
import RxGesture

class LoginViewController: BaseViewController {
    
    let loginButton: UILabel = {
        let view = UILabel()
        view.text = "로그인"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        return view
    }()
    
    override init() {
        super.init()
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "로그인"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    override func setupViews() {
        
        self.view.addSubview(self.loginButton)
        
    }
    
    override func setupConstraints() {
        
        self.loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupAction() {
        
        // 로그인 버튼 탭
        self.loginButton.rx.tapGesture().when(GestureRecognizerState.recognized)
            .subscribe(onNext: { (_) in
                router.navigateToMenu()
            })
            .disposed(by: self.disposeBag)
    }
}

