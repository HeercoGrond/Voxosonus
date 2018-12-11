import Foundation

let fileManager = FileManager.default;

let documentsDirectoryPathString = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
let documentsDirectoryPath = NSURL(string: documentsDirectoryPathString)!

let jsonFilePath = documentsDirectoryPath.appendingPathComponent("/dataset.json")
var isDirectory: ObjCBool = false

if !fileManager.fileExists(atPath: jsonFilePath!.absoluteString, isDirectory: &isDirectory) {
    let created = fileManager.createFile(atPath: jsonFilePath!.absoluteString, contents: nil, attributes: nil)
    if created {
        print("File created ")
    } else {
        print("Couldn't create file for some reason")
    }
} else {
    print("File already exists")
}

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
        
        let valid = JSONSerialization.isValidJSONObject(newJson)
        if(valid) {
            let jsonData =  try JSONSerialization.data(withJSONObject: newJson, options: [])
            let jsonString = String(data: jsonData, encoding: String.Encoding.utf8)
            print(jsonString)
            
            do {
                let file = try FileHandle(forWritingTo: jsonFilePath!)
                file.write(jsonData)
                print("JSON data was written to the file successfully!")
            } catch let error as NSError {
                print("Couldn't write to file: \(error.localizedDescription)")
            }
        }
        
        
        
        
    } catch {
        print("crashed")
        print(error)
        // handle error
    }
}
