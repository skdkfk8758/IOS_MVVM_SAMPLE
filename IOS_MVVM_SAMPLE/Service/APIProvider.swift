import Foundation
import SwiftyJSON

class APIProvider {
    static let baseUrl: String = "https://api.github.com"
    
    // API 주소 반환
    class func getUrl(partUrl: String) -> String {
        return "\(APIProvider.baseUrl)\(partUrl)"
    }
    
    // 리스폰스 반환
    class func getResponse(json: Any) -> ResponseModel {
        let result = JSON(json)
        
        let data = result["items"].arrayObject ?? []
        let errors = result["errors"].dictionaryObject ?? [:]
        
        let status: RESPONSE_STATUS = (errors.isEmpty) ? .SUCC : .FAIL
        let message: String = ""
        
        var newData = ["data": data]
        
        return ResponseModel(status: status, message: message, data: newData)
    }
}

enum RESPONSE_STATUS {
    case SUCC
    case FAIL
    case NONE
}

struct ResponseModel {
    var status: RESPONSE_STATUS = .NONE
    var message: String = ""
    var data: [String: Any] = [:]
    
    init() {}
    
    init(status: RESPONSE_STATUS, message: String, data: JSON) {
        self.status = status
        self.message = message
        self.data = data.dictionaryObject ?? [:]
    }
    
    init(status: RESPONSE_STATUS, message: String, data: [String: Any]) {
        self.status = status
        self.message = message
        self.data = data
    }
}

struct RequestModel {
    
    var QUERY: String = ""
    
    init() {}
    
    func getParam() -> [String: Any] {
        return [
            "q": QUERY
        ]
    }
}
