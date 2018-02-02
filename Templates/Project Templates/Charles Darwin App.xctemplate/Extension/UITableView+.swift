//___FILEHEADER___

import Foundation
import UIKit


protocol CDNibLoadEnumProtocol {
    associatedtype MetaClass: NSObject
    
    var rawValue: String { get }
    var nibName: String { get }
}

extension CDNibLoadEnumProtocol {
    var nibName: String {
        let titleCharacters = String(
            rawValue.enumerated()
                .map { $0.offset == 0 ? Character(String($0.element).uppercased()) : $0.element }
        )
        return "\(MetaClass.pureName)Style\(titleCharacters)"
    }
}

extension UITableView {
    func registerCellNibFromClass(_ `class`: UITableViewCell.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: `class`.pureName, bundle: bundle),
                 forCellReuseIdentifier: `class`.pureName)
    }
    
    func dequeueCellFromClass<T: UITableViewCell>(_ `class`: T.Type, `for` indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: `class`.pureName, for: indexPath) as! T
    }
    
    func registerHeaderFooterNibFromClass(_ `class`: UITableViewHeaderFooterView.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: `class`.pureName, bundle: bundle),
                 forHeaderFooterViewReuseIdentifier: `class`.pureName)
    }
    
    func dequeueHeaderFooterFromClass<T: UITableViewHeaderFooterView>(_ `class`: T.Type) -> T {
        return dequeueReusableHeaderFooterView(withIdentifier: `class`.pureName) as! T
    }
    
    func registerCellNibFromStyle<T: CDNibLoadEnumProtocol>(_ style: T, bundle: Bundle? = nil) {
        register(UINib(nibName: style.nibName, bundle: bundle), forCellReuseIdentifier: style.nibName)
    }
    
    func dequeueCellFromCellStyle<T: CDNibLoadEnumProtocol>(_ style: T, `for` indexPath: IndexPath) -> T.MetaClass {
        return dequeueReusableCell(withIdentifier: style.nibName, for: indexPath) as! T.MetaClass
    }
}
