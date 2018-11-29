import Foundation

if let path = Bundle.main.path(forResource: "dataset", ofType: "json") {
    do {
        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
        
        print("doing thign")
        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
        let result = jsonResult as? [Any]
        
        //print(result)
        
        var newJson: [Any] = []
        
        for intentDict in result! {
            if let dict = intentDict as? [String: Any] {
                let label = dict["intent"] as! String
                let utterances = dict["utterances"] as! [String]
                
                for utterance in utterances {
                    let object: [String: Any] = [
                        "label": label,
                        "text": utterance
                    ]
                    
                    newJson.append(object)
                }
            }
        }
        
        print(newJson)
        let valid = JSONSerialization.isValidJSONObject(newJson)
        print(valid)
        
        
    } catch {
        print("crashed")
        print(error)
        // handle error
    }
}
