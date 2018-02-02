//___FILEHEADER___

import UIKit
import Mantle
import Alamofire


extension Notification.Name {
    static let ___VARIABLE_CLASS_PREFIX___AuthorizationInvalidated = Notification.Name(rawValue: "AE508EA119CA65A04941578E7F3EBA04")
}


class ___VARIABLE_CLASS_PREFIX___Model: MTLModel, MTLJSONSerializing {
    class func jsonKeyPathsByPropertyKey() -> [AnyHashable : Any]! {
        return nil
    }
    
    class func jsonTransformer(forKey key: String!) -> ValueTransformer! {
        return nil
    }
    
    /**
     * build an authorized request */
    @discardableResult
    class func request(
    _ url: URLConvertible,
    method: HTTPMethod = .get,
    parameters: Parameters? = nil,
    encoding: ParameterEncoding = URLEncoding.default,
    headers: HTTPHeaders? = nil) -> DataRequest {
        var authorizationHeaders: HTTPHeaders = [:]
        
        if let token = ___VARIABLE_CLASS_PREFIX___Account.shared.token, !token.isEmpty {
            authorizationHeaders["Authorization"] = "token \(token)"
        }
        
        headers?.forEach { authorizationHeaders[$0.key] = $0.value }
        
        return Alamofire.request(url, method: method, parameters: parameters, encoding: encoding, headers: authorizationHeaders)
            .response(completionHandler: { (response) in
                guard let statusCode = response.response?.statusCode else { return }
                
                switch statusCode {
                case 401:
                    NotificationCenter.default.post(name: .___VARIABLE_CLASS_PREFIX___AuthorizationInvalidated, object: nil)
                default:
                    break
                }
            })
    }
}


extension NSObject {
    var mstring: String? {
        return self as? String
    }
    
    var mstringValue: String {
        return mstring ?? ""
    }
    
    var mbool: Bool? {
        return self as? Bool
    }
    
    var mboolValue: Bool {
        return mbool ?? mnumberValue.boolValue
    }
    
    var mnumber: NSNumber? {
        return self as? NSNumber
    }
    
    var mnumberValue: NSNumber {
        return mnumber ?? NSNumber(value: 0)
    }
}


extension NSObject /* NSNumber */ {
    var mintValue: Int {
        return mnumberValue.intValue
    }
    
    var mint8Value: Int8 {
        return mnumberValue.int8Value
    }
    
    var mint16Value: Int16 {
        return mnumberValue.int16Value
    }
    
    var mint32Value: Int32 {
        return mnumberValue.int32Value
    }
    
    var mint64Value: Int64 {
        return mnumberValue.int64Value
    }
    
    var muintValue: UInt {
        return mnumberValue.uintValue
    }
    
    var muint8Value: UInt8 {
        return mnumberValue.uint8Value
    }
    
    var muint16Value: UInt16 {
        return mnumberValue.uint16Value
    }
    
    var muint32Value: UInt32 {
        return mnumberValue.uint32Value
    }
    
    var muint64Value: UInt64 {
        return mnumberValue.uint64Value
    }
    
    var mfloatValue: Float {
        return mnumberValue.floatValue
    }
    
    var mdoubleValue: Double {
        return mnumberValue.doubleValue
    }
}


extension NSAttributedString {
    fileprivate class Lexer {
        enum LexerError: Error {
            case matchError
            case lexerEnd
            case undefine
        }
        
        var string: String
        var currentIndex: Int = 0
        
        func reset() {
            currentIndex = 0
        }
        
        init(_ string: String) {
            self.string = string
        }
        
        var isEnd: Bool {
            return currentIndex >= string.count
        }
        
        var top: Character {
            if currentIndex >= 0 && currentIndex < string.count {
                return string[string.index(string.startIndex, offsetBy: currentIndex)]
            } else {
                return Character("#")
            }
        }
        
        @discardableResult
        func pop() throws -> Character {
            let result = top
            try match(String(result))
            return result
        }
        
        func match(_ token: String) throws {
            let token = Character(token)
            
            if top == token {
                if currentIndex >= string.count {
                    throw LexerError.lexerEnd
                }
                currentIndex += 1
            } else {
                throw LexerError.matchError
            }
        }
    }
    
    fileprivate class ASCompiler {
        var lexer: Lexer
        var args: [[NSAttributedStringKey: Any]?]
        var defaultAttribute: [NSAttributedStringKey: Any]?
        
        enum CompilerError: Error {
            case badString
            case unexceptToken(Character)
        }
        
        var attributeIndex: Int = 0
        var currentAttribute: [NSAttributedStringKey: Any]? {
            return args[attributeIndex] ?? defaultAttribute
        }
        
        var mutableAttributeString = NSMutableAttributedString()
        
        func reset() {
            lexer.reset()
            attributeIndex = 0
            mutableAttributeString = NSMutableAttributedString()
        }
        
        func popAttribute() -> [NSAttributedStringKey: Any]? {
            var result: [NSAttributedStringKey: Any]?
            if attributeIndex >= 0 && attributeIndex < args.count {
                result = args[attributeIndex]
                attributeIndex += 1
            }
            return result
        }
        
        init(format: String, `default`: [NSAttributedStringKey: Any]?, args: [[NSAttributedStringKey: Any]?]) {
            lexer = Lexer.init(format)
            
            self.args = args
            defaultAttribute = `default`
        }
        
        func string() throws -> String {
            var result = ""
            
            if (lexer.top == "[" || lexer.top == "]") {
                throw CompilerError.unexceptToken(lexer.top)
            }
            
            do {
                while !(lexer.top == "[" || lexer.top == "]") {
                    if lexer.top == "\\" {
                        try lexer.pop()
                        if (lexer.top == "[" || lexer.top == "]") {
                            result.append(try lexer.pop())
                        } else {
                            result.append("\\")
                        }
                    } else {
                        result.append(try lexer.pop())
                    }
                }
            } catch Lexer.LexerError.lexerEnd {
            }
            
            return result
        }
        
        func unit() throws {
            let top = lexer.top
            if top == "[" {
                try attribute()
            } else {
                let str = try string()
                mutableAttributeString.append(NSAttributedString(string: str, attributes: defaultAttribute))
            }
        }
        
        func result() throws {
            while !lexer.isEnd {
                try unit()
            }
        }
        
        func attribute() throws {
            try lexer.match("[")
            if lexer.top == "]" {
                try lexer.match("]")
            } else {
                let str = try string()
                mutableAttributeString.append(NSAttributedString(string: str, attributes: popAttribute()))
                try lexer.match("]")
            }
        }
    }
    
    class func from(format: String, arguments: [CVarArg] = [], `default`: [NSAttributedStringKey: Any]? = nil, attributes: [[NSAttributedStringKey: Any]?]) -> NSAttributedString? {
        do {
            let compiler = ASCompiler(format: String(format: format, arguments: arguments), default: `default`, args: attributes)
            try compiler.result()
            return compiler.mutableAttributeString
        } catch _ {
            return nil
        }
    }
    
    class func from(format: String, arguments: [CVarArg] = [], `default`: [NSAttributedStringKey: Any]? = nil, attributes: [NSAttributedStringKey: Any]?...) -> NSAttributedString? {
        return from(format: format, arguments: arguments, default: `default`, attributes: attributes)
    }
}












