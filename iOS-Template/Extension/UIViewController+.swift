//___FILEHEADER___

import UIKit
import Alamofire


extension UIViewController {
    class func instance() -> Self {
        let name = String.init(describing: self)
        return genericGateway(self, storyboardOrNibName: name)
    }
    
    private class func genericGateway<T: UIViewController>(_ type: T.Type, storyboardOrNibName name: String) -> T {
        if Bundle.main.path(forResource: name, ofType: "nib") != nil {
            return T(nibName: name, bundle: nil)
        } else {
            return UIStoryboard(name: name, bundle: nil).instantiateInitialViewController() as! T
        }
    }
    
    var isCurrent: Bool {
        return isViewLoaded && view.window != nil
    }
    
    var furtherNavigationController: UINavigationController? {
        return tabBarController?.furtherNavigationController ?? navigationController?.furtherNavigationController ?? navigationController
    }
}



























