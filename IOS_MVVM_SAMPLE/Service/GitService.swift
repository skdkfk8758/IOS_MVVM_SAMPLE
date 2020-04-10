import RxSwift
import RxAlamofire
import SwiftyJSON

class GitService {
    
    static let shared = GitService()
    private init() {}
    
    func searchRepo(req: RequestModel) -> Observable<(ResponseModel)> {
        return RxAlamofire
            .requestJSON(.get, APIProvider.getUrl(partUrl: "/search/repositories"), parameters: req.getParam())
//            .do(onNext: { (res, json) in
//                Log.e(res.url)
//                Log.e(json)
//            })
            .map { res, json in APIProvider.getResponse(json: json) }
    }
}
