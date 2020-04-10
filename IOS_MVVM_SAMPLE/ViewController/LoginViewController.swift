import UIKit
import RxSwift
import RxGesture

class LoginViewController: BaseViewController {
    
    let loginButton: UILabel = {
        let view = UILabel()
        view.text = "로그인"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.backgroundColor = .black
        view.layer.cornerRadius = 25
        view.clipsToBounds = true
        view.textColor = .white
        return view
    }()
    
    let idTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "아이디"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.placeholder = "비밀번호"
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
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
        
        self.view.addSubview(self.idTextField)
        self.view.addSubview(self.passwordTextField)
        
        self.view.addSubview(self.loginButton)
        
    }
    
    override func setupConstraints() {
        
        self.idTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
            make.bottom.equalTo(self.passwordTextField.snp.top).offset(-20)
        }
        
        self.passwordTextField.snp.makeConstraints { (make) in
            make.height.equalTo(50)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(50)
            make.center.equalTo(self.view.safeAreaLayoutGuide)
        }
        
        self.loginButton.snp.makeConstraints { (make) in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.top.equalTo(self.passwordTextField.snp.bottom).offset(20)
            make.centerX.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupAction() {
        
        // 로그인 버튼 탭
        self.loginButton.rx.tapGesture().when(GestureRecognizerState.recognized)
            .do(onNext: { (_) in
                let validationId = common.validateId(id: self.idTextField.text!)
                let validationPassword = common.validatePassword(password: self.passwordTextField.text!)
                
                if(validationId.0 == false) { common.showNoticeAlert(message: validationId.1) }
                if(validationId.0 == true && validationPassword.0 == false) { common.showNoticeAlert(message: validationPassword.1) }
            })
            .filter { _ in common.validateId(id: self.idTextField.text!).0 && common.validatePassword(password: self.passwordTextField.text!).0 }
            .subscribe(onNext: { (_) in router.navigateToMenu() })
            .disposed(by: self.disposeBag)
    }
}
