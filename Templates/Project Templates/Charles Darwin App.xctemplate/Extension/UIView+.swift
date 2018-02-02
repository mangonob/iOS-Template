//___FILEHEADER___

import UIKit

extension UIView {
    func toImage() -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, true, UIScreen.main.scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        layer.render(in: context)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
}

extension UIView {
    class func loadFromXib() -> Self {
        return genericLoadFromXib(type: self)
    }
    
    private class func genericLoadFromXib<T: UIView>(type: T.Type) -> T {
        let nibName = String(describing: type)
        return UINib(nibName: nibName, bundle: nil).instantiate(withOwner: nil, options: nil).first as! T
    }
}

extension UIView {
    var posterityViews: [UIView] {
        get {
            return subviews.count == 0 ? [UIView]() : subviews.flatMap { $0.posterityViews + [$0] }
        }
    }
}
