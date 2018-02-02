//___FILEHEADER___

import Foundation
import UIKit


public protocol SwiftAwake: class {
    static func awake()
}


fileprivate class SwiftAwakeFactory {
    static func awakeAllClass() {
        /** fetch count of all classes */
        let count = Int(objc_getClassList(nil, 0))
        
        /** alloc and free memories */
        let classes = UnsafeMutablePointer<AnyClass>.allocate(capacity: count)
        defer { classes.deallocate(capacity: count) }
        
        /** get class list */
        let autoreleasingClasses = AutoreleasingUnsafeMutablePointer<AnyClass>(classes)
        objc_getClassList(autoreleasingClasses, Int32(count))
        
        for index in 0..<count {
            (classes[index] as? SwiftAwake.Type)?.awake()
        }
    }
}


extension UIApplication {
    private static let invokeAwakeTestOnce: Void = {
        SwiftAwakeFactory.awakeAllClass()
    }()
    
    open override var next: UIResponder? {
        UIApplication.invokeAwakeTestOnce
        return super.next
    }
}
