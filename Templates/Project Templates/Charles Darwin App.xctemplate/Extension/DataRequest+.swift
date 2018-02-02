//___FILEHEADER___

import Foundation
import Alamofire
import SwiftyJSON


extension DataRequest {
    @discardableResult
    func responseSwifty(queue: DispatchQueue? = nil,
                         options: JSONSerialization.ReadingOptions = .allowFragments,
                         completion: @escaping (JSON) -> Void)
        -> Self {
            return response(queue: queue, responseSerializer: DataRequest.jsonResponseSerializer()) { (response) in
                guard let value = response.result.value else { return }
                let json = JSON(value)
                #if DEBUG
                    print(json)
                #endif
                completion(json)
            }
    }
}
