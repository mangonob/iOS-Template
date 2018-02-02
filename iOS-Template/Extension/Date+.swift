//___FILEHEADER___

import Foundation

extension Date {
    func formatter(_ format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
