//___FILEHEADER___

import Foundation
import UIKit


fileprivate var pool = [UIAlertView: [UIAlertViewAction]]()

class UIAlertViewManager: NSObject, UIAlertViewDelegate {
    private static var _shared = UIAlertViewManager()
    
    static var shared: UIAlertViewManager {
        return _shared
    }
    
    func alertView(_ alertView: UIAlertView, didDismissWithButtonIndex buttonIndex: Int) {
        defer { pool[alertView] = nil }
        
        guard buttonIndex < alertView.count else { return }
        
        alertView.actions[buttonIndex].action?(buttonIndex)
    }
}

class UIAlertViewAction: NSObject {
    var action: ((Int) -> ())?
    var title: String
    
    init(title: String, _ action: ((Int) -> ())?) {
        self.title = title
        self.action = action
    }
}

extension UIAlertView {
    fileprivate var count: Int {
        if let actions = pool[self] {
            return actions.count
        }
        
        return 0
    }
    
    fileprivate var actions: [UIAlertViewAction] {
        get {
            if let actions = pool[self] {
                return actions
            }
            
            let actions = [UIAlertViewAction]()
            pool[self] = actions
            return actions
        }
        set {
            pool[self] = newValue
        }
    }
    
    fileprivate subscript(i: Int) -> UIAlertViewAction {
        if let actions = pool[self] {
            assert(i >= 0)
            assert(i < actions.count)
            
            return actions[i]
        }
        
        fatalError("Error Index \(#file) \(#line) \(#function)")
    }
    
    func addAction(_ action: UIAlertViewAction) {
        addButton(withTitle: action.title)
        
        delegate = UIAlertViewManager.shared
        
        actions.append(action)
    }
}

































