//___FILEHEADER___

import Foundation

private let kCDInputtingPhonePattern = "1?\\d{0,10}"
private let kCDInputtingCatePattern = "[0-9]{0,6}"
private let kCDIsPhonePattern = "1\\d{10}"
private let kCDIsCatePattern = "[0-9]{6}"
private let kCDIsPasswordPattern = ".{6,18}"
private let kCDInputtingPasswordPattern = ".{0,18}"
private let kCDIsAlphaDigitPassword = "([0-9]|[a-zA-Z]){6,18}"

extension String /* Validate */ {
    
    private func validate(with pattern: String) -> Bool {
        return NSPredicate(format: "SELF MATCHES %@", pattern).evaluate(with: self)
    }
    
    var validatePhone: Bool {
        return validate(with: kCDInputtingPhonePattern)
    }
    
    var isPhone: Bool {
        return validate(with: kCDIsPhonePattern)
    }
    
    var isCate: Bool {
        return validate(with: kCDIsCatePattern)
    }
    
    var validateCate: Bool {
        return validate(with: kCDInputtingCatePattern)
    }
    
    var validatePassword: Bool {
        return validate(with: kCDInputtingPasswordPattern)
    }
    
    var isPassword: Bool {
        return validate(with: kCDIsPasswordPattern)
    }
    
    var isAlphaDigitOnlyPassword: Bool {
        return validate(with: kCDIsAlphaDigitPassword)
    }
}


extension String {
    var api: String {
        return "https://api.github.com/\(self)"
    }
    
    static let defaultDateFormat = "YYYY-MM-dd HH:mm"
    
    func format(_ args: CVarArg...) -> String {
        return String(format: self, arguments: args)
    }
    
    func format(_ args: [CVarArg] = [], `default`: [NSAttributedStringKey: Any]? = nil, attributes: [NSAttributedStringKey: Any]?...) -> NSAttributedString {
        return NSAttributedString.from(format: self, arguments: args, default: `default`, attributes: attributes) ?? NSAttributedString()
    }
    
    func date(_ date: Date) -> String {
        let format = DateFormatter()
        format.dateFormat = self
        return format.string(from: date)
    }
}
