//___FILEHEADER___

import Foundation
import Alamofire


extension NSObject {
    class func propertieNames() -> [String] {
        var count:UInt32 = 0
        let properties = class_copyPropertyList(self, &count)
        
        return Array(UnsafeBufferPointer(start: properties, count: Int(count))).map { (p) -> String in
            return String(utf8String: property_getName(p)) ?? ""
        }
    }
    
    class var pureName: String {
        return String(describing: self)
    }
}


/** request pool */
extension NSObject {
    private struct AssociateKeys {
        static var requestPool = "requestPoolName"
    }
    
    private var requestPool: [Request] {
        get {
            var pool: [Request]! = objc_getAssociatedObject(self, &AssociateKeys.requestPool) as? [Request]
            
            if pool == nil {
                pool = [Request]()
                self.requestPool = pool
            }
            
            return pool
        }
        
        set {
            objc_setAssociatedObject(self, &AssociateKeys.requestPool, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    func registerRequest(_ request: Request) {
        if requestPool.contains(where: { $0 === request }) { return }
        
        requestPool.append(request)
    }
    
    func resignAllRequest() {
        requestPool.forEach { $0.cancel() }
    }
}
