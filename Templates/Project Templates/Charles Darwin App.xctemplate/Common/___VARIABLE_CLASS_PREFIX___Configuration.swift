//___FILEHEADER___

import UIKit


private let k___VARIABLE_CLASS_PREFIX___ConfigurationStoragePath = "\(NSHomeDirectory())/Documents/Configurations.archive"

class ___VARIABLE_CLASS_PREFIX___Configuration: ___VARIABLE_CLASS_PREFIX___Model {
    static let applicationSecret = "Something mess."
    
    private static var _shared: ___VARIABLE_CLASS_PREFIX___Configuration!
    static var shared: ___VARIABLE_CLASS_PREFIX___Configuration {
        get {
            if _shared == nil {
                _shared = (NSKeyedUnarchiver.unarchiveObject(withFile: k___VARIABLE_CLASS_PREFIX___ConfigurationStoragePath) as? ___VARIABLE_CLASS_PREFIX___Configuration) ?? ___VARIABLE_CLASS_PREFIX___Configuration()
                
                NotificationCenter.default.addObserver(forName: .UIApplicationWillTerminate, object: nil, queue: nil, using: { (_) in
                    NSKeyedArchiver.archiveRootObject(self.shared, toFile: k___VARIABLE_CLASS_PREFIX___ConfigurationStoragePath)
                })
            }
            
            return _shared
        }
    }
}
