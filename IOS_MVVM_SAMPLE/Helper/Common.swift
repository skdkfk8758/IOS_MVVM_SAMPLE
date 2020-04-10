import UIKit

class Common {
    
    static let shared = Common()
    private init() {}
    
    // 오늘날짜 출력
    public func getDate() -> String {
        let now = Date()
        
        let date = DateFormatter()
        date.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        return date.string(from: now)
    }
    
    // 확인버튼 알럿
    public func showNoticeAlert(title: String = "알림", message : String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default,handler : nil )
        
        alert.addAction(okAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    // 확인버튼 알럿 -> 핸들러 포함
    public func showNoticeAlertWithHandler(title: String = "알림", message : String, handler: @escaping (UIAlertAction) -> Void) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default,handler : handler )
        
        alert.addAction(okAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    // 2버튼 알럿
    public func showTowButtonAlert(title: String, message: String, buttonTitle: String, handler: @escaping ((UIAlertAction) -> Void), cancelHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default, handler : handler )
        let candelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler : cancelHandler )
        
        alert.addAction(candelAction)
        alert.addAction(okAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }

    // 텍스트필드 포함 2버튼 알럿
    func showTowButtonAlertWithTextField(title: String, message: String, buttonTitle: String, placeHolder: String = "임시비밀번호를 입력해 주세요", isSecureTextEntry: Bool = true, handler: @escaping ((String) -> Void), cancelHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler : cancelHandler )
        
        alert.addTextField { (this) in
            this.placeholder = placeHolder
            this.isSecureTextEntry = isSecureTextEntry
            this.keyboardType = .emailAddress
        }
        alert.addAction(cancelAction)
        
        let okAction = UIAlertAction(title: buttonTitle, style: UIAlertAction.Style.default) { _ in handler(alert.textFields?[0].text ?? "") }
        alert.addAction(okAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    // 다중버튼 액션시트
    func showMultiButtonAlert(title: String, message: String, buttonTitles: [String], handler: @escaping ((String) -> Void), cancelHandler: @escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.actionSheet)
        
        for title in buttonTitles {
            let action = UIAlertAction(title: title, style: UIAlertAction.Style.default) { (_) in handler(title) }
            alert.addAction(action)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler : cancelHandler )
        alert.addAction(cancelAction)
        
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            
            topController.present(alert, animated: true, completion: nil)
        }
    }
    
    // 닉네임 검증
    public func validateNickName(nickName: String) -> (Bool, String) {
        
        if(nickName.count <= 0) { return (false, "닉네임을 입력해 주세요") }
        if(nickName.count > 20) { return (false, "아이디는 20자 까지만 입력이 가능합니다") }
        
        return (true, "")
    }
    
    // 아이디 검증
    public func validateId(id: String) -> (Bool, String) {
        
        if(id.count <= 0) { return (false, "아이디를 입력해 주세요") }
        if(id.count < 5) { return (false, "아이디는 5자 이상 입력해 주세요") }
        if(id.count > 20) { return (false, "아이디는 20자 까지만 입력이 가능합니다") }
        if(!self.checkString(text: id, pattern: "[a-z0-9_-]")) {
            return (false, "아이디는 영문 소문자와 숫자, '_', '-' 특수기호만 입력이 가능합니다")
        }
        
        return (true, "")
    }
    
    // 비밀번호 검증
    public func validatePassword(password: String) -> (Bool, String) {
        
        var validateCount = 0
        
        if(password.count <= 0) { return (false, "비밀번호를 입력해 주세요") }
        if(password.count < 8) { return (false, "비밀번호는 8자 이상 입력해 주세요") }
        if(password.count >= 8 && password.count < 10) {
            if(self.checkString(text: password, pattern: "[A-Z]")) { validateCount = validateCount + 1}
            if(self.checkString(text: password, pattern: "[a-z]")) { validateCount = validateCount + 1}
            if(self.checkString(text: password, pattern: "[0-9]")) { validateCount = validateCount + 1}
            if(self.checkString(text: password, pattern: "[`~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?]")) { validateCount = validateCount + 1}
            
            if validateCount >= 3 { return (true, "") }
            else { return (false, "비밀번호는 영문 대,소문자, 숫자, 특수문자를 3가지이상 조합해서 사용해야 합니다") }
        }
        
        if(password.count >= 10) {
            if(self.checkString(text: password, pattern: "[A-Z]")) { validateCount = validateCount + 1 }
            if(self.checkString(text: password, pattern: "[a-z]")) { validateCount = validateCount + 1 }
            if(self.checkString(text: password, pattern: "[0-9]")) { validateCount = validateCount + 1 }
            if(self.checkString(text: password, pattern: "[`~!@#$%^&*()\\-_=+\\[{\\]}\\\\|;:'\",<.>/?]")) { validateCount = validateCount + 1 }
            
            if validateCount >= 2 { return (true, "") }
            else { return (false, "비밀번호는 영문 대,소문자, 숫자, 특수문자를 2가지이상 조합해서 사용해야 합니다") }
        }
        
        return (false, "비밀번호를 입력해 주세요")
    }
    
    // 정규식 확인기능
    private func checkString(text: String, pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let list = regex.matches(in:text, options: [], range:NSRange.init(location: 0, length:text.count))
        if(list.count > 0) { return true }
        return false
    }
    
    // 랜덤스트링 생성
    func randomString(length: Int) -> String {
        let stringSet = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"

        var randonString = ""

        for _ in 0 ..< length {
            let r = Int(arc4random_uniform(UInt32(stringSet.count)))
            randonString += String(stringSet[stringSet.index(stringSet.startIndex, offsetBy: r)])
        }

        return randonString
    }
}

