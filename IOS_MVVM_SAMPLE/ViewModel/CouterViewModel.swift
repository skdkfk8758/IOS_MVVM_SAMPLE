import UIKit
import RxSwift
import ObjectMapper

class CouterViewModel {
    var disposeBag: DisposeBag = DisposeBag()
    
    struct State {
        var number: BehaviorSubject = BehaviorSubject(value: 0)
    }
    
    var state = State()
    
    init() {}
}
