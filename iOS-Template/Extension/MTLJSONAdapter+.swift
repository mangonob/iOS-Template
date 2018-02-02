//___FILEHEADER___

import Foundation
import Mantle
import SwiftyJSON

typealias MTLJSONAdapter = Mantle.MTLJSONAdapter
typealias JSON = SwiftyJSON.JSON


extension MTLJSONAdapter {
    class func gtmodels<T: GTModel>(_ : T.Type, _ json: JSON) -> [T]? {
        return (try? MTLJSONAdapter.models(of: T.self, fromJSONArray: json.arrayObject)) as? [T]
    }
    
    class func gtmodel<T: GTModel>(_ : T.Type, _ json: JSON) -> T? {
        return (try? MTLJSONAdapter.model(of: T.self, fromJSONDictionary: json.dictionaryObject)) as? T
    }
}
