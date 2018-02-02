//___FILEHEADER___

import UIKit
import Foundation

private let ATTRIBUTE_TITLE_KEY = "attributedTitle"
private let ATTRIBUTE_MESSAGE_KEY = "attributedMessage"

extension UIAlertController {
    var attribTitle: NSAttributedString? {
        get {
            return value(forKey: ATTRIBUTE_TITLE_KEY) as? NSAttributedString
        }
        set {
            setValue(newValue, forKey: ATTRIBUTE_TITLE_KEY)
        }
    }
    
    var attribMessage: NSAttributedString? {
        get {
            return value(forKey: ATTRIBUTE_MESSAGE_KEY) as? NSAttributedString
        }
        set {
            setValue(newValue, forKey: ATTRIBUTE_MESSAGE_KEY)
        }
    }
}


extension UIAlertAction {
    var attribTitle: NSAttributedString? {
        get {
            return value(forKey: ATTRIBUTE_TITLE_KEY) as? NSAttributedString
        }
        set {
            setValue(newValue, forKey: ATTRIBUTE_TITLE_KEY)
        }
    }
    
    var attribMessage: NSAttributedString? {
        get {
            return value(forKey: ATTRIBUTE_TITLE_KEY) as? NSAttributedString
        }
        set {
            setValue(newValue, forKey: ATTRIBUTE_TITLE_KEY)
        }
    }
}
