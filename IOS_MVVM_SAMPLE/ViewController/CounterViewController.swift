import UIKit
import RxSwift
import RxGesture

class CounterViewController: BaseViewController {
    
    let button1: UILabel = {
        let view = UILabel()
        view.text = "+"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.textColor = .black
        return view
    }()
    
    let button2: UILabel = {
        let view = UILabel()
        view.text = "-"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        view.textColor = .black
        return view
    }()
    
    let couter: UILabel = {
        let view = UILabel()
        view.text = "0"
        view.textAlignment = .center
        return view
    }()
    
    var viewModel: CouterViewModel!
    
    init(viewModel: CouterViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.state.number.asObservable()
            .subscribe(onNext: { (number) in self.couter.text = "\(number)" })
            .disposed(by: self.disposeBag)
    }
    
    override func setupViews() {
        self.view.addSubview(self.button1)
        self.view.addSubview(self.button2)
        self.view.addSubview(self.couter)
    }
    
    override func setupConstraints() {
        
        self.button1.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.left.equalTo(self.couter.snp.right).offset(30)
            make.centerY.equalTo(self.couter)
        }
        
        self.button2.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.height.equalTo(40)
            make.right.equalTo(self.couter.snp.left).offset(-30)
            make.centerY.equalTo(self.couter)
        }
        
        self.couter.snp.makeConstraints { (make) in
            make.width.equalTo(100)
            make.height.equalTo(50)
            make.center.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
    
    override func setupAction() {
        
        // + 버튼 탭
        self.button1.rx.tapGesture().when(GestureRecognizerState.recognized)
            .subscribe(onNext: { (_) in
                let number = Int(self.couter.text!) ?? 0
                self.viewModel.state.number.onNext(number + 1)
            })
            .disposed(by: self.disposeBag)
        
        // - 버튼 탭
        self.button2.rx.tapGesture().when(GestureRecognizerState.recognized)
            .subscribe(onNext: { (_) in
                let number = Int(self.couter.text!) ?? 0
                self.viewModel.state.number.onNext(number - 1)
            })
            .disposed(by: self.disposeBag)
        
    }
}

