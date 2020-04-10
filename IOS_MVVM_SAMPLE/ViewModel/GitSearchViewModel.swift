import UIKit
import RxSwift
import ObjectMapper

class GitSearchViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    struct State {
        var items: BehaviorSubject = BehaviorSubject(value: [GitRepoModel()])
    }
    
    var state = State()
    
    init() {}
    
    public func searchGitRepo(query: String) {
        
        var req: RequestModel = RequestModel()
        req.QUERY = query
        
        gitService.searchRepo(req: req)
            .subscribe(onNext: { (res) in
                
                if let items: [GitRepoModel] = try! Mapper<GitRepoModel>().mapArray(JSONArray: res.data["data"] as! [[String: Any]]) {
                    self.state.items.onNext(items)
                }
            })
            .disposed(by: self.disposeBag)
    }
}
