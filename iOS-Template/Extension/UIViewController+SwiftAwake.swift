//___FILEHEADER___

import Foundation
import UIKit


extension UIViewController: SwiftAwake {
    private static let exchangeNativeImplementOnce: Void = {
        /** exchange viewDidLoad implementation */
        var nativeImplementation: Method! = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewDidLoad))
        var customImplementation: Method! = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.replacementViewDidLoad))
        method_exchangeImplementations(nativeImplementation, customImplementation)
        
        /** exchange viewDidAppear(_:) implementation */
        nativeImplementation = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewDidAppear(_:)))
        customImplementation = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.replacementViewDidAppear(_:)))
        method_exchangeImplementations(nativeImplementation, customImplementation)
        
        /** exchange viewWillAppear(_:) implementation */
        nativeImplementation = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.viewWillAppear(_:)))
        customImplementation = class_getInstanceMethod(UIViewController.self, #selector(UIViewController.replacementViewWillAppear(_:)))
        method_exchangeImplementations(nativeImplementation, customImplementation)
    }()
    
    @objc fileprivate func replacementViewDidLoad() {
        self.replacementViewDidLoad()
        
//        navigationItem.leftBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "common_no_image").withRenderingMode(.alwaysOriginal), style: .done, target: self, action: #selector(self.popAction(_:)))
    }
    
    @objc fileprivate func replacementViewDidAppear(_ animated: Bool) {
        self.replacementViewDidAppear(animated)
        
        if let navigationController = navigationController {
            if navigationController.viewControllers.count == 1 && navigationController.topViewController == self {
                navigationController.interactivePopGestureRecognizer?.isEnabled = false
            }
        }
    }
    
    @objc fileprivate func replacementViewWillAppear(_ animated: Bool) {
        self.replacementViewWillAppear(animated)
        
        navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = self
        
        if let nav = navigationController {
            var hidden: Bool?
            
            if navigationBarOption.contains(.always) {
                hidden = false
            } else if navigationBarOption.contains(.never) {
                hidden = true
            }
            
            if let hidden = hidden {
                nav.setNavigationBarHidden(hidden, animated: !navigationBarOption.contains(.noAnimation))
            }
        }
    }
    
    public static func awake() {
        self.exchangeNativeImplementOnce
    }
    
    
    // MARK: - Action
//    @objc private func popAction(_ sender: UIBarButtonItem) {
//        navigationController?.popViewController(animated: true)
//    }
}


/** adopt UIGestureRecognizerDelegate */
extension UIViewController: UIGestureRecognizerDelegate {
}


extension UIViewController {
    private struct PropertyKey {
        static var navigationBarOptionKey = "KnavigationBarOption"
    }
    
    struct NavigationBarOption: OptionSet {
        typealias RawValue = UInt
        
        var rawValue: UInt
        
        init(rawValue: UInt) {
            self.rawValue = rawValue
        }
        
        static let always = NavigationBarOption(rawValue: 1 << 0)
        static let never = NavigationBarOption(rawValue: 1 << 1)
        static let unspecified = NavigationBarOption(rawValue: 1 << 2)
        static let noAnimation = NavigationBarOption(rawValue: 1 << 3)
    }
    
    var navigationBarOption: NavigationBarOption {
        get {
            var option: NavigationBarOption! = objc_getAssociatedObject(self, &PropertyKey.navigationBarOptionKey) as? NavigationBarOption
            
            if option == nil {
                option = .unspecified
                self.navigationBarOption = option
            }
            
            return option
        }
        set {
            objc_setAssociatedObject(self, &PropertyKey.navigationBarOptionKey, newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        }
    }
}
