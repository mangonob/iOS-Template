//___FILEHEADER___

import Foundation

extension NSNumber {
    var memerySize: String? {
        let size = floatValue
        switch int64Value {
        case 0..<1024:
            return String(format: "%.2fB", size)
        case 1024..<(1024 * 1024):
            return String(format: "%.2fKB", size / 1024)
        case (1024 * 1024)..<(1024 * 1024 * 1024):
            return String(format: "%.2fMB", size / (1024 * 1024))
        case (1024 * 1024 * 1024)..<(1024 * 1024 * 1024 * 1024):
            return String(format: "%.2fMB", size / (1024 * 1024 * 1024))
        default:
            return nil
        }
    }
}


extension Double {
    var effectiveN: Int {
        return floor(self) == self ? 0 : 2
    }
    
    var formattedDateString: String {
        return String.defaultDateFormat.date(Date(timeIntervalSince1970: self / 1000))
    }
}
