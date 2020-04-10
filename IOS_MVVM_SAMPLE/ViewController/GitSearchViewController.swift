import UIKit
import RxSwift

class GitSearchViewController: BaseViewController {
    
    let searchBar: UISearchBar = {
        let view = UISearchBar()
        return view
    }()
    
    let repoList: UITableView = {
        let view = UITableView()
        return view
    }()
    
    var items: [GitRepoModel] = []
    
    var viewModel: GitSearchViewModel!
    
    init(viewModel: GitSearchViewModel) {
        super.init()
        self.viewModel = viewModel
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.repoList.delegate = self
        self.repoList.dataSource = self
        
        self.setupItems()
    }
    
    override func setupViews() {
        
        self.view.addSubview(self.searchBar)
        self.view.addSubview(self.repoList)
    }
    
    override func setupConstraints() {
        
        self.searchBar.snp.makeConstraints { (make) in
            make.top.equalTo(self.view.safeAreaLayoutGuide)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
        
        self.repoList.snp.makeConstraints { (make) in
            make.top.equalTo(self.searchBar.snp.bottom).offset(10)
            make.left.right.equalTo(self.view.safeAreaLayoutGuide).inset(10)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(10)
        }
    }
    
    override func setupAction() {
        
        // 검색어 입력하면 자동 검색
        self.searchBar.rx.text.asObservable()
            .distinctUntilChanged()
            .filter { $0 != "" }
            .subscribe(onNext: { (query) in self.viewModel.searchGitRepo(query: query!) })
            .disposed(by: self.disposeBag)
    }
    
    private func setupItems() {
        
        // 뷰모델에 items를 구독하다가 items에 변동이 생기면 테이블에 데이터 갱신하고 새로고침
        self.viewModel.state.items.asObservable()
            .subscribe(onNext: { (items) in
                self.items = items
                
                self.repoList.reloadData()
            })
            .disposed(by: self.disposeBag)
    }
}

extension GitSearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.isEmpty ? 1 : self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        if(self.items.isEmpty == false) {
            cell.textLabel?.text = self.items[indexPath.row].FILE_NAME
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let url: URL = URL(string: self.items[indexPath.row].HTML_URL) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {    // openURL(_:) is deprecated in iOS 10+.
                UIApplication.shared.openURL(url)
            }
        }
    }
}

