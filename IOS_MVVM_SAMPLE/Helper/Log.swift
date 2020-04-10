import Foundation

enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

class Log {
    
    // 1. The date formatter
    static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS" // Use your own
    static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    // 에러로그
    class func e(_ message: Any
        , fileName: String = #file
        , line: Int = #line
        , column: Int = #column
        , funcName: String = #function) {
        
        #if DEBUG
        Swift.print("-------------------------------------------------------------")
        Swift.print("\(LogEvent.e.rawValue) [\(Date().toString()) ] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        Swift.print("-------------------------------------------------------------")
        #endif
    }
    
    // 디버그로그
    class func d(_ message: Any
        , fileName: String = #file
        , line: Int = #line
        , column: Int = #column
        , funcName: String = #function) {
        
        #if DEBUG
        Swift.print("-------------------------------------------------------------")
        Swift.print("\(LogEvent.d.rawValue) [\(Date().toString()) ] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        Swift.print("-------------------------------------------------------------")
        #endif
    }
    
    // 위험로그
    class func w(_ message: Any
        , fileName: String = #file
        , line: Int = #line
        , column: Int = #column
        , funcName: String = #function) {
        
        #if DEBUG
        Swift.print("-------------------------------------------------------------")
        Swift.print("\(LogEvent.w.rawValue) [\(Date().toString()) ] [\(sourceFileName(filePath: fileName))]:\(line) \(column) \(funcName) -> \(message)")
        Swift.print("-------------------------------------------------------------")
        #endif
    }
    
    // 파일이름 추출
    private class func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
}

// 2. The Date to String extension
extension Date {
    func toString() -> String {
        return Log.dateFormatter.string(from: self as Date)
    }
}
