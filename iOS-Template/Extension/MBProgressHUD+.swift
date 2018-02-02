//___FILEHEADER___

import Foundation
import MBProgressHUD


extension MBProgressHUD {
    enum WarningLevel: String {
        case success, info, warning, error
    }
    
    class func showWithLevel(_ level: WarningLevel, message: String? = nil, inView view: UIView? = nil) {
        guard let target = view ?? UIApplication.shared.keyWindow else { return }
        
        let hud = MBProgressHUD.showAdded(to: target, animated: true)
        
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        hud.mode = .customView
        imageView.image = UIImage(named: "common_\(level.rawValue)")
        hud.customView = imageView
        hud.label.text = message
        
        hud.hide(animated: true, afterDelay: 1.5)
    }
}
