import Foundation
import ObjectMapper

class GitRepoModel: Mappable {
    
    var ID: String = ""
    var FILE_NAME: String = ""
    var HTML_URL: String = ""
    
    init() {}
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        self.ID <- map["id"]
        self.FILE_NAME <- map["full_name"]
        self.HTML_URL <- map["html_url"]
    }
}

