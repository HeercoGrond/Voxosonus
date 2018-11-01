//
//  LanguageAnalyzer.swift//
//  Created by Heerco Grond on 22-05-18.
//  Copyright © 2018 Heerco Grond. All rights reserved.
//

import Foundation
import CoreML

class LanguageAnalyzer: NSObject {
    
    weak var delegate: LanguageAnalyzerDelegate!
    
    // Creation of shared instance for use.
    private static var sharedLanguageAnalyzer: LanguageAnalyzer = {
        let languageAnalyzer = LanguageAnalyzer();
        
        return languageAnalyzer
    }()
    
    // Return sharedInstance of LanguageAnalyzer to adhere to singleton pattern
    class func sharedInstance() -> LanguageAnalyzer {
        return sharedLanguageAnalyzer
    }
    
    // Variables
    var model = VoxosonusMLModel()
    var _tagDictionary: [String] = []
    
    override init (){
        super.init()
    }
    
    func addTag(_ tag: String){
        if(!_tagDictionary.contains(tag)){
            _tagDictionary.append(tag);
        }
    }
    
    func addTags(_ tags: [String]){
        for tag in tags {
            addTag(tag)
        }
    }
    
    func removeTag(_ tag: String){
        _tagDictionary = _tagDictionary.filter { $0 != tag }
    }
    
    func removeTags(_ tags: [String]){
        for tag in tags {
            removeTag(tag)
        }
    }
    
    func analyze(_ sentence: String) {
        let input = VoxosonusMLModelInput(text: sentence)

        do {
            let modelPrediction = try model.prediction(input: input)
            let predictedLabel = modelPrediction.label
            
            
            if(_tagDictionary.contains(predictedLabel)){
                delegate.labelFound(predictedLabel)
            }
        } catch {
            print(error)
        }
    }
    
    func debug() {
        analyze("the quick brown fox jumped over the lazy dog")
    }
}

protocol LanguageAnalyzerDelegate: class {
    func labelFound(_ label: String)
    func labelsFound(_ labels: [String])
}
