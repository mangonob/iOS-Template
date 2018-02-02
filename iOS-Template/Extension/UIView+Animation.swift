//___FILEHEADER___

import UIKit

extension UIView {
    func shake(duration: CFTimeInterval, distance: CGFloat, times: Float) {
        layer.removeAllAnimations()
        
        let shakeAni = CAKeyframeAnimation(keyPath: "transform.translation.x")
        shakeAni.duration = duration
        shakeAni.keyTimes = [0, NSNumber(value: 1/3.0), NSNumber(value: 2/3.0), 1]
        shakeAni.values = [0, -distance, distance, 0]
        shakeAni.repeatCount = times
        
        layer.add(shakeAni, forKey: nil)
    }
}

