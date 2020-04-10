import UIKit
import RxSwift

class MenuListViewController: BaseViewController {
    
    let menuList: UITableView = {
        let view = UITableView()
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
        
        self.menuList.delegate = self
        self.menuList.dataSource = self
    }
    
    override func setupViews() {
        self.view.addSubview(self.menuList)
    }
    
    override func setupConstraints() {
        self.menuList.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view.safeAreaLayoutGuide)
        }
    }
}

extension MenuListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return STRING_ARRAY.MENU.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        cell.textLabel?.text = STRING_ARRAY.MENU[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: router.navigateToCounter(); break
        case 1: router.navigateToSearchGit(); break
        default: break
        }
    }
}

