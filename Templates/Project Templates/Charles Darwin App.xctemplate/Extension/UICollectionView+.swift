//___FILEHEADER___

import Foundation
import UIKit


extension UICollectionView {
    func registerCellNibFromClass(_ `class`: UICollectionViewCell.Type, bundle: Bundle? = nil) {
        register(UINib(nibName: `class`.pureName, bundle: bundle),
                 forCellWithReuseIdentifier: `class`.pureName)
    }
    
    func dequeueCellFromClass<T: UICollectionViewCell>(_ `class`: T.Type, `for` indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: `class`.pureName, for: indexPath) as! T
    }
    
    func registerSupplementaryViewNibFromClass(_ `class`: UICollectionReusableView.Type, ofKind: String, bundle: Bundle? = nil) {
        register(UINib(nibName: `class`.pureName, bundle: bundle),
                 forSupplementaryViewOfKind: ofKind,
                 withReuseIdentifier: `class`.pureName)
    }
    
    func dequeueSupplementaryFromClass<T: UICollectionReusableView>(_ `class`: T.Type, ofKind: String, indexPath: IndexPath) -> T {
        return dequeueReusableSupplementaryView(ofKind: ofKind,
                                                withReuseIdentifier: `class`.pureName,
                                                for: indexPath) as! T
    }
    
    func registerSupplementaryViewFromStyle<T: CDNibLoadEnumProtocol>(_ style: T, ofKind: String, bundle: Bundle? = nil) {
        register(UINib(nibName: style.nibName, bundle: bundle),
                 forSupplementaryViewOfKind: ofKind,
                 withReuseIdentifier: style.nibName)
    }
    
    func dequeueSupplementaryFromStyle<T: CDNibLoadEnumProtocol>(_ style: T, ofKind: String, indexPath: IndexPath) -> T.MetaClass {
        return dequeueReusableSupplementaryView(ofKind: ofKind,
                                                withReuseIdentifier: style.nibName,
                                                for: indexPath) as! T.MetaClass
    }
    
    func registerCellNibFromStyle<T: CDNibLoadEnumProtocol>(_ style: T, bundle: Bundle? = nil) {
        register(UINib(nibName: style.nibName, bundle: bundle),
                 forCellWithReuseIdentifier: style.nibName)
    }
    
    func dequeueCellFromCellStyle<T: CDNibLoadEnumProtocol>(_ style: T, `for` indexPath: IndexPath) -> T.MetaClass {
        return dequeueReusableCell(withReuseIdentifier: style.nibName, for: indexPath) as! T.MetaClass
    }
}
